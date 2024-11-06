import 'package:flutter/material.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String languageCode = 'en';

  bool get isDark => themeMode == ThemeMode.dark;
  // String get backgroundImage => isDark ? 'dark_bg' : 'default_bg';
  // String get sebhaHeadImage => isDark ? 'head_sebha_dark' : 'head_sebha_logo';
  // String get sebhaBodyImage => isDark ? 'body_sebha_dark' : 'body_sebha_logo';

  void changeTheme(ThemeMode selectedTheme) {
    themeMode = selectedTheme;
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage) {
    if (selectedLanguage == languageCode) return;
    languageCode = selectedLanguage;
    notifyListeners();
  }
}
