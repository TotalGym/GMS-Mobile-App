import 'package:gmn/data/network/dio_helper.dart';

class Auth {
  static String mName = "auth/";

  static Future<Map> login(String email, String password) async {
    //ignore:avoid_print
    print("inside log in in auth.dart");
    Map responce = await DioHelper.io
        .post('', {"email": email, "password": password}, "${mName}login");
    return responce['data'] ?? {};
  }

  Future<Map> user(String token) async {
    Map responce = await DioHelper.io.get(token, "$mName/user", '');
    return responce;
  }

  void changePassword(String token, String oldPassword, String newPassword) {}
  void forgotPassword(String email) {}
  void verifyResetCode(String email, String otp) {}
  void resetPassword(String email, String newPassword) {}
  void checkAuth(String token) {}
}
