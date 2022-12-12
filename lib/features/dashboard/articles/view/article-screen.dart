import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../services/database_service.dart';
import '../../../../utils/colors.dart';
import '../../providers/dashboard-providers.dart';
import 'article-detail-screen.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 200.h,
            width: ScreenUtil().screenWidth,
            color: context
                .watch<DashboardProviders>()
                .appBarColor,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
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
          latestArticle()
        ],
      ),
    );
  }

  Widget latestArticle() {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseDatabase.get(reference: 'articles').get(),
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
                          context, MaterialPageRoute(builder: (context) =>
                            ArticleDetailScreen(
                              data: data.docs[i],
                            ),),);
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
                                      data.docs[i]['title'],
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
                                      data.docs[i]['title'],
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
                                    data.docs[i]['content_image'],
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
