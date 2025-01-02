import 'package:flutter/material.dart';
import 'package:gmn/models/attendance.dart';
import 'package:gmn/models/program.dart';
import 'package:gmn/models/trainee/membership.dart';
import 'package:gmn/models/trainee/trainee.dart';
import 'package:gmn/models/trainee/trainee_progress_inctance.dart';
import 'package:gmn/views/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // // var program = Program('1', [SchedualInstance('sat', '09:00', '11:00')]);
    // var membership =
    //     MemberShip(DateTime.now(), DateTime.now().add(Duration(days: 100)));
    // var attendance = Attendance(DateTime.now(), 'true');
    // var trainee = Trainee(
    //   '1',
    //   membership,
    //   ['program'],
    //   [attendance],
    //   TraineeProgressInstance([], {}),
    //   name: 'hashem',
    //   gender: 'Male',
    //   email: "hashem@gmail.com",
    //   phoneNumber: "0592103756",
    // );
    Map<String, dynamic> mapJS = {
      "ID": "ObjectId",
      "Name": "Hashem",
      "Contact": {"Email": "email@mail.com", "PhoneNumber": "31665416216"},
      "Gender": "Male",
      "Membership": {"StartDate": 20250101, "EndDate": 20250102},
      "Attendance": [
        {"Date": 20250101, "Status": "True"},
        {"Date": 20250102, "Status": "True"},
        {"Date": 20250103, "Status": "True"},
        {"Date": 20250104, "Status": "True"},
        {"Date": 20250105, "Status": "True"},
        {"Date": 20250106, "Status": "True"},
        {"Date": 20250107, "Status": "True"},
      ],
      "SelectedPrograms": [
        "ObjectId",
        "adfd",
        "adfasdf",
        "adfasdfasdf",
        "asdfdf"
      ], // References to Programs
      "Progress": {
        "Milestones": ["String"],
        "Metrics": {"Key": "Value"}
      }
    };
    var trainee = Trainee.fromMap(mapJS);

    // print(mapJS);

    print(trainee.toMap());

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
