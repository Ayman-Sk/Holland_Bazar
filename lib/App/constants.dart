import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holland_bazar/app_controller.dart';

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

class Endpoints {
  static const String BASE_URL = '';
  static const String STORAGE_URL = '';
}

class Constants {
  // static const String baseUrl = "http://192.168.1.15:8000";
  // static const String imageUrl = "http://192.168.1.15:8000/storage/";
  static const String empty = "";
  static const int zero = 0;
  static const double zeroDouble = 0.0;
  static const int apiTimeOut = 20 * 1000;
  static const String bearer = 'Bearer ';
}

///
/// The [ErrorCode] enum is responsible of stating all the possible issues that can be retrieved from the API
///
/// Values:
///
/// * [ErrorCode.SERVER_ERROR] indicates that the server returned an undefined error
/// * [ErrorCode.WRONG_INPUT] returned when the server returns error 422 UnProcessable Entity
/// * [ErrorCode.NO_INTERNET_CONNECTION] returned when the device is not connected to a network
/// * [ErrorCode.FORBIDDEN] returned when the server returns 403 Forbidden
/// * [ErrorCode.TIMEOUT] returned when the request has timed out
/// * [ErrorCode.UNAUTHENTICATED] returned when the request returns that the user is unauthenticated
///

enum ErrorCode {
  SERVER_ERROR,
  UNAUTHENTICATED,
  TIMEOUT,
  NO_INTERNET_CONNECTION,
  WRONG_INPUT,
  PARSE_ERROR,
  FORBIDDEN,
  NOT_VERIFIED,
  REGISTERED_EMAIL,
  IDENTIFIER_TAKEN,
  CACH_ERROR,
  BAD_REQUEST
}

///
/// [GetOptions] class is for gathering all the options for the [Dio] package in one class
///
class GetOptions {
  static Options options = Options();

  static Options getOptionsWithToken(String token, {String? language}) {
    if (token.isNotEmpty) {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept-Language': language ?? Get.find<AppController>().lang.value.languageCode,
      };
      log('Bearer $token');
      options.validateStatus = (status) => status! < 500;
    } else {
      options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Accept-Language': language ?? Get.find<AppController>().lang.value.languageCode,
      };
      options.validateStatus = (status) => status! < 500;
    }
    return options;
  }
}
