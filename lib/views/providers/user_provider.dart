import 'package:flutter/foundation.dart';
import 'package:gmn/data/models/user/user.dart';
import 'package:gmn/data/repositories/shared_preferences_helper.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  String? token;
  bool isLoggedIn = false;

  checkIfLoggedIn() async {
    String? token = await SharedPreferencesHelper.instance.getTokenFromGlobal();
    isLoggedIn = token != null;

    if (isLoggedIn && user == null) {
      User(token!);
    }
    notifyListeners();
  }

  logUserIn(String email, String password) async {
    user = await User.login(email, password);
    token = await SharedPreferencesHelper.instance.getTokenFromGlobal();

    notifyListeners();
  }
}
