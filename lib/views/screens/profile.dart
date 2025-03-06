import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/screens/home.dart';
import 'package:gmn/views/widgets/scoop_app/app_par.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold.build(context, _body());
  }

  _body() {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${provider.profile!.name![0].toUpperCase() + provider.profile!.name!.substring(1).toLowerCase()}..\nWelcome to your Profile",
              style: TextStyle(
                  color: AppColors.relax, fontSize: 25.sp, height: 2.sp),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 50.sp, horizontal: 14.sp),
              height: 675.sp,
              width: 384.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.sp),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.theme1Alpha,
                    AppColors.themeAlph,
                    AppColors.theme2Alpha
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.sp),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _profileField("Email", provider.profile!.contactEmail),
                      _profileField("Phone", provider.profile!.phoneNumber),
                      _profileField("Role", provider.profile!.role),
                      _profileField("Status", provider.profile!.status),
                      _profileField("Membership", provider.profile!.membership),
                      const Spacer(),
                      _profileButton("Progress", Home()),
                      _profileButton("Attendance", Home()),
                    ]),
              ),
            ),
          ],
        );
      },
    );
  }

  _profileField(String name, dynamic value) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Row(
        children: [
          Text(
            "$name: ",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.background,
            ),
          ),
          SizedBox(width: 14.sp),
          value is Map
              ? Column(
                  children: [
                    Text(
                      "${value["startDate"]} ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.vibrantColor,
                      ),
                    ),
                    Text(
                      "${value["endDate"]} ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.vibrantColor,
                      ),
                    )
                  ],
                )
              : Text(
                  "$value",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.vibrantColor,
                  ),
                )
        ],
      ),
    );
  }

  _profileButton(String text, Widget distination) {
    return InkWell(
      onTap: () => AppRouter.navigateToWidget(distination),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.sp),
        height: 108.sp,
        width: 350.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.sp),
          gradient: const LinearGradient(
            colors: [AppColors.theme1, AppColors.theme2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.background,
            ),
          ),
        ),
      ),
    );
  }
}
