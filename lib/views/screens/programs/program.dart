import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/helpers/date_formatter_helper.dart';
import 'package:gmn/data/models/content/program/exercise.dart';
import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/values/app_router.dart';
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
    return AppScaffold.build(context, _body(program), screenTitle: "Program");
  }

  _body(Program program) {
    BuildContext context = AppRouter.navKey.currentContext!;
    return SizedBox(
      height: MediaQuery.of(context).size.height - 20.sp,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 18.sp),
          // height: 675.sp,
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
                _exercises(program.exercises!),
                seperator(),
                _schedule(program.schedual!), seperator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _price("Monthly", program.monthlyPrice!),
                        _price("Annual", program.annualPrice!)
                      ]),
                ),
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
            padding: EdgeInsets.all(4.sp),
            child: Text(
              "Exercises",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                  height: 0.5.sp),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4.sp),
            height: 90.sp,
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
      width: 115.sp,
      margin: EdgeInsets.symmetric(horizontal: 10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(84, 32, 106, 210),
            Color.fromARGB(84, 124, 17, 177)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              exercise.name,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.theme1,
                  height: 0.1.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  exercise.repetitions.toString(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.vibrantColor,
                      height: 0.1.sp),
                ),
                Text(
                  "Repetitions",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                      height: 0.1.sp),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  exercise.sets.toString(),
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.vibrantColor,
                      height: 0.1.sp),
                ),
                Text(
                  "Sets       ",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                      height: 0.1.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _schedule(List schedule) {
    return SizedBox(
      height: 85.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(4.sp),
            child: Text(
              "Schedule",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.background,
                  height: 0.5.sp),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4.sp),
            height: 60.sp,
            child: ListView.builder(
              itemBuilder: (context, index) => _scheduleItem(schedule[index]),
              itemCount: schedule.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            ),
          )
        ],
      ),
    );
  }

  _scheduleItem(Map exercise) {
    return Container(
      height: 100.h,
      width: 150.w,
      margin: EdgeInsets.symmetric(horizontal: 8.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(84, 32, 106, 210),
            Color.fromARGB(84, 124, 17, 177)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            exercise['day'].toString(),
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.theme1,
                height: 0.1.sp),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                DateFormatterHelper.timeFromString(exercise['startTime']),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.vibrantColor,
                    height: 0.1.sp),
              ),
              Text(
                "-",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.vibrantColor,
                    height: 0.1.sp),
              ),
              Text(
                DateFormatterHelper.timeFromString(exercise['endTime']),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.vibrantColor,
                    height: 0.1.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _price(String type, num price) {
    return Container(
      padding: EdgeInsets.only(top: 14.sp),
      height: 165.h,
      width: 140.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.sp),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(84, 32, 106, 210),
            Color.fromARGB(84, 124, 17, 177)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            type,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.theme1,
                height: 0.1.sp),
          ),
          // const SizedBox(
          //   height: 100,
          // ),

          Padding(
            padding: EdgeInsets.only(top: 22.sp),
            child: Text(
              price.toString(),
              style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                  height: 2.sp),
            ),
          ),
          const Spacer(),
          Container(
            height: 24.h,
            width: 140.sp,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(12.sp)),
              color: AppColors.accent,
            ),
          )
        ],
      ),
    );
  }
}
