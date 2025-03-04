import 'dart:developer';

import 'package:gmn/data/models/user/auth.dart';
import 'package:gmn/data/repositories/shared_preferences_helper.dart';

class User {
  static String mName = "auth/user";

  String? token;
  String? name;
  String? email;
  String? role;
  String? id;

  User.fromMap(Map map) {
    try {
      token = map["token"];
      Map userData = map["userData"];
      name = userData["name"];
      email = userData["email"];
      role = userData["role"];
      id = userData["id"];
    } catch (e) {
      log("Did not create a user in User.fromMap. Error: $e", level: 0);
    }
  }

  // User.login(String email, String password) {
  //    login(email, password);
  // }

  static login(String email, String password) async {
    Map userMap = await Auth.login(email, password);
    User user = User.fromMap(userMap);
    // SharePreferencesHelper().setTokenToGlobal(user.token ?? "");
    SharedPreferencesHelper.instance.setTokenToGlobal(user.token ?? "");
    return user;
  }

  static getUser(String token) async {
    Map userMap = await Auth().user(token);
    log("User-> getUser userMap: ${userMap.toString()}");

    User user = User.fromMap(userMap);
    log("User-> getUser user: ${user.email}");

    return user;
  }

  static logOut() async {
    await SharedPreferencesHelper.instance.deleteTokenFromGlobal();
  }

  chagePassword(String oldPassword, String newPssword) async {
    Auth().changePassword(
      token!,
      oldPassword,
      newPssword,
      id,
    );
  }
}
