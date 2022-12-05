import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton(String title, Function() onPressed, {Widget? icon}) {
  return ElevatedButton(
    style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith((states) =>
            EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r))),
        backgroundColor: MaterialStateProperty.all(Colors.white)),
    onPressed: onPressed,
    child: Row(
      children: [
        icon ?? Container(),
        const Expanded(
          child: SizedBox(),
        ),
        Text(
          title,
          style: const TextStyle(
              fontFamily: 'Sequel',
              color: Colors.black,
              fontWeight: FontWeight.w100),
        ),
        const Expanded(
          child: SizedBox(),
        ),
      ],
    ),
  );
}