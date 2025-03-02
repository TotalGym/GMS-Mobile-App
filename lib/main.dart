import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/views/providers/program_provider.dart';
import 'package:gmn/views/providers/store_provider.dart';
import 'package:gmn/views/providers/trainee_provider.dart';
import 'package:gmn/views/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TraineeProvider()),
          ChangeNotifierProvider(create: (context) => StoreProvider()),
          ChangeNotifierProvider(create: (context) => ProgramProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Gym Management System',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const Home(title: 'Home Page'),
        ),
      ),
    );
  }
}
