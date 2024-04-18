import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late SharedPreferences _preferences;

// Initializations of SharedPreferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveData(String key, dynamic value) async {
    if (value is int) {
      await _preferences.setInt(key.toString(), value);
    } else if (value is String) {
      await _preferences.setString(key.toString(), value);
    } else if (value is double) {
      await _preferences.setDouble(key.toString(), value);
    } else if (value is bool) {
      await _preferences.setBool(key.toString(), value);
    }
  }

  // Get Store details from SharedPreferences
  static dynamic getData(String key) {
    var value = _preferences.get(key);
    if (value is int) {
      return value;
    } else if (value is String) {
      return value;
    } else if (value is double) {
      return value;
    } else if (value is bool) {
      return value;
    }
    return null;
  }

  static Future<void> clearData() async {
    await _preferences.clear();
    init();
  }
}
