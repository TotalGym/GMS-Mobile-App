import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';

void showProgressDialog(Map? progress) {
  BuildContext context = AppRouter.navKey.currentContext!;
  showDialog(
      barrierColor: const Color.fromARGB(190, 0, 0, 0),
      context: context,
      builder: (context) {
        return _progressDialog(progress);
      });
}

_progressDialog(Map? progress) {
  return Dialog(
      insetPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(colors: [
              Color(0xff2069D2),
              Color(0xff7C11B1),
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          height: 685.h,
          width: 384.w,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Progress",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          )));
}
