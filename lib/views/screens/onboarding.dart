import 'dart:async';
// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/values/app_router.dart';
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
    isLoggedIn = context.read<UserProvider>().isLoggedIn;
    user = context.read<UserProvider>().user;

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          isLoggedIn == null
              ? AppRouter.navigateWithReplacemtnToWidget(const LogIn())
              : AppRouter.navigateWithReplacemtnToWidget(
                  isLoggedIn! ? Home(user: user) : const LogIn());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
