import 'dart:developer';

import 'package:gmn/data/models/user/auth.dart';

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

  chagePassword(String oldPassword, String newPssword) async {
    Auth().changePassword(
      token!,
      oldPassword,
      newPssword,
      id,
    );
  }
}
