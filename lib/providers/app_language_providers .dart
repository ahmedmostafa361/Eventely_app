import 'package:flutter/material.dart';

class AppLanguageProviders extends ChangeNotifier {
  String appLanguage = 'en';

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  bool isEnglish() {
    return appLanguage == 'en';
  }

  bool isArabic() {
    return appLanguage == 'ar';
  }
}
