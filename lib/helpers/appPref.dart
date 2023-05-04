// ignore_for_file: file_names
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String islogin = 'is_login';
  static const String mobileNumber = 'mobile_number';
  static const String userId = 'user_id';

  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  // Getter
  static bool? getBool(String key) => instance.getBool(key);

// Setter
  static Future<bool> setBool(String key, bool value) =>
      instance.setBool(key, value);

  // Getter
  static String? getString(String key) => instance.getString(key);

// Setter
  static Future<bool> setString(String key, String value) =>
      instance.setString(key, value);

  static clear() {
    instance.clear();
  }
}
