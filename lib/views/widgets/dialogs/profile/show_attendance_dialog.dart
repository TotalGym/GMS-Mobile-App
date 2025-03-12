import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/helpers/date_formatter_helper.dart';
import 'package:gmn/data/models/user/extentions/attendance.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';

void showAttendaceDialog(List<Attendance?>? attendance) {
  BuildContext context = AppRouter.navKey.currentContext!;
  showDialog(
      barrierColor: const Color.fromARGB(190, 0, 0, 0),
      context: context,
      builder: (context) {
        return _attendanceDialog(attendance);
      });
}

_attendanceDialog(List<Attendance?>? attendance) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Attendance",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            height: 600.h,
            child: ListView.builder(
              itemBuilder: ((context, index) =>
                  _attendanceListItem(attendance[index]!)),
              itemCount: attendance!.length,
            ),
          )
        ],
      ),
    ),
  );
}

_attendanceListItem(Attendance attendance) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8.sp),
    width: 384.sp,
    height: 100.sp,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.theme1, AppColors.theme2],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    ),
    child: SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormatterHelper.dateFromString(attendance.date.toString()),
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          attendance.status == "Present"
              ? Text(
                  "Present",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                )
              : Text(
                  "Absent",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.backgroundAlpha,
                  ),
                ),
        ],
      ),
    ),
  );
}
