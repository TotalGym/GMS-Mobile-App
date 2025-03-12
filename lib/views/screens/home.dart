import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/helpers/date_formatter_helper.dart';
import 'package:gmn/data/models/content/store/product.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/views/widgets/decorations/seperator.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  final String? title;
  // User? user;

  const Home({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppScaffold.build(context, _body(), screenTitle: "Home");
  }

  _body() {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                SizedBox(
                  height: 415.sp,
                  width: 412.sp,
                  child: Image.asset(
                    'assets/images/home_bkg.png',
                    fit: BoxFit.cover,
                    height: 256,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 50.sp, left: 60.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "WELCOME,",
                        style: TextStyle(
                            fontSize: 34.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 260.h, right: 250, left: 14.w),
                  child: SizedBox(
                    height: 100.h,
                    width: 135.w,
                    child: Text(
                      DateFormatterHelper.dayFromDateTime(DateTime.now()),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 42.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          height: 1.2),
                    ),
                  ),
                ),
                Consumer<UserProvider>(builder: (context, provider, child) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: 14.sp,
                    ),
                    child: Text(
                      provider.user!.name.toString().length > 20
                          ? "${provider.user!.name.toString().substring(0, 19)}.."
                              .toUpperCase()
                          : provider.user!.name.toString().toUpperCase(),
                      style: TextStyle(
                          fontSize: 26.sp,
                          color: AppColors.vibrantColor,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Your Membership ends on",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _getMemberShipEndDate(),
                        style:
                            TextStyle(fontSize: 15.sp, color: AppColors.theme1),
                      ),
                    ],
                  ),
                  seperator(
                    marginLeft: 0,
                    width: 375.w,
                    marginTop: 4.h,
                    height: 3,
                  )
                ],
              ),
            ),
            Consumer<ProgramStoreProvider>(
              builder: (context, provider, child) {
                return SizedBox(
                  height: 370.h,
                  width: 384,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Programs",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      provider.homePrograms != null
                          ? Container(
                              height: 335.h,
                              width: 384.w,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.homePrograms!.length,
                                itemBuilder: (context, index) {
                                  return _programListItem(
                                      provider.homePrograms![index]);
                                },
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                );
              },
            ),
            Consumer<ProgramStoreProvider>(
              builder: (context, provider, child) {
                return SizedBox(
                  // height: 370.h,
                  width: 384,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Products",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      provider.homeProducts != null
                          ? Container(
                              margin: const EdgeInsets.symmetric(vertical: 9),
                              height: 140.h,
                              width: 384.w,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.homeProducts!.length,
                                itemBuilder: (context, index) {
                                  return _productListItem(
                                      provider.homeProducts![index]);
                                },
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _programListItem(Program program) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        gradient: LinearGradient(colors: [
          Color(0xef2069D2),
          Color(0xef7C11B1),
        ], begin: Alignment.topRight, end: Alignment.bottomLeft),
      ),
      height: 335.h,
      width: 226.w,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.sp)),
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  SizedBox(
                    height: 150.h,
                    width: 226.sp,
                    child: Image.network(
                      program.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 36.sp,
                    decoration: const BoxDecoration(
                      color: Color(0xcc585F69),
                    ),
                    child: Center(
                      child: Text(
                        program.name.toString().length > 30
                            ? "${program.name.toString().substring(0, 29)}.."
                            : program.name.toString(),
                        style: TextStyle(
                            fontSize: 18.sp, color: AppColors.vibrantColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                program.description ?? "No Description",
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.vibrantColor,
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7.sp, horizontal: 12.w),
              height: 70.h,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                color: Color(0xef585F69),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Monthly",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        program.monthlyPrice.toString(),
                        style: const TextStyle(
                            color: AppColors.vibrantColor,
                            fontSize: 30,
                            height: 1.2),
                      ),
                    ],
                  ),
                  seperator(
                      marginLeft: 0,
                      marginRight: 0,
                      marginBottom: 0,
                      marginTop: 0,
                      height: 50,
                      width: 2,
                      color: Colors.white),
                  Column(
                    children: [
                      const Text(
                        "Annual",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        program.annualPrice.toString(),
                        style: const TextStyle(
                            color: AppColors.vibrantColor,
                            fontSize: 30,
                            height: 1.2),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]),
    );
  }

  _productListItem(Product product) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            SizedBox(
              height: 140.h,
              width: 226.w,
              child: Image.network(
                product.image!,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 36.h,
              width: 226.w,
              decoration: const BoxDecoration(
                color: Color(0xcc585F69),
              ),
              child: Center(
                child: Text(
                  product.productName.toString().length > 30
                      ? "${product.productName.toString().substring(0, 29)}.."
                      : product.productName.toString(),
                  style:
                      TextStyle(fontSize: 18.sp, color: AppColors.vibrantColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getMemberShipEndDate() {
    BuildContext context = AppRouter.navKey.currentContext!;
    Map? membership = context.read<ProfileProvider>().profile!.membership;

    if (membership == null) return 'no data';
    if (membership["endDate"] == null) return 'no data';
    return DateFormatterHelper.dateFromString(membership["endDate"]);
  }

  //
  //
  //
}
