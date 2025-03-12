import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/helpers/date_formatter_helper.dart';
import 'package:gmn/data/models/user/profile/profile.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/widgets/dialogs/profile/show_attendance_dialog.dart';
import 'package:gmn/views/widgets/dialogs/profile/show_progress_dialog.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  final Profile? profile;
  const ProfileView({
    super.key,
    this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold.build(context, _isPersonalProfile(),
        screenTitle: "Profile");
  }

  _isPersonalProfile() {
    return profile == null
        ? Consumer<ProfileProvider>(
            builder: (context, provider, child) => _body(provider.profile!),
          )
        : _body(profile!);
  }

  _body(Profile profile) {
    String? role =
        AppRouter.navKey.currentContext!.read<ProfileProvider>().profile!.role;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                profile.name.toString().length > 26
                    ? "${profile.name.toString().substring(0, 26)}.."
                    : profile.name.toString(),
                style: TextStyle(
                    color: AppColors.relax, fontSize: 27.sp, height: 1.sp),
              ),
              profile.role == "Coach"
                  ? Text(
                      'Welcome to your Profile..',
                      style: TextStyle(
                          color: AppColors.relax,
                          fontSize: 26.sp,
                          height: 1.5.sp),
                    )
                  : Padding(
                      padding: EdgeInsets.only(top: 14.sp),
                      child: Row(
                        children: [
                          Text(
                            'Member Since: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                height: 1.sp),
                          ),
                          Text(
                            DateFormatterHelper.dateFromString(
                                    profile.createdAt!.toLocal().toString())
                                .toString(),
                            style: TextStyle(
                                color: AppColors.relax,
                                fontSize: 18.sp,
                                height: 1.sp),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 50.sp, horizontal: 14.sp),
          height: 700.sp,
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
                  _profileField("Email", profile.contactEmail),
                  _profileField("Phone", profile.phoneNumber),
                  _profileField("Gender", profile.gender),
                  if (profile.role == "Trainee")
                    _profileField("Coach", profile.assignedCoach!['name']),
                  _profileField("Role", profile.role),
                  _profileField("Status", profile.status),
                  _profileField("Membership", profile.membership),
                  const Spacer(),
                  if (role == "Coach")
                    _profileButton(
                        "Progress", showProgressDialog, profile.progress),
                  _profileButton(
                      "Attendance", showAttendaceDialog, profile.attendance),
                ]),
          ),
        ),
      ],
    );
  }

  _profileField(String name, dynamic value) {
    return Padding(
      padding: EdgeInsets.all(7.sp),
      child: Row(
        children: [
          Text(
            "$name: ",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 14.sp),
          value is Map
              ? Column(
                  children: [
                    Text(
                      DateFormatterHelper.dateFromString(
                              value["startDate"] ?? "")
                          .toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.vibrantColor,
                      ),
                    ),
                    Text(
                      DateFormatterHelper.dateFromString(
                              value["startDate"] ?? "")
                          .toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.vibrantColor,
                      ),
                    ),
                  ],
                )
              : Text(
                  value.toString().length > 40
                      ? "${value.toString().substring(0, 38)}.."
                      : value.toString(),
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

  _profileButton(String text, Function dialog, data) {
    return InkWell(
      onTap: () => dialog(data),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.sp),
        height: 90.sp,
        width: 350.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
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
