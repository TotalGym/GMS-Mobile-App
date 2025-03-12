import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/assets.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/widgets/dialogs/show_loading_dialog.dart';
import 'package:gmn/views/widgets/snack_bars/auth_snack_bars.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordState();
  }
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
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
              Lottie.asset(Assets.getAnimation(Assets.login)),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 50.sp, vertical: 30.h),
                child: SizedBox(
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: oldPasswordController,
                          decoration: const InputDecoration(
                            hintText: 'old password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) => _passwordValidator(value),
                        ),
                        SizedBox(height: 20.h),
                        TextFormField(
                          controller: newPasswordController,
                          decoration: const InputDecoration(
                            hintText: 'new password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) => _passwordValidator(value),
                        ),
                        SizedBox(height: 20.h),
                        InkWell(
                          onTap: () async {
                            if (_formkey.currentState!.validate()) {
                              showLoadingDialog();
                              bool success = await _changePassword(
                                  oldPasswordController.text,
                                  newPasswordController.text);
                              AppRouter.popFromWidget();

                              success
                                  ? {
                                      showSuccessfullyChangePasswordSnackBar(),
                                      _formkey.currentState!.reset()
                                    }
                                  : showFailedLoginSnackBar();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 50.sp),
                            alignment: Alignment.center,
                            width: 185.w,
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
                              "Change Password",
                              style: TextStyle(
                                  fontSize: 16.sp, color: AppColors.background),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<bool> _changePassword(String oldPassword, String newPassword) async {
    bool success = false;

    success = await Provider.of<UserProvider>(context, listen: false)
        .changePassword(oldPassword, newPassword);

    return success;
  }

  String? _passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Please enter a password';
    }
    // Password length validation
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
