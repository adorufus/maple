import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/dashboard/articles/view/article-screen.dart';
import 'package:maple/features/dashboard/home/controllers/home-controllers.dart';
import 'package:maple/features/dashboard/media/views/media-screen.dart';
import 'package:maple/features/dashboard/providers/dashboard-providers.dart';
import 'package:maple/services/database_service.dart';
import 'package:maple/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../../services/analytics_service.dart';
import '../../articles/view/article-detail-screen.dart';
import '../../media/views/media-details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  @override
  void initState() {
    analytics.setCurrentScreen(screenName: "/dashboard/home");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        children: [
          Container(
            height: 260.h,
            width: ScreenUtil().screenWidth,
            color: MapleColor.indigo,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "GOOD MORNING, ",
                      style: TextStyle(
                          fontFamily: 'Bebas',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w100,
                          color: MapleColor.white)),
                  TextSpan(
                      text:
                          "${context.watch<DashboardProviders>().username.toUpperCase()}",
                      style: TextStyle(
                          fontFamily: 'Bebas',
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: MapleColor.white)),
                ])),
                RichText(
                  text: TextSpan(style: TextStyle(height: .9), children: [
                    TextSpan(
                        text: "\nSORRY",
                        style: TextStyle(
                            fontFamily: 'Bebas',
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                            color: MapleColor.green)),
                    TextSpan(
                        text: " WE",
                        style: TextStyle(
                            fontFamily: 'Sequel',
                            fontSize: 50.sp,
                            color: Colors.white)),
                    TextSpan(
                        text: " DON'T",
                        style: TextStyle(
                            fontFamily: 'Bebas',
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                            color: MapleColor.green)),
                    TextSpan(
                        text: " PROVIDE",
                        style: TextStyle(
                            fontFamily: 'Bebas',
                            fontWeight: FontWeight.w700,
                            fontSize: 50.sp,
                            color: MapleColor.green)),
                    TextSpan(
                        text: " THE",
                        style: TextStyle(
                            fontFamily: 'Sequel',
                            fontSize: 50.sp,
                            color: Colors.white)),
                    TextSpan(
                        text: " SWEET",
                        style: TextStyle(
                            fontFamily: 'Bebas',
                            fontSize: 50.sp,
                            fontWeight: FontWeight.w700,
                            color: MapleColor.green)),
                    TextSpan(
                        text: " SYRUP",
                        style: TextStyle(
                            fontFamily: 'Sequel',
                            fontSize: 50.sp,
                            color: Colors.white)),
                  ]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Video categories',
                  style: TextStyle(
                      fontFamily: 'Sequel',
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 21.sp),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 124.h,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: ScreenUtil().screenWidth * 1.5,
                child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseDatabase.get(reference: 'media-type')
                      .orderBy('created_time', descending: true)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      var data = snapshot.data!.docs;
                      if (snapshot.hasData) {
                        print(data.length);
                        return Wrap(
                          spacing: 10.h,
                          runSpacing: 10.w,
                          direction: Axis.horizontal,
                          children: List.generate(data.length, (index) {
                            data[index]['name'].toString().replaceAll(' ', '');
                            return categoryButton(
                                [
                                  data[index]['name']
                                      .toString()
                                      .replaceAll(' ', '')
                                      .substring(0, 3)
                                      .toUpperCase(),
                                  data[index]['name']
                                      .toString()
                                      .substring(3,
                                          data[index]['name'].toString().length)
                                      .toUpperCase()
                                ],
                                data[index]['name'],
                                index,
                                Color(
                                    int.parse('0xff' + data[index]['color'])));
                          }),
                        );
                      } else {
                        return Center(
                          child: Text("No Media Yet :("),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest video',
                  style: TextStyle(
                    fontFamily: 'Sequel',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 21.sp,
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.read<DashboardProviders>().setNavIndex(2);
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          latestMedia('Can!'),
          SizedBox(
            height: 25.h,
          ),
          latestMedia('Trick Room'),
          SizedBox(
            height: 25.h,
          ),
          latestMedia('Rewind'),
          SizedBox(
            height: 25.h,
          ),
          latestMedia('Wander'),
          SizedBox(
            height: 25.h,
          ),
          latestMedia('Dixi'),
          SizedBox(
            height: 25.h,
          ),
          latestMedia('Play Room'),
          SizedBox(
            height: 25.h,
          ),
          latestMedia('Unscene'),
          SizedBox(
            height: 30.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Latest article',
                  style: TextStyle(
                    fontFamily: 'Sequel',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 21.sp,
                  ),
                ),
                Expanded(child: SizedBox()),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    context.read<DashboardProviders>().setNavIndex(1);
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          latestArticle()
        ],
      ),
    );
  }

  Widget latestArticle() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseDatabase.get(reference: 'articles').limit(3).get(),
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
                            builder: (context) => ArticleDetailScreen(
                              data: data.docs[i],
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
                                          data.docs[i]['content_image'],
                                          height: 195.h,
                                          width: 195.h,
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : Flexible(
                                    child: Container(
                                      width: 195.w,
                                      color: Colors.white,
                                      padding: EdgeInsets.all(20.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.docs[i]['title'],
                                            style: TextStyle(
                                                fontFamily: 'Sequel',
                                                fontSize: 14.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Read more',
                                            style: TextStyle(
                                                color: Colors.black,
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
                                      color: Colors.white,
                                      padding: EdgeInsets.all(20.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.docs[i]['title'],
                                            style: TextStyle(
                                                fontFamily: 'Sequel',
                                                fontSize: 14.sp,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Read more',
                                            style: TextStyle(
                                                color: Colors.black,
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
                                          data.docs[i]['content_image'],
                                          height: 195.h,
                                          width: 195.h,
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

  Widget latestMedia(String segmentType) {
    return Container(
      child: FutureBuilder<QuerySnapshot>(
        future: FirebaseDatabase.get(reference: 'media')
            .where('type', isEqualTo: segmentType)
            .get(),
        builder: (context, snapshot) {
          var data = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print(snapshot.hasData);
              return GestureDetector(
                child: Container(
                  height: 192.h,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 20.w),
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.docs.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MediaDetails(
                                title: data.docs[i]['title'],
                                type: data.docs[i]['type'],
                                description: data.docs[i]['description'],
                                typeColor: Color(
                                    int.parse('0xff' + data.docs[i]['color'])),
                                ytUrl: data.docs[i]['vidID'],
                                mediaId: data.docs[i].id,
                              ),
                            ),
                          ).then((value) {
                            SystemChrome.setPreferredOrientations(
                                [DeviceOrientation.portraitUp]);
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                height: (data.docs[i]['thumbnails']['medium']
                                        ['height'] as int)
                                    .h,
                                width: (data.docs[i]['thumbnails']['medium']
                                        ['width'] as int)
                                    .w,
                                margin: EdgeInsets.only(right: 14.w),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      data.docs[i]['thumbnails']['medium']
                                          ['url'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Center(
                                    child: Image.asset(
                                  'assets/images/play.png',
                                  height: 32.h,
                                  width: 32.w,
                                )),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              width: (data.docs[i]['thumbnails']['medium']
                                      ['width'] as int)
                                  .w,
                              child: Text(
                                data.docs[i]['title'],
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            } else {
              return Center(
                child: Text("No Media Yet :("),
              );
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget categoryButton(
      List<String> name, String unformattedName, int index, Color color) {
    return GestureDetector(
      onTap: () {
        if (unformattedName.toLowerCase() != 'all') {
          if (color == MapleColor.white) {
            context.read<DashboardProviders>().setColor(MapleColor.black);
          } else {
            context.read<DashboardProviders>().setColor(color);
          }

          context.read<DashboardProviders>().setType(unformattedName);
          context.read<DashboardProviders>().setNavIndex(2);
        } else {
          context.read<DashboardProviders>().setNavIndex(2);
        }
      },
      child: Container(
        height: 40.h,
        width: 119.w,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5.39.r)),
        child: Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: name[0] + name[1],
                  style: TextStyle(
                    fontFamily: 'Sequel',
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
