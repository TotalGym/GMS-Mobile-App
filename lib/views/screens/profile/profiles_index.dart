import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/helpers/date_formatter_helper.dart';
import 'package:gmn/data/models/user/profile/profile.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/profile/profile.dart';
import 'package:gmn/views/widgets/dialogs/dialog.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfilesIndex extends StatelessWidget {
  const ProfilesIndex({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = context.watch<UserProvider>().user!.token;
    if (context.read<CoachProvider>().traineeProfiles == null) {
      context.read<CoachProvider>().getAllProfiles(token!);
    }

    return AppScaffold.build(context, _body(), screenTitle: "Profiles");
  }

  _body() {
    BuildContext context = AppRouter.navKey.currentContext!;
    String? token = context.read<UserProvider>().user!.token;
    String coachName = context.read<ProfileProvider>().profile!.name!;
    return Consumer<CoachProvider>(
      builder: (context, provider, child) {
        if (provider.traineeProfiles == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Happy Coaching, ',
                      style: TextStyle(color: AppColors.relax, fontSize: 22.sp),
                    ),
                    Text(
                      coachName.toString().length > 10
                          ? "${context.toString().substring(0, 9)}.."
                          : coachName.toString(),
                      style:
                          TextStyle(color: AppColors.theme1, fontSize: 24.sp),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == provider.traineeProfiles!.items!.length) {
                    return provider.traineeProfiles!.next == null
                        ? const Center(
                            child: Text(
                              "No more!",
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.background),
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              showLoadingDialog(context);
                              await context
                                  .read<CoachProvider>()
                                  .getProfilesNextPage(token!);
                              AppRouter.popFromWidget();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 150.sp,
                              padding: EdgeInsets.all(12.sp),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.sp)),
                                  color: Colors.blue),
                              child: const Text(
                                "More..",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                  }
                  return _profileListItem(
                      provider.traineeProfiles!.items![index]);
                },
                childCount: provider.traineeProfiles!.items!.length + 1,
              ),
            ),
          ],
        );
      },
    );
  }

  _profileListItem(Profile profile) {
    return InkWell(
      enableFeedback: false,
      onTap: () => AppRouter.navigateToWidget(ProfileView(profile: profile)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.sp),
        height: 108.sp,
        width: 384.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.sp),
          gradient: const LinearGradient(
            colors: [AppColors.theme1, AppColors.theme2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.sp, horizontal: 15.sp),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                height: 60.sp,
                width: 55.sp,
                decoration: BoxDecoration(
                  color: AppColors.theme1,
                  boxShadow: List.generate(
                    6,
                    (index) => BoxShadow(
                      color: AppColors.theme1,
                      blurRadius: 3.sp,
                      spreadRadius: 1.sp,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Center(child: _gitImage(profile)),
              ),
              SizedBox(width: 14.sp),
              SizedBox(
                height: 73.sp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profile.name.toString().length > 25
                          ? "${profile.name.toString().substring(0, 24)}.."
                          : profile.name.toString(),
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.vibrantColor,
                          height: 1.sp),
                    ),
                    Text(
                      profile.status ?? "No status",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.vibrantColor,
                        height: 1.sp,
                      ),
                    ),
                    // const Spacer(),
                    SizedBox(
                      height: 6.sp,
                    ),
                    Row(
                      children: [
                        Text(
                          'Member Since: ',
                          style: TextStyle(
                              color: AppColors.background,
                              fontSize: 12.sp,
                              height: 1.sp),
                        ),
                        Text(
                          DateFormatterHelper.dateFromString(
                                  profile.createdAt!.toLocal().toString())
                              .toString(),
                          style: TextStyle(
                              color: AppColors.vibrantColor,
                              fontSize: 13.sp,
                              height: 1.sp),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_right,
                color: AppColors.theme2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _gitImage(Profile profile) {
    if (profile.status != null) {
      return Image.asset(
        profile.gender == "Male"
            ? 'assets/icons/avatar_male.png'
            : 'assets/icons/avatar_female.png',
        fit: BoxFit.cover,
      );
    } else {
      return const Icon(
        Icons.person,
        size: 28,
        color: AppColors.background,
      );
    }
  }
}
