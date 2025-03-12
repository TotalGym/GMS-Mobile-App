import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/widgets/scoop_app/app_par.dart';
import 'package:gmn/views/widgets/scoop_app/drawer.dart';
import 'package:provider/provider.dart';

class AppScaffold {
  static Scaffold build(BuildContext context, Widget body,
      {required String screenTitle}) {
    String userType = context.watch<UserProvider>().user!.role ?? "Trainee";
    return Scaffold(
      backgroundColor: null,
      extendBodyBehindAppBar: true,
      body: Container(
        padding: screenTitle == "Home" ? null : EdgeInsets.only(top: 45.sp),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.background, AppColors.background_2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: _ifHome(screenTitle)),
            child: body),
      ),
      appBar: TopBar(screenTitle: screenTitle),
      drawer: appDrawer(userType: userType),
    );
  }

  static double _ifHome(String screenTitle) {
    return screenTitle == "Home" ? 0 : 14;
  }
}
