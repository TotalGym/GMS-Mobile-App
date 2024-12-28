import 'package:flutter/material.dart';
import 'package:gmn/models/attendance.dart';
import 'package:gmn/models/program.dart';
import 'package:gmn/models/schedual_instance.dart';
import 'package:gmn/models/trainee.dart';
import 'package:gmn/models/membership.dart';
import 'package:gmn/models/trainee_progress_inctance.dart';
import 'package:gmn/views/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var program = Program('1', [SchedualInstance('sat', '09:00', '11:00')]);
    var membership =
        MemberShip(DateTime.now(), DateTime.now().add(Duration(days: 100)));
    var attendance = Attendance(DateTime.now(), 'true');
    var trainee = Trainee(
      '1',
      membership,
      [program],
      [attendance],
      TraineeProgressInstance([], {}),
      name: 'hashem',
      gender: 'Male',
      email: "hashem@gmail.com",
      phoneNumber: "0592103756",
    );

    print(trainee.toString());

    return MaterialApp(
      title: 'Gym Management System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(title: 'Home Page'),
    );
  }
}
