import 'package:flutter/material.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/profile/notifications_provider.dart';
import 'package:gmn/views/screens/notifications/notifications_index.dart';
import 'package:provider/provider.dart';

class TopBar extends AppBar {
  final String screenTitle;

  TopBar({
    required this.screenTitle,
    super.key,
  });

  @override
  double? get elevation => 0;

  @override
  Color? get backgroundColor => Colors.transparent;

  @override
  Widget? get title => Title(
        title: screenTitle,
        color: AppColors.theme1,
        child: Text(
          screenTitle,
          style: const TextStyle(color: AppColors.theme1),
        ),
      );

  @override
  IconThemeData? get iconTheme => const IconThemeData(
      color: AppColors.theme1, // Change the color of the drawer button icon
      size: 32);

  @override
  List<Widget>? get actions {
    BuildContext context = AppRouter.navKey.currentContext!;

    return [
      IconButton(
        onPressed: () {
          context.read<NotificationProvider>().setNoNewNotifications();
          AppRouter.navigateToWidget(const NotificationsIndex());
        },
        icon: Icon(Icons.notifications,
            size: 25,
            color: context.watch<NotificationProvider>().hasNewNotifications
                ? AppColors.accent
                : AppColors.theme1),
      )
    ];
  }
}
