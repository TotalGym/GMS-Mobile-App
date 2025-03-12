import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/assets.dart';
import 'package:lottie/lottie.dart';

void showLoadingDialog() {
  BuildContext context = AppRouter.navKey.currentContext!;
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    context: context,
    builder: (context) {
      return SizedBox(
        height: 20.sp,
        width: 20.sp,
        child: Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Center(
            child: Lottie.asset(Assets.getAnimation(Assets.loading)),
          ),
        ),
      );
    },
  );
}
