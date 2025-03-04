import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/data/repositories/shared_preferences_helper.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  String? token;
  bool? isLoggedIn;

  checkIfLoggedIn() async {
    String? token = await SharedPreferencesHelper.instance.getTokenFromGlobal();
    isLoggedIn = token != null;

    if (isLoggedIn! && user == null) {
      user = await User.getUser(token!);
      //ignore: avoid_log
      log("UserProvider-> checkIfLoggedIn user: ${user!.email}");
      this.token = token;
    }
    notifyListeners();
  }

  logUserIn(String email, String password) async {
    user = await User.login(email, password);
    token = await SharedPreferencesHelper.instance.getTokenFromGlobal();
    isLoggedIn = token != null;

    notifyListeners();
  }

  logUserOut() async {
    await User.logOut();
    user = null;
    token = null;
    isLoggedIn = false;
    notifyListeners();
  }

  changePassword(String oldPassword, String newPassword) async {
    await user?.chagePassword(
      oldPassword,
      newPassword,
    );
  }
}
