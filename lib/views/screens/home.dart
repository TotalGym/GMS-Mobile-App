import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/models/user/user.dart';

import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/coach_provider.dart';
import 'package:gmn/views/providers/notification_provider.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/auth/log_in.dart';
import 'package:gmn/views/screens/coach/all_trainees.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  final String? title;
  User? user;

  Home({super.key, this.title, this.user});

  @override
  Widget build(BuildContext context) {
    //ignore: avoid_log
    // log("this is from Home->build and this is the token: ${Provider.of<UserProvider>(context, listen: false).token}");
    // Provider.of<TraineeProvider>(context, listen: false).getTrainee();
    // Provider.of<ProgramProvider>(context, listen: false).getAllPrograms();
    // return Consumer<TraineeProvider>(builder: (context, value, child) {
    // value.getTrainee();
    // context.read<UserProvider>().getUser("moha5gmail.com", 'moh123');
    // Provider.of<UserProvider>(context, listen: false)
    //     .logUserIn("moha5@gmail.com", 'moh123');
    // SharePreferencesHelper();

    // nessessary to do:
    // context.read<NotificationProvider>().getNotifications(user!.token!);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 100.sp, horizontal: 14.sp),
        child: SizedBox(
          width: double.infinity,
          child: Consumer<UserProvider>(
            builder: (context, provider, child) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Email is: ${user != null ? user!.email : "No Email"}"),
                Text("id is: ${user != null ? user!.id : "No id"}"),
                InkWell(
                  onTap: () {
                    String oldPassword = "admin123";
                    String newPassword = "admin123";
                    provider.changePassword(oldPassword, newPassword);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.sp,
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                        color: Colors.blue),
                    child: Text(
                      "change password",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    provider.logUserOut();
                    AppRouter.navigateWithReplacemtnToWidget(const LogIn());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.sp,
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                        color: Colors.red[400]),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.white),
                    ),
                  ),
                ),
                Text(
                    "From profile phone is: ${provider.traineeProfile != null ? provider.traineeProfile!.phoneNumber : "No phone"}"),
                Text(
                    "From profile attendence is: ${provider.traineeProfile != null ? provider.traineeProfile!.attendance : "No attendance"}"),
                if (user!.role == "Coach")
                  InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                              child: Dialog(
                                backgroundColor: Colors.transparent,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          });
                      await Provider.of<CoachProvider>(context, listen: false)
                          .getAllTrainees(provider.token!);
                      await Future.delayed(const Duration(seconds: 2));
                      AppRouter.popFromWidget();
                      AppRouter.navigateToWidget(const TraineesIndex());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 150.sp,
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                          color: Colors.blue[800]),
                      child: Text(
                        "All Trainees",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: Colors.white),
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: Dialog(
                              backgroundColor: Colors.transparent,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        });
                    await Provider.of<ProgramStoreProvider>(context,
                            listen: false)
                        .getHomeState(provider.token!);
                    await Future.delayed(const Duration(seconds: 2));
                    AppRouter.popFromWidget();
                    AppRouter.navigateToWidget(const TraineesIndex());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.sp,
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                        color: Colors.yellow[900]),
                    child: Text(
                      "Home",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.white),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    showDialog(
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 20.sp,
                            width: 20.sp,
                            child: const Dialog(
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          );
                        });
                    await context.read<CoachProvider>().loadAll(user!.token!);

                    await Future.delayed(const Duration(seconds: 2));
                    AppRouter.popFromWidget();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 150.sp,
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                        color: Colors.yellow[900]),
                    child: Text(
                      "I'm a coach 💪",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.white),
                    ),
                  ),
                ),
                Consumer<NotificationProvider>(
                    builder: (context, provider, child) {
                  int notificationsCount = provider.notificationsCount;
                  return notificationsCount > 0
                      ? Text("Notifications: $notificationsCount")
                      : const SizedBox();
                }),
                Consumer<CoachProvider>(builder: (context, provider, child) {
                  int equipmentCount = provider.equipmentsCount;
                  return equipmentCount > 0
                      ? Text("Equipments count: $equipmentCount")
                      : const SizedBox();
                }),
                Consumer<CoachProvider>(builder: (context, provider, child) {
                  int traineesCount = provider.traineesCount;
                  return traineesCount > 0
                      ? Text("Trainees count: $traineesCount")
                      : const SizedBox();
                }),

                // SizedBox(
                //   height: 150,
                //   width: 150,
                //   child: CachedNetworkImage(
                //     imageUrl:
                //         "https://thebrandhopper.com/wp-content/uploads/2021/10/Product-Innovation.jpg",
                //     progressIndicatorBuilder:
                //         (context, url, downloadProgress) =>
                //             CircularProgressIndicator(
                //                 value: downloadProgress.progress),
                //     errorWidget: (context, url, error) =>
                //         const Icon(Icons.error),
                //   ),
                // ),
                // ListView.builder(
                //   itemBuilder: (context, index) {
                //     return const Text('data');
                //   },
                //   itemCount: 100,
                //   scrollDirection: Axis.vertical,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
