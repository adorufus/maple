import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/dashboard/merch/views/merch-details.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../providers/dashboard-providers.dart';

class MerchScreen extends StatefulWidget {
  const MerchScreen({Key? key}) : super(key: key);

  @override
  State<MerchScreen> createState() => _MerchScreenState();
}

class _MerchScreenState extends State<MerchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        children: [
          Container(
            height: 200.h,
            width: ScreenUtil().screenWidth,
            color: context.watch<DashboardProviders>().appBarColor,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: MapleColor.white,
                ),
                children: [
                  TextSpan(
                    text: "SOMETHING",
                    style: TextStyle(
                      fontFamily: 'Sequel',
                      fontSize: 40.sp,
                    ),
                  ),
                  TextSpan(
                    text: " CATCH",
                    style: TextStyle(
                      fontFamily: 'Bebas',
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: " YOUR",
                    style: TextStyle(
                      fontFamily: 'Sequel',
                      fontSize: 40.sp,
                    ),
                  ),
                  TextSpan(
                    text: " EYES",
                    style: TextStyle(
                      fontFamily: 'Bebas',
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: "\n\nLOREM IPSUM IS AMET",
                    style: TextStyle(
                      fontFamily: 'Bebas',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MerchDetails(imageUrl: 'assets/images/merch1-detail.png')));
            },
            child: Container(
              child: Image.asset('assets/images/merch1.png'),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Image.asset('assets/images/merch2.png'),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              child: Image.asset('assets/images/merch3.png'),
            ),
          ),
        ],
      ),
    );
  }
}
