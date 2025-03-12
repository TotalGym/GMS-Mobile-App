import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:gmn/views/providers/profile/notifications_provider.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 892),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ProgramStoreProvider()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => CoachProvider()),
          ChangeNotifierProvider(create: (context) => ProfileProvider()),
          ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ],
        child: MaterialApp(
          navigatorKey: AppRouter.navKey,
          debugShowCheckedModeBanner: false,
          title: 'Gym Management System',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
