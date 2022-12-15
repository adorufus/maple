import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/authentication/controllers/auth-controllers.dart';
import 'package:maple/features/dashboard/dashboard-screen.dart';
import 'package:maple/services/local_storage_service.dart';
import 'package:maple/widgets/maple-scaffold.dart';
import 'package:maple/utils/widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return MapleScaffold(
      isUsingAppbar: false,
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/auth-background.png'),
              fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 95.h,
            ),
            Flexible(
              child: Container(
                height: 92.h,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 76.sp),
                        children: const [
                          TextSpan(
                              text: 'WELCOME',
                              style: TextStyle(fontFamily: 'Bebas')),
                          TextSpan(
                            text: ' TO',
                            style: TextStyle(
                              fontFamily: 'Sequel',
                              color: Colors.white,
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/images/maple-logo-white.png',
              width: 241.w,
              height: 63.62.h,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            ...socialLoginButton(),
            const Expanded(
              child: SizedBox(),
            ),
            Center(
              child: TextButton(
                child: Text(
                  'Skip',
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontFamily: 'Sequel',
                      fontWeight: FontWeight.w100),
                ),
                onPressed: () {
                  AuthControllers(AuthType.guest, context)
                      .doAuth()
                      .then((value) {
                    LocalStorageService.load('user').then((value) {
                      print(value);
                      if (value["status"] == 'success') {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DashboardScreen()));
                      }
                    });
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> socialLoginButton() {
    return [
      customButton(
        'Sign in with Google',
        () {
          AuthControllers(AuthType.google, context).doAuth().then((res) {
            print(res);
            LocalStorageService.load('user').then((value) {
              print(value);
              if (value["status"] == 'success') {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardScreen()));
              }
            });
          });
        },
        icon: Image.asset(
          'assets/images/google.png',
          height: 32.h,
          width: 32.w,
        ),
      ),
      SizedBox(
        height: 16.h,
      ),
      customButton(
        'Sign in with Apple',
        () {},
        icon: Image.asset(
          'assets/images/apple.png',
          height: 32.h,
          width: 32.w,
        ),
      )
    ];
  }
}
