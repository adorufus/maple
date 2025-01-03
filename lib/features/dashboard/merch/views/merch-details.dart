import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../services/analytics_service.dart';

class MerchDetails extends StatefulWidget {
  final String imageUrl;
  final String url;
  final dynamic data;

  const MerchDetails({Key? key, required this.imageUrl, required this.url, required this.data}) : super(key: key);

  @override
  State<MerchDetails> createState() => _MerchDetailsState();
}

class _MerchDetailsState extends State<MerchDetails> {

  @override
  void initState() {
    analytics.setCurrentScreen(screenName: "/dashboard/merch/merch-details");
    super.initState();
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
            Image.network(
              widget.imageUrl,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data["title"],
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Sequel',
                        fontSize: 36.sp),
                  ),
                  Text(
                    widget.data["price"],
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Sequel',
                        fontWeight: FontWeight.w100,
                        fontSize: 16.sp),
                  ),
                  SizedBox(height: 23.h,),
                  Text(
                    widget.data["description"],
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
