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

  Future<String?> getTokenFromGlobal() async {
    await getSharePreferencesInstance();
    return _sp!.getString("token");
  }

  addNewString(String key, String value) async {
    await getSharePreferencesInstance();
    _sp!.setString(key, value);
  }

  addNewStringList(String key, List<String> value) async {
    await getSharePreferencesInstance();
    _sp!.setStringList(key, value);
  }

  getStringList(String key) async {
    await getSharePreferencesInstance();
    return _sp!.getStringList(key);
  }

  addViewedNotificationID(String id) async {
    await getSharePreferencesInstance();
    _sp!.getStringList('notifications_ids') == null
        ? addNewStringList('notifications_ids', [])
        : _addNewNotificationID(id);
  }

  _addNewNotificationID(String id) async {
    await getSharePreferencesInstance();
    List<String> ids = _sp!.getStringList('notifications_ids') ?? [];
    ids.contains(id) ? {} : ids.add(id);
    _sp!.setStringList('notifications_ids', ids);
  }

  //temporarily
  deleteNotifications() async {
    await getSharePreferencesInstance();
    _sp!.setStringList('notifications_ids', []);
  }
}
