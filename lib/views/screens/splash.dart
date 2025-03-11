import 'dart:async';
// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/data/models/user/profile/profile.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/data/network/connection_test.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/profile/notifications_provider.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/auth/log_in.dart';
import 'package:gmn/views/screens/auth/no_connection.dart';
import 'package:gmn/views/screens/home.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Splash();
  }
}

class _Splash extends State<SplashScreen> {
  bool isLoggedIn = false;
  User? user;

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  _checkLoginState() async {
    if (await ConnectionTest.isConnected()) {
      // ignore: use_build_context_synchronously
      await context.read<UserProvider>().checkIfLoggedIn();

      // ignore: use_build_context_synchronously
      user = context.read<UserProvider>().user;

      if (user == null) {
        await _continue();
      } else if (user!.token == null) {
        await _continue();
      }
      if (user != null && user!.token != null) {
        // ignore: use_build_context_synchronously
        await context.read<ProfileProvider>().getProfile(user!.token!);
        // ignore: use_build_context_synchronously
        Profile? profile = context.read<ProfileProvider>().profile;
        if (profile != null) {
          // ignore: use_build_context_synchronously
          isLoggedIn = context.read<UserProvider>().isLoggedIn ?? false;
          // ignore: use_build_context_synchronously
          _getNotifications(user!, context);

          _continue();
        }
      }
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          AppRouter.navigateWithReplacemtnToWidget(const NoConnectionScreen());
        },
      );
    }
  }

  _continue() async {
    Future.delayed(
      //Duration is temporary
      const Duration(seconds: 2),
      () {
        if (mounted) {
          AppRouter.navigateWithReplacemtnToWidget(
              isLoggedIn ? const Home() : const LogIn());
        }
      },
    );
  }

  _getNotifications(User user, BuildContext context) {
    user.role == "Coach"
        ? context
            .read<NotificationProvider>()
            .getCoachNotifications(user.token!)
        : context
            .read<NotificationProvider>()
            .getProfileNotifications(user.token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: null,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.background, AppColors.background_2],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset("assets/images/splash.png"),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
