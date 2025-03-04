import 'package:flutter/material.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/home.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("LogIn"),
          InkWell(
            onTap: () async {
              await Provider.of<UserProvider>(context, listen: false)
                  .logUserIn("moha5@gmail.com", 'moh123');

              Provider.of<UserProvider>(context, listen: false).isLoggedIn
                  ? AppRouter.navigateWithReplacemtnToWidget(const Home())
                  : AppRouter.popFromWidget();
            },
            child: Container(
              decoration: const BoxDecoration(color: Colors.green),
              child: const Text("log in here"),
            ),
          ),
        ],
      )),
    );
  }
}
