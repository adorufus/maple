import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final String text;
  final IconData? icon;
  final double radius;
  double height;
  double width;

  AppButton(
      {Key? key,
      required this.backgroundColor,
      required this.textColor,
      required this.borderColor,
      required this.text,
      this.icon,
      required this.height,
      required this.width,
      this.radius = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      child: Center(
        child: Text(text, style: TextStyle(color: textColor),),
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: backgroundColor),
    );
  }
}
