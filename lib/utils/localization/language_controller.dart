import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  static LanguageController get to => Get.find();

  final Rx<Locale> currentLocale = const Locale('hi', 'IN').obs;
  final RxBool isHindi = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('language_code');
    String? countryCode = prefs.getString('country_code');

    if (langCode != null && countryCode != null) {
      currentLocale.value = Locale(langCode, countryCode);
      isHindi.value = (langCode == 'hi');
      Get.updateLocale(currentLocale.value);
    } else {
      // Default to Hindi as per user request design
      currentLocale.value = const Locale('hi', 'IN');
      isHindi.value = true;
      Get.updateLocale(currentLocale.value);
    }
  }

  Future<void> changeLanguage(String langCode, String countryCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
    await prefs.setString('country_code', countryCode);

    currentLocale.value = Locale(langCode, countryCode);
    isHindi.value = (langCode == 'hi');
    Get.updateLocale(currentLocale.value);
  }

  void toggleLanguage() {
    if (isHindi.value) {
      changeLanguage('en', 'US');
    } else {
      changeLanguage('hi', 'IN');
    }
  }
}
