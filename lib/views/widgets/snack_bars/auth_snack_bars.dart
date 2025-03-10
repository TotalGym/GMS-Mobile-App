import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';

showFailedLoginSnackBar() {
  BuildContext context = AppRouter.navKey.currentContext!;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      duration: const Duration(seconds: 15),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 35.sp, vertical: 20.sp),
        width: 412.w,
        height: 95.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.theme1, AppColors.theme2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Something went wrong.",
                    style:
                        TextStyle(fontSize: 18.sp, color: AppColors.background),
                  ),
                  Text(
                    "Check your credentials and try again.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.background,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                },
                child: Text(
                  "Ok.",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 16.sp,
                      color: AppColors.background,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
