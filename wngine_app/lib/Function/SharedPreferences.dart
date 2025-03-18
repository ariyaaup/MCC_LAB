import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static const String _usernameKey = 'username';
  static const String _emailnameKey = 'displayName';

  // Menyimpan username ke SharedPreferences
  static Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  // static Future<void> saveDisplayName(String displayName) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_emailnameKey, displayName);
  // }

  // Mengambil username dari SharedPreferences
  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey) ?? 'Unknown User';
  }

  // static Future<String> getDisplayName() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_emailnameKey) ?? 'Unknown User';
  // }

  // Menghapus username dari SharedPreferences
  static Future<void> clearUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_usernameKey);
  }
}
