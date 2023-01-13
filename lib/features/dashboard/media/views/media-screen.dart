import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/dashboard/media/views/media-details.dart';
import 'package:provider/provider.dart';

import '../../../../services/database_service.dart';
import '../../../../utils/colors.dart';
import '../../providers/dashboard-providers.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({Key? key}) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  String formattedType = '';

  @override
  void initState() {
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
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: context.watch<DashboardProviders>().selectedType !=
                                  '' &&
                              context
                                      .watch<DashboardProviders>()
                                      .selectedType !=
                                  'Unscene'
                          ? Colors.black
                          : MapleColor.white,
                    ),
                    children: [
                      TextSpan(
                        text: "LOREM",
                        style: TextStyle(
                          fontFamily: 'Sequel',
                          fontSize: 40.sp,
                        ),
                      ),
                      TextSpan(
                        text: " IPSUM",
                        style: TextStyle(
                          fontFamily: 'Bebas',
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: " IS",
                        style: TextStyle(
                          fontFamily: 'Sequel',
                          fontSize: 40.sp,
                        ),
                      ),
                      TextSpan(
                        text: " SIMPLY",
                        style: TextStyle(
                          fontFamily: 'Bebas',
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: " DUMMY TO",
                        style: TextStyle(
                          fontFamily: 'Sequel',
                          fontSize: 40.sp,
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
                          fontSize: 24.sp),
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
                          .orderBy('created_time', descending: false)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                                data[index]['name']
                                    .toString()
                                    .replaceAll(' ', '');
                                return categoryButton(
                                    [
                                      data[index]['name']
                                          .toString()
                                          .replaceAll(' ', '')
                                          .substring(0, 3)
                                          .toUpperCase(),
                                      data[index]['name']
                                          .toString()
                                          .substring(
                                              3,
                                              data[index]['name']
                                                  .toString()
                                                  .length)
                                          .toUpperCase()
                                    ],
                                    data[index]['name'],
                                    index,
                                    data[index]['width'].toDouble(),
                                    Color(int.parse(
                                        '0xff' + data[index]['color'])));
                              }),
                            );
                          } else {
                            return Center(
                              child: Text("No Category Yet :("),
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
                      context.watch<DashboardProviders>().selectedType != ''
                          ? '${context.watch<DashboardProviders>().selectedType} for you'
                          : 'All videos',
                      style: TextStyle(
                        fontFamily: 'Sequel',
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
              (context.watch<DashboardProviders>().selectedType != ''
                  ? FutureBuilder<QuerySnapshot>(
                      future: FirebaseDatabase.get(reference: 'media')
                          .where(
                            'type',
                            isEqualTo: context
                                .watch<DashboardProviders>()
                                .selectedType,
                          )
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          String type =
                              context.watch<DashboardProviders>().selectedType;
                          List splittedType = [
                            type.substring(0, 3),
                            type.substring(3, type.length)
                          ];

                          if (snapshot.hasData) {
                            var data = snapshot.data;
                            print(data!.docs);
                            print('test');
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0; i < data.docs.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MediaDetails(
                                                    title: data.docs[i]
                                                        ['title'],
                                                    type: data.docs[i]['type'],
                                                    description: data.docs[i]
                                                        ['description'],
                                                    typeColor: Color(int.parse(
                                                        '0xff' +
                                                            data.docs[i]
                                                                ['color'])),
                                                    ytUrl: data.docs[i]
                                                        ['vidID'],
                                                    mediaId: data.docs[i].id,
                                                  ))).then((value) {
                                        SystemChrome.setPreferredOrientations(
                                            [DeviceOrientation.portraitUp]);
                                      });
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 219.47.h,
                                          width: 390.w,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                data.docs[i]['thumbnails']
                                                    ['standard']['url'],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Center(
                                              child: Image.asset(
                                            'assets/images/play.png',
                                            height: 32.h,
                                            width: 32.w,
                                          )),
                                        ),
                                        Container(
                                          height: 106.h,
                                          width: ScreenUtil().screenWidth,
                                          color: context
                                              .watch<DashboardProviders>()
                                              .appBarColor,
                                          padding: EdgeInsets.all(20.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.docs[i]['title'],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: 'Sequel',
                                                    fontSize: 14.sp,
                                                    color: context
                                                                .watch<
                                                                    DashboardProviders>()
                                                                .selectedType ==
                                                            'Unscene'
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                              Expanded(child: SizedBox()),
                                              RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                      color: context
                                                                  .watch<
                                                                      DashboardProviders>()
                                                                  .selectedType ==
                                                              'Unscene'
                                                          ? Colors.white
                                                          : Colors.black),
                                                  children: [
                                                    TextSpan(
                                                        text: splittedType[0],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Sequel')),
                                                    TextSpan(
                                                        text: splittedType[1],
                                                        style: TextStyle(
                                                            fontFamily: 'Bebas',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            );
                          } else {
                            return Text('No Data Yet :(');
                          }
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Text('Something went wrong on our side :(');
                        } else {
                          print(snapshot.error);
                          return Container();
                        }
                      })
                  : Container()),
            ] +
            (context.watch<DashboardProviders>().selectedType != ''
                ? [Container()]
                : allVideos()),
      ),
    );
  }

  List<Widget> allVideos() {
    return [
      mediaList('Can!', 'CAN', '!', MapleColor.red),
      mediaList('Trick Room', 'TRIC', 'K ROOM', MapleColor.red),
      mediaList('Rewind', 'RE', 'WIND', MapleColor.cyan),
      mediaList('Wander', 'WAN', 'DER', MapleColor.green),
      mediaList('Play Room', 'PLAY', 'ROOM', MapleColor.yellow),
      mediaList('Dixi', 'DI', 'XI', MapleColor.pink),
      mediaList('Unscene', 'UNSC', 'ENE', MapleColor.black),
    ];
  }

  Widget mediaList(String type, String text1, String text2, Color color) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseDatabase.get(reference: 'media')
            .where('type', isEqualTo: type)
            .limit(3)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = snapshot.data;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < data!.docs.length; i++)
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MediaDetails(
                                    title: data.docs[i]['title'],
                                    type: data.docs[i]['type'],
                                    description: data.docs[i]['description'],
                                    typeColor: Color(int.parse(
                                        '0xff' + data.docs[i]['color'])),
                                    ytUrl: data.docs[i]['vidID'],
                                    mediaId: data.docs[i].id,
                                  ))).then((value){
                        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                      }),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 219.47.h,
                            width: 390.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  data.docs[i]['thumbnails']['standard']['url'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                                child: Image.asset(
                              'assets/images/play.png',
                              height: 32.h,
                              width: 32.w,
                            )),
                          ),
                          Container(
                            height: 106.h,
                            width: ScreenUtil().screenWidth,
                            color: color,
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.docs[i]['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'Sequel',
                                      fontSize: 14.sp,
                                      color: type == 'Unscene'
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                Expanded(child: SizedBox()),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: type == 'Unscene'
                                            ? Colors.white
                                            : Colors.black),
                                    children: [
                                      TextSpan(
                                          text: text1,
                                          style:
                                              TextStyle(fontFamily: 'Sequel')),
                                      TextSpan(
                                          text: text2,
                                          style: TextStyle(
                                              fontFamily: 'Bebas',
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ],
              );
            } else {
              return Text('No Data Yet :(');
            }
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Something went wrong on our side :(');
          } else {
            return Container();
          }
        });
  }

  Widget categoryButton(List<String> name, String unformattedName, int index,
      double width, Color color) {
    return GestureDetector(
      onTap: () {
        if (color == MapleColor.white) {
          context.read<DashboardProviders>().setColor(MapleColor.black);
        } else {
          context.read<DashboardProviders>().setColor(color);
        }

        context.read<DashboardProviders>().setType(unformattedName);
      },
      child: Container(
        height: 57.h,
        width: width.toDouble(),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(5.39.r)),
        child: Center(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: name[0],
                  style: TextStyle(
                    fontFamily: 'Sequel',
                    fontSize: 24.24.sp,
                  ),
                ),
                TextSpan(
                  text: name[1],
                  style: TextStyle(
                      fontFamily: 'Bebas',
                      fontSize: 24.24.sp,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
