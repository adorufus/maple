import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maple/services/database_service.dart';
import 'package:provider/provider.dart';

import '../../../services/local_storage_service.dart';
import '../../dashboard/providers/dashboard-providers.dart';

enum AuthType { google, apple, guest }

class AuthControllers {
  final AuthType authType;
  final BuildContext context;

  AuthControllers(this.authType, this.context);

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> doAuth() async {
    User? user;
    UserCredential? userCredential;

    Map<String, dynamic> data = {};

    switch (authType) {
      case AuthType.google:
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? gAccount = await googleSignIn.signIn();
        Map<String, dynamic> dat0 = {};

        if (gAccount != null) {
          GoogleSignInAuthentication gAuth = await gAccount.authentication;

          AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: gAuth.accessToken, idToken: gAuth.idToken);

          try {
            userCredential = await auth.signInWithCredential(credential);

            user = userCredential.user;

            String username = user!.email!.split('@')[0];

            var snapshot = await FirebaseDatabase.firestore
                .collection('users')
                .doc(user.uid)
                .get();

            if (!snapshot.exists) {
              await FirebaseDatabase.post(
                  reference: 'users',
                  doc: user.uid,
                  data: {
                    'email': user.email,
                    'is_first': true,
                    'user_id': user.uid,
                    'username': username,
                    'role': 'user',
                    'user_picture': user.photoURL,
                    'full_name': user.displayName
                  }).then((value) async {
                dat0 = {
                  "status": 'success',
                  "data": {
                    'email': user?.email,
                    'is_first': true,
                    'role': 'user',
                    'user_id': user?.uid,
                    'username': username,
                    'user_picture': user?.photoURL,
                    'full_name': user?.displayName
                  }
                };

                context.read<DashboardProviders>().setUsername(username);
                context.read<DashboardProviders>().setFullName(user?.displayName ?? '');

                await LocalStorageService.save('user', dat0);
              });
            } else {
              var userData = await FirebaseDatabase.getSingle(
                  collection: 'users', itemId: user.uid);

              dat0 = {'status': 'success', 'data': userData};

              context.read<DashboardProviders>().setUsername(username);
              context.read<DashboardProviders>().setFullName(user.displayName ?? '');

              await LocalStorageService.save('user', dat0);
              print('userData: ' + userData.toString());
            }
          } on FirebaseAuthException catch (e) {
            print(e.message);
            dat0 = {"status": 'failure', "data": e.message};
          }
        }

        data = dat0;

        break;
      case AuthType.apple:
        data = {
          "status": 'success',
          "data": {'is_first': true, 'username': 'apple'}
        };
        break;
      case AuthType.guest:
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Container()));
        data = {
          "status": 'success',
          "data": {'is_first': true, 'username': 'guest'}
        };
        context.read<DashboardProviders>().setUsername('guest');
        await LocalStorageService.save('user', data);
        break;
      default:
        data = {"status": 'failure', 'is_first': true, "data": "no such type"};
    }

    return data;
  }
}
