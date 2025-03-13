import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/models/content/equipment/equipment.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/assets.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/widgets/dialogs/show_loading_dialog.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EquipmentsIndex extends StatelessWidget {
  const EquipmentsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = context.watch<UserProvider>().user!.token;
    if (context.read<CoachProvider>().equipments == null) {
      context.read<CoachProvider>().getAllEquipments(token!);
    }

    return AppScaffold.build(context, _body(), screenTitle: "Equipments");
  }

  _body() {
    BuildContext context = AppRouter.navKey.currentContext!;
    String? token = context.watch<UserProvider>().user!.token;

    return Consumer<CoachProvider>(
      builder: (context, provider, child) {
        if (provider.equipments == null) {
          return Center(
              child: Lottie.asset(Assets.getAnimation(Assets.emptyBox)));
        }
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(12.sp),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.sp,
                  mainAxisSpacing: 12.sp,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == provider.equipments!.items!.length) {
                      return provider.equipments!.next == null
                          ? const Center(
                              child: Text(
                                "No more!",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                  color: AppColors.background,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                showLoadingDialog();
                                await context
                                    .read<CoachProvider>()
                                    .getEquipmentsNextPage(token!);
                                AppRouter.popFromWidget();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 150.sp,
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.sp)),
                                    color: Colors.blue),
                                child: const Text(
                                  "More..",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white),
                                ),
                              ),
                            );
                    }
                    return _equipmentItem(provider.equipments!.items![index]);
                  },
                  childCount: provider.equipments!.items!.length + 1,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _equipmentItem(Equipment equipment) {
    return Container(
      height: 1002.sp,
      width: 175.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.sp),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(130, 32, 106, 210),
            Color.fromARGB(150, 124, 17, 177)
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.sp)),
            child: SizedBox(
              height: 109.sp,
              width: 175.sp,
              child: CachedNetworkImage(
                imageUrl: equipment.image!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(
                    height: 20, child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                cacheManager: CacheManager(
                  Config(
                    equipment.image!,
                    stalePeriod: const Duration(hours: 3),
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                equipment.name.toString().length > 10
                    ? "${equipment.name.toString().substring(0, 9)}.."
                    : equipment.name.toString(),
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.theme1,
                    height: 2.sp),
              ),
              _equipmentField("Type", equipment.type),
              _equipmentField("Quantity", equipment.quantity),
              _equipmentField("Status", equipment.status),
            ],
          ),
        ],
      ),
    );
  }

  _equipmentField(String name, dynamic value) {
    return Padding(
      padding: EdgeInsets.only(left: 8.sp),
      child: SizedBox(
        width: 175,
        child: Row(
          children: [
            Text(
              "$name: ",
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.background,
              ),
            ),
            SizedBox(width: 14.sp),
            Text(
              value.toString().length > 10
                  ? "${value.toString().substring(0, 9)}.."
                  : value.toString(),
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.vibrantColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
