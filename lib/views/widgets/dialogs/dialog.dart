import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/colors.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return SizedBox(
        height: 20.sp,
        width: 20.sp,
        child: const Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Center(
              child: CircularProgressIndicator(
            color: AppColors.vibrantColor,
          )),
        ),
      );
    },
  );
}
