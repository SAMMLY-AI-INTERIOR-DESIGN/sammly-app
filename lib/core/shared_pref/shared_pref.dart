import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _pref;

  static init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required String value,
  }) async {
    return await _pref.setString(key, value);
  }

  static String? getData({required String key}) {
    return _pref.getString(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await _pref.remove(key);
  }
}
