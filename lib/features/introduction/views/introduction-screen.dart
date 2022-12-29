import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/dashboard/dashboard-screen.dart';
import 'package:maple/services/local_storage_service.dart';
import 'package:maple/utils/widgets.dart';
import 'package:maple/widgets/maple-scaffold.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.ease,
  ));

  int currentIndex = 0;
  String image1 = "assets/images/maple-slide-1.png";
  String image2 = "assets/images/maple-slide-2.png";
  String image3 = "assets/images/maple-slide-3.png";

  List<String> images = [
    "assets/images/maple-slide-1.png",
    "assets/images/maple-slide-2.png",
    "assets/images/maple-slide-3.png",
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MapleScaffold(
        isUsingAppbar: false,
        backgroundColor: Colors.black,
        body: SafeArea(
          child: SizedBox(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            child: Column(
                children: [
                  Image.asset(
                    images[currentIndex],
                    height: 701.h,
                    width: 390.w,
                  ),
                  SizedBox(
                    height: 53.h,
                  ),
                  currentIndex == 2
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: customButton('Get Started', () async {
                            Map<String, dynamic> data =
                                await LocalStorageService.load('user');
                            data["data"]["is_first"] = false;

                            LocalStorageService.save('user', data).then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardScreen()));
                            });
                          }),
                        )
                      : IconButton(
                          onPressed: () {
                            currentIndex += 1;
                            setState(() {});
                          },
                          icon: Image.asset(
                            'assets/images/next-button.png',
                            height: 36.h,
                            width: 36.h,
                          ))
                ],
              ),
          ),
        ));
  }
}
