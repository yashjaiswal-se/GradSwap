import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String _onboardingSeenKey = 'onboarding_seen';

  // Check if onboarding has been seen
  static Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_onboardingSeenKey) ?? false);
  }

  // Set onboarding as completed
  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingSeenKey, true);
  }
}
