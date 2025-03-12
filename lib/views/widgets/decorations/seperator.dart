import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/colors.dart';

seperator(
    {double height = 2.0,
    double width = 330.0,
    double marginLeft = 25,
    double marginTop = 12,
    double marginBottom = 12,
    double marginRight = 25,
    Color color = AppColors.background_2}) {
  return Container(
    margin: EdgeInsets.only(
      left: marginLeft,
      top: marginTop,
      right: marginRight,
      bottom: marginBottom,
    ),
    color: color,
    height: height.h,
    width: width.w,
  );
}
