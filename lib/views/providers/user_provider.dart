import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/data/helpers/shared_preferences_helper.dart';
import 'package:gmn/data/repositories/user_repos/user_repo.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  String? token;
  bool? hasToken;
  bool? isLoggedIn;

  Future<void> checkIfLoggedIn() async {
    String? token = await SharedPreferencesHelper.instance.getTokenFromGlobal();
    hasToken = token != null;
    hasToken! ? await getUser(token!) : {};
    isLoggedIn = user != null;
    notifyListeners();
  }

  getUser(String token) async {
    if (hasToken! && user == null) {
      user = await UserRepo.getUser(token);

      log("UserProvider-> checkIfLoggedIn user: ${user!.email}");
      this.token = user!.token;
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
    await UserRepo.logOut();
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
