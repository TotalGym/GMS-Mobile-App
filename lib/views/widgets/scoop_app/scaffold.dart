import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/widgets/scoop_app/app_par.dart';

class AppScaffold {
  static Scaffold build(BuildContext context, Widget body,
      {required String screenTitle}) {
    return Scaffold(
      backgroundColor: null,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.only(top: 45.sp),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.background_2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp), child: body),
      ),
      appBar: TopBar(screenTitle: screenTitle),
      drawer: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(color: Colors.red),
      ),
    );
  }
}
