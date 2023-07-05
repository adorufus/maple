import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/dashboard/merch/views/merch-details.dart';
import 'package:maple/services/database_service.dart';
import 'package:maple/widgets/app-buttons.dart';
import 'package:provider/provider.dart';

import '../../../../services/analytics_service.dart';
import '../../../../utils/colors.dart';
import '../../providers/dashboard-providers.dart';

class MerchScreen extends StatefulWidget {
  const MerchScreen({Key? key}) : super(key: key);

  @override
  State<MerchScreen> createState() => _MerchScreenState();
}

class _MerchScreenState extends State<MerchScreen> {
  @override
  void initState() {
    analytics.setCurrentScreen(screenName: "/dashboard/merch");
    super.initState();
  }

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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: MapleColor.white, height: .8),
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
          FutureBuilder(
              future: FirebaseDatabase.get(reference: 'merch').get(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container();
                  case ConnectionState.done:
                    return Column(
                      children: snapshot.data?.docs.map((e) {
                            return Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MerchDetails(
                                                imageUrl: e["merch_image_url"],
                                                data: e,
                                                url:
                                                    "https://tokopedia.link/QgTOflmr9vb")));
                                  },
                                  child: Container(
                                    child: Image.network(e["merch_image_url"]),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 15.h),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MerchDetails(
                                                    imageUrl:
                                                        e["merch_image_url"],
                                                    data: e,
                                                    url:
                                                        e["tokopedia_url"])));
                                      },
                                      child: AppButton(
                                        text: "Check Out!!",
                                        backgroundColor: MapleColor.indigo,
                                        borderColor: Colors.transparent,
                                        textColor: Colors.white,
                                        height: 35.h,
                                        width: 150.w,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }).toList() ??
                          [Container()],
                    );
                  default:
                    return Container();
                }
              }),
        ],
      ),
    );
  }
}
