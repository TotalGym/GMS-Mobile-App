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
      //
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

  User(String token) {
    _user(token);
  }

  _user(String token) async {
    Map userMap = await Auth().user(token);
    User.fromMap(userMap);
  }

  Future getUser() async {}
}
