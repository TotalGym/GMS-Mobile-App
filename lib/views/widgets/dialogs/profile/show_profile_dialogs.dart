import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';

void showProgressDialog(Map? progress) {
  BuildContext context = AppRouter.navKey.currentContext!;
  showDialog(
      context: context,
      builder: (context) {
        return _progressDialog(progress);
      });
}

void showAttendaceDialog(List? attendance) {
  BuildContext context = AppRouter.navKey.currentContext!;
  showDialog(
      barrierColor: const Color.fromARGB(162, 0, 0, 0),
      context: context,
      builder: (context) {
        return _attendanceDialog(attendance);
      });
}

_progressDialog(Map? progress) {
  return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(colors: [
              Color(0xaa2069D2),
              Color(0xaa7C11B1),
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          height: 685.h,
          width: 384.w,
          child: const Text("Progress")));
}

_attendanceDialog(List? attendance) {
  return Dialog(
      child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xaa2069D2),
              Color(0xaa7C11B1),
            ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          ),
          height: 685.h,
          width: 384.w,
          child: const Text("Progress")));
}
