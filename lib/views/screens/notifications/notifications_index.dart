import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/helpers/date_formatter_helper.dart';
import 'package:gmn/data/models/content/notification/notification.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/profile/notifications_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/widgets/dialogs/show_loading_dialog.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NotificationsIndex extends StatelessWidget {
  const NotificationsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = context.watch<UserProvider>().user;
    context.read<NotificationProvider>().deleteAll();
    if (user!.role == "Coach") {
      context.read<NotificationProvider>().getCoachNotifications(user.token!);
    } else {
      context.read<NotificationProvider>().getProfileNotifications(user.token!);
    }

    return AppScaffold.build(context, _body(user.role!),
        screenTitle: "Notifications");
  }

  _body(String userRole) {
    BuildContext context = AppRouter.navKey.currentContext!;
    String? token = context.read<UserProvider>().user!.token;
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        if (provider.notifications == null ||
            provider.notifications!.items == null) {
          return const Center(child: Text("Nothing Arrived Yet.."));
        }
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == provider.notifications!.items!.length) {
                    return provider.notifications!.next == null
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
                              userRole == "Coach"
                                  ? await context
                                      .read<NotificationProvider>()
                                      .getCoachNotificationsNextPage(token!)
                                  : await context
                                      .read<NotificationProvider>()
                                      .getProfileNotificationsNextPage(token!);
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
                  return _notificationListItem(
                      provider.notifications!.items![index]);
                },
                childCount: provider.notifications!.items!.length + 1,
              ),
            ),
          ],
        );
      },
    );
  }

  _notificationListItem(NotificationState notification) {
    return InkWell(
      enableFeedback: false,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.sp),
        width: 384.sp,
        height: 108.sp,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.theme1, AppColors.theme2],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(top: 2.sp, bottom: 12.sp, left: 18, right: 18.sp),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${DateFormatterHelper.dateFromString(notification.date.toString())} - ${DateFormatterHelper.timeFromDateTime(notification.date!)}",
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.background,
                    ),
                  ),
                  Text(
                    notification.content.toString().length > 30
                        ? "${notification.content.toString().substring(0, 29)}.."
                        : notification.content.toString(),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.vibrantColor,
                      height: 2.sp,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _isViewed(notification)
            ],
          ),
        ),
      ),
    );
  }

  _isViewed(NotificationState notification) {
    if (!notification.viewByUser) {
      notification.viewByUser = true;
      return const Icon(
        Icons.circle,
        color: AppColors.accent,
      );
    }
    return const SizedBox();
  }
}
