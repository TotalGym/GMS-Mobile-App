import 'package:flutter/material.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/auth/log_in.dart';
import 'package:gmn/views/screens/home.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({super.key});

  bool isLoggedIn = false;
  @override
  State<StatefulWidget> createState() {
    return _Onboarding();
  }
}

class _Onboarding extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<UserProvider>().checkIfLoggedIn();
    widget.isLoggedIn = context.watch<UserProvider>().isLoggedIn;

    return widget.isLoggedIn ? const Home() : LogIn();
  }
}
