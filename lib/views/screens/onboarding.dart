import 'dart:async';
// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<UserProvider>().checkIfLoggedIn();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isLoggedIn = context.watch<UserProvider>().isLoggedIn;

    Future.delayed(
      const Duration(seconds: 4),
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
