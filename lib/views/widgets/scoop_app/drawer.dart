import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/auth/change_password.dart';
import 'package:gmn/views/screens/auth/log_in.dart';
import 'package:gmn/views/screens/equipments/equipments_index.dart';
import 'package:gmn/views/screens/profile/ai_chat.dart';
import 'package:gmn/views/screens/profile/profiles_index.dart';
import 'package:gmn/views/screens/programs/programs_index.dart';
import 'package:gmn/views/screens/store/all_products.dart';
import 'package:provider/provider.dart';

appDrawer({String userType = "Trainee"}) {
  final bool isCoach = userType == "Coach";
  return Container(
    padding: EdgeInsets.symmetric(vertical: 120.h, horizontal: 14.sp),
    width: 220.w,
    decoration: const BoxDecoration(color: AppColors.backgroundAlpha),
    child: Column(children: [
      _drawerButton("Profile", const ProfilesIndex()),
      _drawerButton("AI Chat", const OpenAIChat()),
      if (isCoach) _drawerButton("Trainees", const ProfilesIndex()),
      if (isCoach) _drawerButton("Equipments", const EquipmentsIndex()),
      if (isCoach) _drawerButton("Programs", const ProgramsIndex()),
      if (isCoach) _drawerButton("Products", const ProductsIndex()),
      const Spacer(),
      _customColorsDrawerButton(
        "Change Password",
        const ChangePassword(),
        [
          const Color(0xff2069D2),
          const Color(0xff103569),
        ],
      ),
      _logoutButton(
        "Log out",
        [
          const Color(0xffD22020),
          const Color(0xff7C11B1),
        ],
      ),
    ]),
  );
}

Widget _drawerButton(String name, Widget destination) {
  return InkWell(
    onTap: () async {
      AppRouter.popFromWidget();
      AppRouter.navigateToWidget(destination);
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8.5.sp),
      alignment: Alignment.center,
      width: 178.w,
      height: 60.h,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.theme1, AppColors.theme2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.sp)),
          color: Colors.green),
      child: Text(
        name,
        style: TextStyle(fontSize: 16.sp, color: AppColors.background),
      ),
    ),
  );
}

Widget _customColorsDrawerButton(
    String name, Widget destination, List<Color> gradientColors) {
  return InkWell(
    onTap: () async {
      AppRouter.popFromWidget();
      AppRouter.navigateToWidget(destination);
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8.5.sp),
      alignment: Alignment.center,
      width: 178.w,
      height: 60.h,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.sp)),
          color: Colors.green),
      child: Text(
        name,
        style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.background,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget _logoutButton(String name, List<Color> gradientColors) {
  return InkWell(
    onTap: () async {
      AppRouter.navKey.currentContext!.read<UserProvider>().logUserOut();
      AppRouter.navigateWithReplacemtnToWidget(const LogIn());
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8.5.sp),
      alignment: Alignment.center,
      width: 178.w,
      height: 60.h,
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.sp)),
          color: Colors.green),
      child: Text(
        name,
        style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.background,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}
