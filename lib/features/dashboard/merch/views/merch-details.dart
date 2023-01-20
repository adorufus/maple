import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class MerchDetails extends StatefulWidget {
  final String imageUrl;
  final String url;

  const MerchDetails({Key? key, required this.imageUrl, required this.url}) : super(key: key);

  @override
  State<MerchDetails> createState() => _MerchDetailsState();
}

class _MerchDetailsState extends State<MerchDetails> {
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
              width: 32.w,
              height: 32.h,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 131.h,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  if(!await launchUrl(Uri.parse(widget.url))){
                    print('Couldnt launch');
                  }
                },
                child: Container(
                  height: 54,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  width: ScreenUtil().screenWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Center(
                    child: Text(
                      "Check out",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontFamily: 'Sequel',
                          fontWeight: FontWeight.w100),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 17.h,
              ),
              Text(
                'Cool. You\'re so close to have these items!',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Sequel',
                ),
              )
            ],
          ),
        ),
        extendBodyBehindAppBar: true,
        body: ListView(
          children: [
            Image.asset(
              widget.imageUrl,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Totebag',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Sequel',
                        fontSize: 36.sp),
                  ),
                  Text(
                    'Rp 100.000',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Sequel',
                        fontWeight: FontWeight.w100,
                        fontSize: 16.sp),
                  ),
                  SizedBox(height: 23.h,),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Sequel',
                        fontWeight: FontWeight.w100,
                        fontSize: 16.sp),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
