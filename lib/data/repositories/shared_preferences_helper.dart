import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper._();
  static final SharedPreferencesHelper instance = SharedPreferencesHelper._();
  SharedPreferences? _sp;

  getSharePreferencesInstance() async {
    _sp ??= await SharedPreferences.getInstance();
  }

  Future<void> setTokenToGlobal(String token) async {
    await getSharePreferencesInstance();
    _sp!.setString("token", token);
  }

  deleteTokenFromGlobal() async {
    await getSharePreferencesInstance();
    _sp!.remove("token");
  }

  Future<String?>? getTokenFromGlobal() async {
    await getSharePreferencesInstance();
    return _sp!.getString("token");
  }
}
