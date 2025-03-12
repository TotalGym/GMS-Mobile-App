// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/screens/splash.dart';

// ignore: must_be_immutable
class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NoConnection();
  }
}

class _NoConnection extends State<NoConnectionScreen> {
  @override
  void initState() {
    super.initState();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.wifi_off,
                size: 60,
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  AppRouter.navigateWithReplacemtnToWidget(
                      const SplashScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.blue),
                  child: const Text(
                    "Try again",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
