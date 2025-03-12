import 'dart:developer';

import 'package:gmn/data/helpers/dio_helper.dart';

class Auth {
  static String mName = "auth";

  static Future<Map> login(String email, String password) async {
    //ignore:avoid_log
    log("inside log in in auth.dart");
    Map responce = await DioHelper.io
        .post('', {"email": email, "password": password}, "$mName/login", '');
    return responce['data'] ?? {};
  }

  Future<Map> user(String token) async {
    Map responce = await DioHelper.io.get(token, "$mName/user", '', {});
    return responce['data'] ?? {};
  }

  Future<bool> changePassword(
      String token, String oldPassword, String newPassword, id) async {
    Map response = await DioHelper.io.put(
      token,
      {"oldPassword": oldPassword, "newPassword": newPassword},
      "$mName/changePassword/$id",
      "",
    );
    log("auth->changePassword response is: $response");
    return response["success"];
  }

  void forgotPassword(String email) {}
  void verifyResetCode(String email, String otp) {}
  void resetPassword(String email, String newPassword) {}
  void checkAuth(String token) {}
}
