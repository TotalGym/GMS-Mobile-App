import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/data/helpers/shared_preferences_helper.dart';
import 'package:gmn/data/repositories/user_repos/user_repo.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/views/providers/profile/coach_provider.dart';
import 'package:gmn/views/providers/profile/notifications_provider.dart';
import 'package:gmn/views/providers/profile/profile_provider.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/screens/auth/log_in.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  String? token;
  bool? hasToken;
  bool? isLoggedIn;

  Future<void> checkIfLoggedIn() async {
    String? token = await SharedPreferencesHelper.instance.getTokenFromGlobal();
    hasToken = token != null;
    hasToken! ? await getUser(token!) : {};
    isLoggedIn = user != null && user!.token != null;
    notifyListeners();
  }

  getUser(String token) async {
    if (hasToken! && user == null) {
      user = await UserRepo.getUser(token);
      if (user != null) {
        log("UserProvider-> checkIfLoggedIn user: ${user!.email}");
        this.token = user!.token;
      }
    }
    notifyListeners();
  }

  logUserIn(String email, String password) async {
    user = await UserRepo.login(email, password);
    token = await SharedPreferencesHelper.instance.getTokenFromGlobal();
    isLoggedIn = token != null;
    notifyListeners();
  }

  logUserOut() async {
    AppRouter.navigateWithReplacemtnToWidget(const LogIn());
    await UserRepo.logOut();
    user = null;
    token = null;
    hasToken = false;
    isLoggedIn = false;

    BuildContext context = AppRouter.navKey.currentContext!;
    // ignore: use_build_context_synchronously
    Provider.of<ProgramStoreProvider>(context, listen: false).reset();
    // ignore: use_build_context_synchronously
    Provider.of<CoachProvider>(context, listen: false).reset();
    // ignore: use_build_context_synchronously
    Provider.of<ProfileProvider>(context, listen: false).reset();
    // ignore: use_build_context_synchronously
    Provider.of<NotificationProvider>(context, listen: false).reset();
    notifyListeners();
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    bool success = false;
    success = await user!.chagePassword(
      oldPassword,
      newPassword,
    );
    return success;
  }
}
