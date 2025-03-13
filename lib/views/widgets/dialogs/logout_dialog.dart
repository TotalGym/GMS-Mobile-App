import 'package:flutter/material.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/auth/log_in.dart';
import 'package:provider/provider.dart';

showLogoutDialog() {
  BuildContext context = AppRouter.navKey.currentContext!;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              AppRouter.popFromWidget();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              AppRouter.navKey.currentContext!
                  .read<UserProvider>()
                  .logUserOut();

              AppRouter.popFromWidget();
              AppRouter.navigateWithReplacemtnToWidget(const LogIn());
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}
