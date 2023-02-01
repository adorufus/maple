import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../services/analytics_service.dart';
import '../../../../services/database_service.dart';
import '../../../../utils/colors.dart';
import '../../providers/dashboard-providers.dart';
import 'activity-detail-screen.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    analytics.setCurrentScreen(screenName: "/dashboard/activity");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        children: [
          Text(
            'Activity',
            style: TextStyle(
              fontFamily: 'Sequel',
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(
            height: 17.h,
          ),
          Container(
            height: 148.h,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: NetworkImage(
              //     data.docs[i]['thumbnails']['medium']
              //     ['url'],
              //   ),
              //   fit: BoxFit.cover,
              // ),
              color: Color(0xff5A9FF6),
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 46.h,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
                color: Color(0xff252327),
                borderRadius: BorderRadius.circular(8.r)),
            child: Center(
              child: Text(
                "🧐 Quizzes",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'Sequel',
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GridView.count(
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisSpacing: 18.w,
            mainAxisSpacing: 20.h,
            childAspectRatio: .9,
            children: List.generate(4, (index) {
              return Container(
                height: 204.h,
                width: 165.w,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.r)),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 62.h,
                      width: double.infinity,
                      color: Color(0xff252327),
                      padding: EdgeInsets.symmetric(
                        vertical: 7.h,
                        horizontal: 8.w
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quiz",
                            style: TextStyle(
                                color: Color(0xff717171),
                                fontFamily: "Sequel",
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp),
                          ),
                          Flexible(
                            child: Text(
                              "Lorem ipsum is amet at dolar amet",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Sequel",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 46.h,
            width: ScreenUtil().screenWidth,
            decoration: BoxDecoration(
                color: Color(0xff252327),
                borderRadius: BorderRadius.circular(8.r)),
            child: Center(
              child: Text(
                "👾 Games",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontFamily: 'Sequel',
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GridView.count(
            crossAxisCount: 2,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 18.h,
            childAspectRatio: .9,
            children: List.generate(4, (index) {
              return Container(
                height: 204.h,
                width: 165.w,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.r)),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 62.h,
                      width: double.infinity,
                      color: Color(0xff252327),
                      padding: EdgeInsets.symmetric(
                          vertical: 7.h,
                          horizontal: 8.w
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quiz",
                            style: TextStyle(
                                color: Color(0xff717171),
                                fontFamily: "Sequel",
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp),
                          ),
                          Flexible(
                            child: Text(
                              "Lorem ipsum is amet at dolar amet",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Sequel",
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12.sp),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          // latestArticle()
        ],
      ),
    );
  }

  Widget latestArticle() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseDatabase.get(reference: 'activity').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Column(
                children: [
                  for (int i = 0; i < data!.docs.length; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityDetailScreen(
                              data: data.docs[i]['activity_url'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 195.h,
                        child: Row(
                          children: [
                            i.isOdd
                                ? Flexible(
                                    child: Container(
                                      width: 195.w,
                                      child: Image.network(
                                          data.docs[i]['activity_image_url'],
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : Flexible(
                                    child: Container(
                                      width: 195.w,
                                      color: Colors.black,
                                      padding: EdgeInsets.all(20.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.docs[i]['activity_title'],
                                            style: TextStyle(
                                                fontFamily: 'Sequel',
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Read more',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Sequel',
                                                fontWeight: FontWeight.w100),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            i.isOdd
                                ? Flexible(
                                    child: Container(
                                      width: 195.w,
                                      color: Colors.black,
                                      padding: EdgeInsets.all(20.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.docs[i]['activity_title'],
                                            style: TextStyle(
                                                fontFamily: 'Sequel',
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Read more',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Sequel',
                                                fontWeight: FontWeight.w100),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Flexible(
                                    child: Container(
                                      width: 195.w,
                                      child: Image.network(
                                          data.docs[i]['activity_image_url'],
                                          fit: BoxFit.cover),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    )
                ],
              );
            } else {
              return Center(
                child: Text("No Articles Yet :("),
              );
            }
          } else {
            return Container();
          }
        });
  }
}
