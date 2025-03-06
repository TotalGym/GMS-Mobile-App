import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/home.dart';
import 'package:gmn/views/widgets/dialogs/dialog.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogIn> {
  User? user;
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
              showLoadingDialog(context);
              await Provider.of<UserProvider>(context, listen: false)
                  .logUserIn("test@test.com", 'test123');

              // ignore: use_build_context_synchronously
              if (Provider.of<UserProvider>(context, listen: false)
                  .isLoggedIn!) {
                // ignore: use_build_context_synchronously
                user = context.read<UserProvider>().user;
                AppRouter.popFromWidget();
                AppRouter.navigateWithReplacemtnToWidget(const Home());
              } else {
                AppRouter.navigateWithReplacemtnToWidget(const LogIn());
              }
            },
            child: Container(
              alignment: Alignment.center,
              width: 150.sp,
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                  color: Colors.green),
              child: Text(
                "Log In",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
