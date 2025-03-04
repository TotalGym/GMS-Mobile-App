import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/auth/log_in.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String? title;

  const Home({super.key, this.title});

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
