import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
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

    return AppScaffold.build(context, _body());
  }

  _body() {
    BuildContext context = AppRouter.navKey.currentContext!;
    String? token = context.read<UserProvider>().user!.token;
    return Consumer<CoachProvider>(
      builder: (context, provider, child) {
        if (provider.traineeProfiles == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Consumer<CoachProvider>(
          builder: (context, provider, child) => Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 150.sp,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(20.sp),
                      child: Text(
                          "Profile id: ${provider.traineeProfiles!.items![index].id}"),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: provider.traineeProfiles!.items!.length,
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<CoachProvider>().getProfilesNextPage(token!);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 150.sp,
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                      color: Colors.blue),
                  child: const Text(
                    "Refresh",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<CoachProvider>().resetProfiles();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 150.sp,
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                      color: Colors.red[400]),
                  child: const Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
