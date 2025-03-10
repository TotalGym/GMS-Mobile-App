import 'dart:developer';

import 'package:gmn/data/models/user/auth.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/data/helpers/shared_preferences_helper.dart';

class UserRepo {
  static login(String email, String password) async {
    Map userMap = await Auth.login(email, password);
    User user = User.fromMap(userMap);
    if (user.token != null && user.email != null) {
      SharedPreferencesHelper.instance.setTokenToGlobal(user.token ?? "");
      return user;
    }
    return null;
  }

  static getUser(String token) async {
    Map userMap = await Auth().user(token);
    log("User-> getUser userMap: ${userMap.toString()}");

    User user = User.fromMap(userMap);
    log("User-> getUser user: ${user.email}");
    if (user.token != null) {
      return user;
    }
    return null;
  }

  static logOut() async {
    await SharedPreferencesHelper.instance.deleteTokenFromGlobal();
  }
}
