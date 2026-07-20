import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_strings.dart';

class StorageService {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<bool> isLoggedIn() async {
    final prefs = await _prefs;
    return prefs.getBool(AppStrings.prefIsLoggedIn) ?? false;
  }

  Future<void> setLoggedIn(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(AppStrings.prefIsLoggedIn, value);
  }

  Future<String?> getMobileNumber() async {
    final prefs = await _prefs;
    return prefs.getString(AppStrings.prefMobileNumber);
  }

  Future<void> setMobileNumber(String mobile) async {
    final prefs = await _prefs;
    await prefs.setString(AppStrings.prefMobileNumber, mobile);
  }

  Future<void> clearSession() async {
    final prefs = await _prefs;
    await prefs.remove(AppStrings.prefIsLoggedIn);
    await prefs.remove(AppStrings.prefMobileNumber);
  }
}
