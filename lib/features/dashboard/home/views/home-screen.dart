import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/dashboard/home/controllers/home-controllers.dart';
import 'package:maple/features/dashboard/providers/dashboard-providers.dart';
import 'package:maple/services/database_service.dart';
import 'package:maple/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  @override
  void initState() {
    print('bangat');
    HomeControllers.getUsername().then((value) {
      username = value;
      setState(() {});
    });
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
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "GOOD MORNING, ",
                    style: TextStyle(
                        fontFamily: 'Bebas',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w100,
                        color: MapleColor.white)),
                TextSpan(
                    text: "${username.toUpperCase()}",
                    style: TextStyle(
                        fontFamily: 'Bebas',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: MapleColor.white)),
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
                  future: FirebaseDatabase.get(reference: 'media-type').orderBy('created_time', descending: false).get(),
                  builder: (context, snapshot) {
                    var data = snapshot.data!.docs;
                    print(data.length);
                    return Wrap(
                      spacing: 10.h,
                      runSpacing: 10.w,
                      direction: Axis.horizontal,
                      children: List.generate(
                        data.length,
                        (index) {
                          data[index]['name'].toString().replaceAll(' ', '');
                          return categoryButton(
                              [data[index]['name'].toString().replaceAll(' ', '').substring(0, 3).toUpperCase(), data[index]['name'].toString().substring(3, data[index]['name'].toString().length).toUpperCase()], data[index]['width'].toDouble(), Color(int.parse('0xff' + data[index]['color'])));
                        }
                      ),
                    );
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
                    fontSize: 24.sp,
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
          latestMedia('Can!'),
          SizedBox(
            height: 20.h,
          ),
          latestMedia('Trick Room'),
          SizedBox(
            height: 20.h,
          ),
          latestMedia('Rewind'),
          SizedBox(
            height: 20.h,
          ),
          latestMedia('Wander'),
          SizedBox(
            height: 20.h,
          ),
          latestMedia('Dixi'),
          SizedBox(
            height: 20.h,
          ),
          latestMedia('Play Room'),
          SizedBox(
            height: 20.h,
          ),
          latestMedia('Unscene'),
        ],
      ),
    );
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
              return Container(
                height: 192.h,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: 20.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: data!.docs.length,
                  itemBuilder: (context, i) {
                    return Column(
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
                                  data.docs[i]['thumbnails']['medium']['url'],
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
                            width: (data.docs[i]['thumbnails']['medium']
                                    ['width'] as int)
                                .w,
                            child: Text(
                              data.docs[i]['title'],
                              overflow: TextOverflow.ellipsis,
                            ))
                      ],
                    );
                  },
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

  Widget categoryButton(List<String> name, double width, Color color) {
    return GestureDetector(
      onTap: () {
        if (color == MapleColor.white) {
          context.read<DashboardProviders>().setColor(MapleColor.black);
        } else {
          context.read<DashboardProviders>().setColor(color);
        }
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
