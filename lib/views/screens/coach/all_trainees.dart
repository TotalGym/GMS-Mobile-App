import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TraineesIndex extends StatelessWidget {
  const TraineesIndex({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = context.watch<UserProvider>().user!.token;
    if (context.read<CoachProvider>().trainees == null) {
      context.read<CoachProvider>().getAllTrainees(token!);
    }

    return Scaffold(
      body: Consumer<CoachProvider>(builder: (context, coachProvider, child) {
        if (coachProvider.trainees == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 150.sp,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Text(
                        "Trainee id: ${coachProvider.trainees!.items![index].id}"),
                  );
                },
                shrinkWrap: true,
                itemCount: coachProvider.trainees!.items!.length,
              ),
            ),
            InkWell(
              onTap: () {
                context.read<CoachProvider>().getTraineesNextPage(token!);
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
                context.read<CoachProvider>().resetTrainees();
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
        );
      }),
    );
  }
}
