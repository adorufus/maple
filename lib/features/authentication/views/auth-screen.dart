import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/widgets/maple-scaffold.dart';

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
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> socialLoginButton() {
    return [
      customIconButtom(
        'Sign in with Google',
        Image.asset(
          'assets/images/google.png',
          height: 32.h,
          width: 32.w,
        ),
        () {},
      ),
      SizedBox(
        height: 16.h,
      ),
      customIconButtom(
        'Sign in with Apple',
        Image.asset(
          'assets/images/apple.png',
          height: 32.h,
          width: 32.w,
        ),
        () {},
      )
    ];
  }

  Widget customIconButtom(String title, Widget icon, Function() onPressed) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.resolveWith((states) =>
              EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r))),
          backgroundColor: MaterialStateProperty.all(Colors.white)),
      child: Row(
        children: [
          icon,
          const Expanded(
            child: SizedBox(),
          ),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Sequel',
                color: Colors.black,
                fontWeight: FontWeight.w100),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
