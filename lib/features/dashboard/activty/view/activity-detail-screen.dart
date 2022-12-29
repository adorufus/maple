import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ActivityDetailScreen extends StatefulWidget {
  final data;
  const ActivityDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MapleColor.indigo,
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
      body: Container(
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.data,
        ),
      )
    );
  }
}
