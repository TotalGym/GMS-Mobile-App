// ignore: unused_import
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/values/colors.dart';

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
        child: const Center(
          child: Icon(Icons.offline_bolt),
        ),
      ),
    );
  }
}
