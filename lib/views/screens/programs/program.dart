import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/models/content/program/exercise.dart';
import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/widgets/decorations/seperator.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';

class ProgramView extends StatelessWidget {
  final Program program;
  const ProgramView(
    this.program, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold.build(context, _body(program));
  }

  _body(Program program) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 18.sp),
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
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(24.sp)),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      SizedBox(
                        height: 256.sp,
                        width: 384.sp,
                        child: Image.network(
                          program.image!,
                          fit: BoxFit.cover,
                          height: 256,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        height: 40.sp,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12)),
                            color: AppColors.background_2Alpha),
                        child: SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Program Name: ",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                program.name!,
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color: AppColors.vibrantColor),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 6.sp, vertical: 18.sp),
                  padding: EdgeInsets.all(18.sp),
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
                  child: Text(
                    program.description ?? "No Description",
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.vibrantColor,
                    ),
                  ),
                ),
                seperator(),
                _exercises(program.exercises!)

                // _profileField("Email", profile.contactEmail),
                // _profileField("Phone", profile.phoneNumber),
                // _profileField("Gender", profile.gender),
                // _profileField("Role", profile.role),
                // _profileField("Status", profile.status),
                // _profileField("Membership", profile.membership),
                // const Spacer(),
                // _profileButton("Progress", Home()),
                // _profileButton("Attendance", Home()),
              ]),
        ),
      ),
    );
  }

  _exercises(List<Exercise> exercises) {
    return SizedBox(
      height: 115.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Text(
              "Exercises",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                  height: 0.1.sp),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6.sp),
            height: 100,
            child: ListView.builder(
              itemBuilder: (context, index) => _exercise(exercises[index]),
              itemCount: exercises.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            ),
          )
        ],
      ),
    );
  }

  _exercise(Exercise exercise) {
    return Container(
      height: 90.sp,
      width: 115,
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
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
    );
  }
}
