import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:gmn/views/providers/profile/notifications_provider.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/auth/change_password.dart';
import 'package:gmn/views/screens/equipments/equipments_index.dart';
import 'package:gmn/views/screens/notifications/notifications_index.dart';
import 'package:gmn/views/screens/profile/profiles_index.dart';
import 'package:gmn/views/screens/profile/profile.dart';
import 'package:gmn/views/screens/programs/programs_index.dart';
import 'package:gmn/views/screens/store/all_products.dart';
import 'package:gmn/views/widgets/dialogs/show_loading_dialog.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  final String? title;
  // User? user;

  const Home({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    //ignore: avoid_log
    // log("this is from Home->build and this is the token: ${Provider.of<UserProvider>(context, listen: false).token}");
    // Provider.of<ProfileProvider>(context, listen: false).getProfile();
    // Provider.of/ProgramProvider>(context, listen: false).getAllPrograms();
    // return Consumer<ProfileProvider>(builder: (context, value, child) {
    // value.getProfile();
    // context.read<UserProvider>().getUser("moha5gmail.com", 'moh123');
    // Provider.of<UserProvider>(context, listen: false)
    //     .logUserIn("moha5@gmail.com", 'moh123');
    // SharePreferencesHelper();

    // nessessary to do:
    // context.read<NotificationProvider>().getNotifications(user!.token!);

    return Scaffold(
      body: Consumer<UserProvider>(builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 100.sp, horizontal: 14.sp),
          child: SizedBox(
            width: double.infinity,
            child: Consumer<UserProvider>(
              builder: (context, provider, child) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      "Email is: ${provider.user != null ? provider.user!.email : "No Email"}"),
                  Text(
                      "id is: ${provider.user != null ? provider.user!.id : "No id"}"),
                  InkWell(
                    onTap: () {
                      String oldPassword = "admin123";
                      String newPassword = "admin123";
                      provider.changePassword(oldPassword, newPassword);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 190.sp,
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.sp)),
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
                    onTap: () async {
                      provider.logUserOut();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 150.sp,
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.sp)),
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
                  if (provider.user != null && provider.user!.role == "Coach")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            // showLoadingDialog(context);
                            // ignore: use_build_context_synchronously

                            AppRouter.navigateToWidget(const EquipmentsIndex());
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
                              "Equipment",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // showLoadingDialog(context);
                            // ignore: use_build_context_synchronously

                            AppRouter.navigateToWidget(const ProfilesIndex());
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
                      showLoadingDialog();
                      // ignore: use_build_context_synchronously
                      await Provider.of<ProgramStoreProvider>(context,
                              listen: false)
                          .getHomeState(provider.token!);
                      AppRouter.navigateToWidget(const ProfilesIndex());
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
                      showLoadingDialog();
                      // ignore: use_build_context_synchronously
                      await context
                          .read<CoachProvider>()
                          .loadAll(provider.user!.token!);
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
                  InkWell(
                    onTap: () async {
                      AppRouter.navigateToWidget(const ProfileView());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 150.sp,
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                          color: Colors.yellow[900]),
                      child: Consumer<ProfileProvider>(
                        builder: (context, provider, child) {
                          return Text(
                            "Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      AppRouter.navigateToWidget(const ChangePassword());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 150.sp,
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                          color: Colors.yellow[900]),
                      child: Consumer<ProfileProvider>(
                        builder: (context, provider, child) {
                          return Text(
                            "Change Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      AppRouter.navigateToWidget(const NotificationsIndex());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 150.sp,
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.sp)),
                          color: Colors.yellow[900]),
                      child: Consumer<ProfileProvider>(
                        builder: (context, provider, child) {
                          return Text(
                            "Notifications",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                  Consumer<NotificationProvider>(
                      builder: (context, provider, child) {
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
        );
      }),
    );
  }
}
