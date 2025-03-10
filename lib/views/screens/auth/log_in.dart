import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/screens/home.dart';
import 'package:gmn/views/widgets/dialogs/dialog.dart';
import 'package:gmn/views/widgets/snack_bars/auth_snack_bars.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LogInState();
  }
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: null,
      extendBodyBehindAppBar: true,
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.background, AppColors.background_2],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/images/login_intro.png"),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 50.sp, vertical: 120.h),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'email',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20.h),
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: 'password',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: () async {
                          showLoadingDialog(context);
                          bool success = await _login(
                              emailController.text, passwordController.text);
                          AppRouter.popFromWidget();

                          success
                              ? AppRouter.navigateWithReplacemtnToWidget(
                                  const Home())
                              : showFailedLoginSnackBar();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 50.sp),
                          alignment: Alignment.center,
                          width: 178.w,
                          height: 55.h,
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.theme1, AppColors.theme2],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.sp)),
                              color: Colors.green),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                fontSize: 16.sp, color: AppColors.background),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<bool> _login(String email, String password) async {
    bool success = false;
    User? user;

    await Provider.of<UserProvider>(context, listen: false)
        .logUserIn(email.toLowerCase().trim(), password.trim());

    // ignore: use_build_context_synchronously
    context.read<UserProvider>().isLoggedIn!
        // ignore: use_build_context_synchronously
        ? user = context.read<UserProvider>().user
        : {};
    if (user == null) {
      return success;
    } else if (user.token == null) {
      return success;
    }
    // ignore: use_build_context_synchronously
    await context.read<ProfileProvider>().getProfile(user.token!);

    // ignore: use_build_context_synchronously
    if (context.read<ProfileProvider>().profile != null) {
      success = true;
    }

    return success;
  }
}
