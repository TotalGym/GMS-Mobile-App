import 'package:flutter/material.dart';
import 'package:gmn/data/models/attendance.dart';
import 'package:gmn/data/models/program/program.dart';
import 'package:gmn/data/models/trainee/membership.dart';
import 'package:gmn/data/models/trainee/trainee.dart';
import 'package:gmn/data/models/trainee/trainee_progress_inctance.dart';
import 'package:gmn/data/network/dio_helper.dart';
import 'package:gmn/views/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DioHelper.io.getTrainee("", "");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Management System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(title: 'Home Page'),
    );
  }
}
