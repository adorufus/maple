import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../services/analytics_service.dart';

class ArticleDetailScreen extends StatefulWidget {
  final data;

  const ArticleDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  void initState() {
    analytics.setCurrentScreen(screenName: "/dashboard/article-screen/article-detail");
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
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Image.network(widget.data['content_image']),
          SizedBox(
            height: 54.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              widget.data['title'],
              style: TextStyle(
                  fontFamily: 'Sequel',
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 25.sp),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Html(
                data: widget.data['content'],
              ))
        ],
      ),
    );
  }
}
