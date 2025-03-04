import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/auth/log_in.dart';
import 'package:gmn/views/screens/coach/all_trainees.dart';
import 'package:gmn/views/screens/programs/all_programs.dart';
import 'package:gmn/views/screens/store/all_products.dart';
import 'package:gmn/views/widgets/dialogs/dialog.dart';
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
    // Provider.of/ProgramProvider>(context, listen: false).getAllPrograms();
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
                if (user!.role == "Coach")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          // showLoadingDialog(context);
                          // ignore: use_build_context_synchronously

                          AppRouter.navigateToWidget(const TraineesIndex());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 95.sp,
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.sp)),
                              color: Colors.blue[800]),
                          child: Text(
                            "Trainees",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          AppRouter.navigateToWidget(const ProductsIndex());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 95.sp,
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.sp)),
                              color: Colors.blue[800]),
                          child: Text(
                            "Prouducts",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          AppRouter.navigateToWidget(const ProgramsIndex());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 95.sp,
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.sp)),
                              color: Colors.blue[800]),
                          child: Text(
                            "Programs",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                InkWell(
                  onTap: () async {
                    showLoadingDialog(context);
                    // ignore: use_build_context_synchronously
                    await Provider.of<ProgramStoreProvider>(context,
                            listen: false)
                        .getHomeState(provider.token!);
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
                    showLoadingDialog(context);
                    // ignore: use_build_context_synchronously
                    await context.read<CoachProvider>().loadAll(user!.token!);
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
                Consumer<CoachProvider>(builder: (context, provider, child) {
                  if (provider.notifications == null) return const SizedBox();
                  int notificationsCount = provider.notifications!.totalCount;
                  return notificationsCount > 0
                      ? Text("Notifications: $notificationsCount")
                      : const SizedBox();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
