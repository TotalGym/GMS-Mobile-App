import 'dart:async';
// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/data/models/user/profile/profile.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/auth/log_in.dart';
import 'package:gmn/views/screens/home.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Onboarding();
  }
}

class _Onboarding extends State<OnboardingScreen> {
  bool? isLoggedIn;
  User? user;

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  _checkLoginState() async {
    await context.read<UserProvider>().checkIfLoggedIn();

    // ignore: use_build_context_synchronously
    user = context.read<UserProvider>().user;

    if (user != null) {
      if (user!.token != null) {
        // ignore: use_build_context_synchronously
        await context.read<ProfileProvider>().getProfile(user!.token!);

        // ignore: use_build_context_synchronously
        Profile? profile = context.read<ProfileProvider>().profile;
        if (profile != null) {
          // ignore: use_build_context_synchronously
          isLoggedIn = context.read<UserProvider>().isLoggedIn;
        }
      }
    }

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          isLoggedIn == null
              ? AppRouter.navigateWithReplacemtnToWidget(const LogIn())
              : AppRouter.navigateWithReplacemtnToWidget(
                  isLoggedIn! ? const Home() : const LogIn());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
