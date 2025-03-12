import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/models/content/program/program.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/assets.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/programs/program.dart';
import 'package:gmn/views/widgets/dialogs/show_loading_dialog.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProgramsIndex extends StatelessWidget {
  const ProgramsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = context.watch<UserProvider>().user!.token;
    if (context.read<ProgramStoreProvider>().programs == null) {
      context.read<ProgramStoreProvider>().getAllPrograms(token!);
    }

    return AppScaffold.build(context, _body(), screenTitle: "Programs");
  }

  _body() {
    BuildContext context = AppRouter.navKey.currentContext!;
    String? token = context.watch<UserProvider>().user!.token;
    return Consumer<ProgramStoreProvider>(
      builder: (context, provider, child) {
        if (provider.programs == null) {
          return Center(
              child: Lottie.asset(Assets.getAnimation(Assets.emptyBox)));
        }
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == provider.programs!.items!.length) {
                    return provider.programs!.next == null
                        ? const Center(
                            child: Text(
                              "No more!",
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.background),
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              showLoadingDialog();
                              await context
                                  .read<ProgramStoreProvider>()
                                  .getProgramsNextPage(token!);
                              AppRouter.popFromWidget();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 150.sp,
                              padding: EdgeInsets.all(12.sp),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.sp)),
                                  color: Colors.blue),
                              child: const Text(
                                "More..",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                  }
                  return _programListItem(provider.programs!.items![index]);
                },
                childCount: provider.programs!.items!.length + 1,
              ),
            ),
          ],
        );
      },
    );
  }

  _programListItem(Program program) {
    return InkWell(
      enableFeedback: false,
      onTap: () => AppRouter.navigateToWidget(ProgramView(program)),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.sp),
        width: 384.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.sp),
          gradient: const LinearGradient(
            colors: [AppColors.theme1, AppColors.theme2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.sp, horizontal: 15.sp),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.name.toString().length > 10
                        ? "${program.name.toString().substring(0, 9)[0]}.."
                        : program.name.toString(),
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.vibrantColor,
                        height: 1.5.sp),
                  ),
                  SizedBox(
                    width: 310.w,
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
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_right,
                color: AppColors.theme2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
