import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:holland_bazar/Lang/ar.dart';
import 'package:holland_bazar/Lang/en.dart';
import 'package:holland_bazar/app_controller.dart';

class LocalizationService extends Translations {
  static const fallbackLocale = Locale('ar', 'AR');

  static final langs = [
    'en',
    'ar',
  ];

  static final locales = [const Locale('en', 'US'), const Locale('ar', 'KW')];

  @override
  Map<String, Map<String, String>> get keys => {'en_US': en, 'ar_AR': ar};

  static void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.find<AppController>().lang.value = locale;
    Get.find<AppController>().setAppLanguage(lang);
    Get.updateLocale(locale);
    log('updated to $lang');
    //StorageController().lang = lang;
  }

  static Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale ?? const Locale('ar', 'KW');
  }
}
