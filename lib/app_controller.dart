import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'App/constants.dart';
import 'Core/Enums/enums.dart';

class AppController extends GetxController {
  late Rx<Locale> lang;

  @override
  void onInit() {
    super.onInit();
    detectLanguageLocale();
  }

  detectLanguageLocale() async {
    String langCode = await getAppLanguage();
    log('Language Code : $langCode');
    if (langCode == AppLanguage.en.name) {
      lang = englishLocale.obs;
    } else {
      lang = arabicLocale.obs;
    }
  }

  Future<String> getAppLanguage() async {
    String? language = ''; //sharedPreferences.getString(SharedPreferencesKeys.APP_LANGUAGE) ?? AppLanguage.ar.name;
    if (language.isNotEmpty) {
      return language;
    } else {
      return AppLanguage.ar.name;
    }
  }

  Future<void> setAppLanguage(String languageType) async {
    // sharedPreferences.setString(SharedPreferencesKeys.APP_LANGUAGE, languageType);
  }
}
