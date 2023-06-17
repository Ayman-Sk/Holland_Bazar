import 'package:flutter/material.dart';

const englishLocale = Locale('en', 'US');
const arabicLocale = Locale('ar', 'KW');

///
///
/// [SharedPreferencesKeys] class, contains the keys for each value stored in the [SharedPreferences] package
///
// ignore_for_file: constant_identifier_names

class SharedPreferencesKeys {
  static const TOKEN = 'token';
  static const REFRESH_TOKEN = 'refresh_token';
  static const FCM_TOKEN = 'fcm_token';
  static const USER = 'user';
  static const APP_LANGUAGE = 'app_language';
  static const BASE_URL = 'base_url';
}

class Constants {
  static const String baseUrl = "";
  static const String imageUrl = "";
  // static const String baseUrl = "http://192.168.1.15:8000";
  // static const String imageUrl = "http://192.168.1.15:8000/storage/";
  static const String empty = "";
  static const int zero = 0;
  static const double zeroDouble = 0.0;
  static const int apiTimeOut = 20 * 1000;
  static const String bearer = 'Bearer ';
}
