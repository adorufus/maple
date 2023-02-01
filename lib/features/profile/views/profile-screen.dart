import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maple/features/authentication/views/auth-screen.dart';
import 'package:maple/features/profile/views/about-screen.dart';
import 'package:maple/features/profile/views/edit-profile.dart';
import 'package:maple/services/database_service.dart';
import 'package:maple/services/local_storage_service.dart';
import 'package:maple/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../../services/analytics_service.dart';
import '../../dashboard/providers/dashboard-providers.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> userData = {};
  bool isLoading = false;

  ImagePicker picker = ImagePicker();
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  void initState() {
    isLoading = true;
    setState(() {});

    getUserData();

    super.initState();

    analytics.setCurrentScreen(screenName: "/dashboard/profile");
  }

  void getUserData() {
    LocalStorageService.load('user').then((value) {
      userData = value;
      isLoading = false;
      setState(() {});
      print(userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/back-button.png',
            color: Colors.white,
            width: 32.w,
            height: 32.h,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return CupertinoActionSheet(
                      title: Text('Settings'),
                      actions: [
                        CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile(
                                            userData: {
                                              'full_name': userData['data']
                                                  ['full_name'],
                                              'username': userData['data']
                                                  ['username'],
                                              'user_id': userData['data']
                                                  ['user_id']
                                            },
                                          ))).then((value) {
                                getUserData();
                              });
                            },
                            child: Text('Edit Profile')),
                        CupertinoActionSheetAction(
                            onPressed: () async {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (thisContext) {
                                    return CupertinoActionSheet(
                                      actions: [
                                        CupertinoActionSheetAction(
                                            onPressed: () async {
                                              changeProfilePict(
                                                  thisContext, 'camera');
                                            },
                                            child: Text('Take a picture')),
                                        CupertinoActionSheetAction(
                                            onPressed: () {
                                              changeProfilePict(
                                                  thisContext, 'gallery');
                                            },
                                            child: Text('Pick from gallery'))
                                      ],
                                    );
                                  });
                            },
                            child: Text('Change Profile Picture')),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return RatingDialog(
                                      title: Text(
                                        "How's Maple App?",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      submitButtonText: 'Rate',
                                      enableComment: true,
                                      force: false,
                                      onCancelled: () {
                                        Navigator.pop(context);
                                      },
                                      showCloseButton: true,
                                      message: Text(
                                        'Rate Maple App if you like it',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onSubmitted: (response) {},
                                    );
                                  });
                            },
                            child: Text('Rate Our App')),
                        CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutScreen()));
                            },
                            child: Text('About Maple')),
                        CupertinoActionSheetAction(
                          onPressed: () {
                            isLoading = true;
                            setState(() {});
                            FirebaseAuth.instance.signOut().then((value) {
                              LocalStorageService.deleteAll();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AuthScreen()),
                                  (route) => false);
                            }).catchError((err) {
                              isLoading = false;
                              setState(() {});
                              print(err);
                              Flushbar(
                                backgroundColor: Colors.red,
                                message:
                                    'Something went wrong while we trying to sign you out',
                              ).show(context);
                            });
                          },
                          child: Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                    );
                  });
            },
            icon: Image.asset(
              'assets/images/settings-button.png',
              color: Colors.white,
              width: 32.w,
              height: 32.h,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: MapleColor.indigo,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              child: Stack(
                children: [
                  userData.isEmpty
                      ? Center(
                          child: Icon(Icons.camera_alt,
                              size: 75.w, color: Colors.white),
                        )
                      : Center(
                          child: Image.network(
                          userData['data']['user_picture'],
                          fit: BoxFit.cover,
                          height: ScreenUtil().screenHeight,
                          width: ScreenUtil().screenWidth,
                        )),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        height: 339.h,
                        width: ScreenUtil().screenWidth,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black])),
                      )),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        height: 339.h - 158.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        width: ScreenUtil().screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData['data']['full_name'] ?? '',
                              style: TextStyle(
                                  fontFamily: 'Sequel',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 35.sp),
                            ),
                            Text(
                              '@' +
                                      context
                                          .watch<DashboardProviders>()
                                          .username ??
                                  '',
                              style: TextStyle(
                                  fontFamily: 'Sequel',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 14.sp),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
    );
  }

  void changeProfilePict(BuildContext thisContext, String type) async {
    XFile? profilePicture = type == 'camera'
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);

    if (profilePicture != null) {
      Navigator.pop(thisContext);

      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: profilePicture.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.square
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: MapleColor.indigo,
            toolbarTitle: "Crop Image",
            toolbarWidgetColor: Colors.white,
          ),
          IOSUiSettings(
            title: 'Crop Image'
          )
        ]
      );

      isLoading = true;
      setState(() {});
      File pictureFile = File(croppedFile!.path);

      final imageRef =
          storage.ref().child('images/${userData['data']['user_id']}');

      imageRef.putFile(pictureFile).then((snapshot) async {
        FirebaseDatabase.put(
                reference: 'users',
                doc: userData['data']['user_id'],
                data: {'user_picture': await snapshot.ref.getDownloadURL()})
            .then((value) async {
          var theData = await LocalStorageService.load('user');
          theData['data']['user_picture'] = await snapshot.ref.getDownloadURL();
          await LocalStorageService.save('user', theData);
          getUserData();
          isLoading = false;
          setState(() {});
        });
      });
    }
  }
}
