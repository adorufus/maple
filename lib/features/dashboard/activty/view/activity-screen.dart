import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/dashboard/activty/view/quiz-activity.dart';
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
    return Container(color: Colors.black, child: body());
  }

  Widget body() {
    return ListView(
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
        FutureBuilder(
          future: FirebaseDatabase.get(reference: 'activity')
              .where("type", isEqualTo: "quiz")
              .where("isHidden", isEqualTo: false)
              .where("__name__", isNotEqualTo: "featured")
              .get(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container();
                break;
              case ConnectionState.done:
                return GridView.count(
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 18.w,
                  mainAxisSpacing: 20.h,
                  childAspectRatio: .9,
                  children: snapshot.data?.docs.map((e) {
                        return e["isHidden"]
                            ? Container()
                            : Container(
                                height: 204.h,
                                width: 165.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            e["activity_image_url"]),
                                        fit: BoxFit.cover),
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
                                          vertical: 7.h, horizontal: 8.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                              e["activity_title"],
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
                      }).toList() ??
                      [Container()],
                );
              default:
                return Container();
            }
          },
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
        FutureBuilder(
          future: FirebaseDatabase.get(reference: 'activity')
              .where("type", isEqualTo: "game")
              .where("isHidden", isEqualTo: false)
              .where("__name__", isNotEqualTo: "featured")
              .get(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container();
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return GridView.count(
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisSpacing: 18.w,
                    mainAxisSpacing: 20.h,
                    childAspectRatio: .9,
                    children: snapshot.data?.docs.map((e) {
                          return Container(
                            height: 204.h,
                            width: 165.w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image:
                                        NetworkImage(e["activity_image_url"]),
                                    fit: BoxFit.cover),
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
                                      vertical: 7.h, horizontal: 8.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          e["activity_title"],
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
                        }).toList() ??
                        [Container()],
                  );
                } else {
                  return Container(
                    child: const Center(
                      child: Text(
                        "No activity yet",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              default:
                return Container();
            }
          },
        ),
        // latestArticle()
      ],
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
                            builder: (context) => const QuizActivity(
                              results: [],
                              wrongRightList: [],
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
