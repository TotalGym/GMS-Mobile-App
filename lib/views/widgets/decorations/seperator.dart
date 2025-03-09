import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/colors.dart';

seperator(
    {double height = 2.0,
    double width = 330.0,
    double marginLeft = 25.0,
    double marginTop = 8,
    double marginBottom = 8,
    double marginRight = 25}) {
  return Container(
    margin: EdgeInsets.only(
        left: marginLeft.sp,
        top: marginTop,
        bottom: marginBottom,
        right: marginRight),
    color: AppColors.background_2,
    height: height.sp,
    width: width.sp,
  );
}
