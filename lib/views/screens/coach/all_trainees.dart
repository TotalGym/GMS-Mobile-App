import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:provider/provider.dart';

class TraineesIndex extends StatelessWidget {
  const TraineesIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite.sp,
        width: double.infinity,
        child:
            Consumer<CoachProvider>(builder: (context, coachProvider, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(20.sp),
                child: Text("${++index} >> data point"),
              );
            },
            shrinkWrap: true,
            itemCount: 40,
          );
        }),
      ),
    );
  }
}
