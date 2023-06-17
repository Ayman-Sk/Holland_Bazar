import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as d;
import 'package:holland_bazar/App/constants.dart';
import 'package:holland_bazar/Config/snack_bar.dart';
import 'package:holland_bazar/Core/Errors/error_handler.dart';
import 'package:holland_bazar/Core/Errors/exceptions.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

///
///
/// The [BaseRemoteDataSource] has the basic functions that each remote data source must have.
///
/// Each remote data source interface must extend from this interface
///

abstract class BaseRemoteDataSource {
  ///
  /// This function performs a PUT http request to the specified [endpoint]
  /// with named parameter [token] that defaults to an empty string if the request does not require authentication
  ///
  /// uses [ErrorHandler.handleRemoteError] for error handling
  ///
  /// Returns:
  /// [T] which is passed to the function in order to know how to parse the json data
  ///
  /// Throws:
  ///  [ServerException] in two cases
  ///   a- With [ErrorCode.TIMEOUT] if the request has timed out
  ///   b- If the [ErrorHandler.handleRemoteError] throws an error
  ///
  @protected
  Future<T> performPutRequest<T>(String endpoint, T Function(Map<String, dynamic>) fromJson, data, {String token = ''});

  @protected
  Future<T> performPatchRequest<T>(String endpoint, T Function(Map<String, dynamic>) fromJson, d.FormData? data, {String token = ''});

  @protected
  Future<T> performPatchRequestJSON<T>(String endpoint, T Function(Map<String, dynamic>) fromJson, Map<String, dynamic> data, {String token = ''});

  ///
  /// This function performs a POST http request to the specified [endpoint]
  /// with named parameter [token] that defaults to an empty string if the request does not require authentication
  ///
  /// uses [ErrorHandler.handleRemoteError] for error handling
  ///
  /// Returns:
  /// [T] which is passed to the function in order to know how to parse the json data
  ///
  /// Throws:
  ///  [ServerException] in two cases
  ///   a- With [ErrorCode.TIMEOUT] if the request has timed out
  ///   b- If the [ErrorHandler.handleRemoteError] throws an error
  ///
  Future<T> performPostRequest<T>(String endpoint, Map<String, dynamic> data, T Function(Map<String, dynamic>) fromJson, {String token = ''});

  Future<bool> performDeleteRequest(String endpoint, {String token = ''});

  Future<T> performPostRequestWithFormData<T>(String endpoint, d.FormData data, T Function(Map<String, dynamic>) fromJson, {String token = ''});

  Future<dynamic> performDownloadRequest(String url, String path);

  ///
  /// This function performs a GET http request to the specified [endpoint]
  /// with named parameter [token] that defaults to an empty string if the request does not require authentication
  ///
  /// uses [ErrorHandler.handleRemoteError] for error handling
  ///
  /// Returns:
  /// [List] of [T] which is passed to the function in order to know how to parse the json data
  ///
  /// Throws:
  ///  [ServerException] in two cases
  ///   a- With [ErrorCode.TIMEOUT] if the request has timed out
  ///   b- If the [ErrorHandler.handleRemoteError] throws an error
  ///
  @protected
  Future<List<T>> performGetListRequest<T>(String endpoint, T Function(Map<String, dynamic>) fromJson, {String token = ''});

  ///
  /// This function performs a GET http request to the specified [endpoint]
  /// with named parameter [token] that defaults to an empty string if the request does not require authentication
  ///
  /// uses [ErrorHandler.handleRemoteError] for error handling
  ///
  /// Returns:
  /// [T] which is passed to the function in order to know how to parse the json data
  ///
  /// Throws:
  ///  [ServerException] in two cases
  ///   a- With [ErrorCode.TIMEOUT] if the request has timed out
  ///   b- If the [ErrorHandler.handleRemoteError] throws an error
  ///
  @protected
  Future<T> performGetRequest<T>(String endpoint, T Function(Map<String, dynamic>) fromJson, {String token = ''});

  @protected
  Future<T> performPostUnknownRequest<T>(String endpoint, Map<String, dynamic>? data, {String token = ''});

  // @protected
  // Future<T> performGetPagenation<T>(String endPoint, T Function(Map<String, dynamic>) fromJson, {String? listName, Map<String, dynamic>? params});
}

///
/// The [BaseRemoteDataSourceImpl] has the implementation of the basic functions that each remote data source must have.
///
/// Each remote data source class must extend from this class and implement a sub-interface of [BaseRemoteDataSource] interface.
///
class BaseRemoteDataSourceImpl extends BaseRemoteDataSource {
  final Dio dio;

  BaseRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<T> performGetRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    String token = '',
    Map<String, dynamic>? params,
    bool hasDataBody = true,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: params,
        options: GetOptions.getOptionsWithToken(token, language: 'ar'),
      );
      log('response status code is ${response.statusCode}');

      if (response.statusCode == 401) {
        SharedPreferences prefrences = await SharedPreferences.getInstance();
        prefrences.remove(SharedPreferencesKeys.TOKEN);
        // if (!Get.isRegistered<LoginController>()) {
        //   Get.offAllNamed(AppRoutes.login);
        // }
      }

      if (response.statusCode != 200) {
        log('not 200');
        AppSnackBar.showToast(json.decode(response.data)['message']);
      }

      if (!hasDataBody) {
        log('logout response   trueee${fromJson({})}');

        return fromJson({});
      }

      if (ErrorHandler.handleRemoteError(response.statusCode!, response.statusMessage ?? '')) {
        final baseResponse = fromJson(json.decode(response.data)['data']);
        log("BBBB ${baseResponse.toString()}");
        if (baseResponse != null) {
          return baseResponse;
        } else {
          throw ServerException(ErrorCode.SERVER_ERROR, response.data["message"]);
        }
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, response.data["message"]);
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      if (e is DioException) {
        ErrorHandler.handleRemoteError(e.response!.statusCode ?? 404, e.message.toString());
        rethrow;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    }
  }

  @override
  Future<List<T>> performGetListRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    String? token = '',
    String? listName,
    Map<String, dynamic>? params,
    bool hasDataKey = true,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: params,
        options: GetOptions.getOptionsWithToken(token!),
      );
      log('this is resonse ${response.data}');

      if (response.statusCode == 401) {
        SharedPreferences prefrences = await SharedPreferences.getInstance();
        prefrences.remove(SharedPreferencesKeys.TOKEN);
        //TODO
        // if (!Get.isRegistered<LoginController>()) {
        //   Get.offAllNamed(AppRoutes.login);
        // }
      }

      if (response.statusCode != 200) {
        AppSnackBar.showToast(json.decode(response.data)['message']);
      }
      if (ErrorHandler.handleRemoteError(response.statusCode!, response.statusMessage ?? '')) {
        final List<T> list = [];

        final List data;

        if (listName != null) {
          data = json.decode(response.data)["data"][listName] as List;
        } else if (!hasDataKey) {
          data = json.decode(response.data) as List;
        } else {
          log('aaaaaa ${json.decode(response.data)}');
          data = json.decode(response.data)["data"] as List;
        }
        log('sssssssssssssssssssssssssssssssssssssssssssssssssssssss');

        for (var element in data) {
          log('element is null ${element == null}');
          if (element == null) continue;
          list.add(fromJson(element));
        }
        log('List Length ${list.length}');
        return list;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, response.data["message"]);
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      log('get list e is $e');
      if (e is ServerException) {
        log(e.message);
        rethrow;
      }
      if (e is DioException) {
        log('e is DioException');
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, e.message.toString());
        rethrow;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    }
  }

  Future<List<T>> performPostListRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson, {
    String token = '',
    String? listName,
    data,
    Map<String, dynamic>? params,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        queryParameters: params,
        data: data,
        options: GetOptions.getOptionsWithToken(token),
      );
      if (response.statusCode == 401) {
        SharedPreferences prefrences = await SharedPreferences.getInstance();
        prefrences.remove(SharedPreferencesKeys.TOKEN);
        //TODO
        // if (!Get.isRegistered<LoginController>()) {
        //   Get.offAllNamed(AppRoutes.login);
        // }
      }

      if (response.statusCode != 200) {
        AppSnackBar.showToast(json.decode(response.data)['message']);
      }
      if (ErrorHandler.handleRemoteError(response.statusCode!, response.statusMessage ?? '')) {
        final List<T> list = [];

        final List data;
        if (listName != null) {
          data = json.decode(response.data)["data"][listName] as List;
        } else {
          data = json.decode(response.data)["data"] as List;
        }
        for (var element in data) {
          log('element is null ${element == null}');
          if (element == null) continue;
          list.add(fromJson(element));
        }
        return list;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      log('get list e is $e');
      if (e is ServerException) {
        log(e.errorCode.name);
        rethrow;
      }
      if (e is DioException) {
        log('e is DioException');
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, "notFound");
        rethrow;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    }
  }

  @override
  Future<T> performPostRequest<T>(
    String endpoint,
    Map<String, dynamic>? data,
    T Function(Map<String, dynamic>) fromJson, {
    bool isEmptyRequest = false,
    bool hasDataBody = true,
    String token = '',
  }) async {
    log(data.toString());
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: GetOptions.getOptionsWithToken(token),
      );
      log('response is $response');

      if (response.statusCode == 401) {
        SharedPreferences prefrences = await SharedPreferences.getInstance();
        prefrences.remove(SharedPreferencesKeys.TOKEN);
        //TODO
        // if (!Get.isRegistered<LoginController>()) {
        //   Get.offAllNamed(AppRoutes.login);
        // }
      }

      if (response.statusCode != 200) {
        AppSnackBar.showToast(json.decode(response.data)['message']);
      }

      if (ErrorHandler.handleRemoteError(response.statusCode!, json.decode(response.data)['message'])) {
        log("BLAAAA ${json.decode(response.data)}");
        final T baseResponse;
        if (!hasDataBody) {
          log('response   trueee${fromJson({})}');
          return fromJson({});
        }
        if (isEmptyRequest) {
          baseResponse = fromJson(json.decode(response.data));
        } else {
          baseResponse = fromJson(json.decode(response.data)["data"]);
        }

        // return baseResponse;
        if (baseResponse != null) {
          log('base response $baseResponse');
          return baseResponse;
        } else {
          throw ServerException(ErrorCode.PARSE_ERROR, response.data['message']);
        }
      } else {
        log('aaaaaaaaaaaaaa');
        throw ServerException(ErrorCode.BAD_REQUEST, response.data['message']);
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      log('eee is $e');
      if (e is DioException) {
        log("DIO ERROR");
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, e.response!.statusMessage ?? '');
        rethrow;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, e.toString());
      }
    }
  }

  @override
  Future<T> performPostUnknownRequest<T>(
    String endpoint,
    Map<String, dynamic>? data, {
    String token = '',
  }) async {
    log(data.toString());
    try {
      final response = await dio.post(endpoint, data: data, options: GetOptions.getOptionsWithToken(token));
      log('response is $response');

      if (response.statusCode == 401) {
        SharedPreferences prefrences = await SharedPreferences.getInstance();
        prefrences.remove(SharedPreferencesKeys.TOKEN);
        //TODO
        // if (!Get.isRegistered<LoginController>()) {
        //   Get.offAllNamed(AppRoutes.login);
        // }
      }

      if (response.statusCode != 200) {
        AppSnackBar.showToast(json.decode(response.data)['message']);
      }

      if (ErrorHandler.handleRemoteError(response.statusCode!, json.decode(response.data)['message'])) {
        log("BLAAAA ${json.decode(response.data)}");
        final T baseResponse;
        baseResponse = json.decode(response.data)['data'];

        // return baseResponse;
        if (baseResponse != null) {
          log('base response $baseResponse');
          return baseResponse;
        } else {
          throw ServerException(ErrorCode.PARSE_ERROR, response.data['message']);
        }
      } else {
        log('aaaaaaaaaaaaaa');
        throw ServerException(ErrorCode.BAD_REQUEST, response.data['message']);
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      log('eee is $e');
      if (e is DioException) {
        log("DIO ERROR");
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, e.response!.statusMessage ?? '');
        rethrow;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, e.toString());
      }
    }
  }

  @override
  Future<T> performPutRequest<T>(String endpoint, T Function(Map<String, dynamic>) fromJson, data, {String token = ''}) async {
    try {
      final response = await dio.put(
        endpoint,
        data: data,
        options: GetOptions.getOptionsWithToken(token),
      );
      //  Utils.openSnackBar(message:'response.toString()');

      log('response is $response');
      if (ErrorHandler.handleRemoteError(response.statusCode!, response.data["message"])) {
        final baseResponse = fromJson(json.decode(response.data));
        if (baseResponse != null) {
          return baseResponse;
        } else {
          throw ServerException(ErrorCode.SERVER_ERROR, '');
        }
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      log('eee is $e');
      if (e is ServerException) rethrow;
      if (e is DioException) {
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, "notFound");
        rethrow;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    }
  }

  @override
  Future<T> performPatchRequest<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    d.FormData? data, {
    String token = '',
  }) async {
    log('data in form data is ${data!.fields}');
    try {
      final response = await dio.patch(
        endpoint,
        data: data,
        options: GetOptions.getOptionsWithToken(token),
      );
      log('response is $response');
      if (ErrorHandler.handleRemoteError(response.statusCode!, response.data["message"])) {
        if (T.toString() == 'String') {
          return 'Success' as T;
        }
        final baseResponse = fromJson(json.decode(response.data));
        if (baseResponse != null) {
          return baseResponse;
        } else {
          throw ServerException(ErrorCode.SERVER_ERROR, '');
        }
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      if (e is DioException) {
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, "notFound");
        rethrow;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    }
  }

  @override
  Future<T> performPatchRequestJSON<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? data, {
    String token = '',
  }) async {
    try {
      final response = await dio.patch(
        endpoint,
        data: data,
        options: GetOptions.getOptionsWithToken(token),
      );
      if (ErrorHandler.handleRemoteError(response.statusCode!, response.data["message"])) {
        final baseResponse = fromJson(json.decode(response.data));
        if (baseResponse != null) {
          return baseResponse;
        } else {
          throw ServerException(ErrorCode.SERVER_ERROR, '');
        }
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      if (e is DioException) {
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, "notFound");
        rethrow;
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    }
  }

  @override
  Future<T> performPostRequestWithFormData<T>(String endpoint, d.FormData data, T Function(Map<String, dynamic> p1) fromJson,
      {String token = ''}) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: GetOptions.getOptionsWithToken(token),
      );
      final jsonData = json.decode(response.data);
      log('ouuut${json.decode(response.data)}');
      if (ErrorHandler.handleRemoteError(response.statusCode!, jsonData["status"])) {
        log('innnnnn${json.decode(response.data)}');

        final baseResponse = fromJson(jsonData["data"]);
        if (baseResponse != null) {
          return baseResponse;
        } else {
          throw ServerException(ErrorCode.SERVER_ERROR, '');
        }
      } else {
        throw ServerException(ErrorCode.SERVER_ERROR, '');
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      if (e is DioException) {
        log(e.toString());
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, "notFound".tr);
        rethrow;
      } else {
        log("TTTTTTTTTTT");
        log(e.toString());
        throw ServerException(ErrorCode.PARSE_ERROR, e.toString());
      }
    }
  }

  @override
  Future<bool> performDeleteRequest(String endpoint, {String token = ''}) async {
    try {
      final response = await dio.delete(
        endpoint,
        options: GetOptions.getOptionsWithToken(token),
      );
      if (response.statusCode == 200) return true;
      return false;
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      if (e is DioException) {
        log(e.toString());
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, e.message.toString());
        rethrow;
      } else {
        log("TTTTTTTTTTT");
        log(e.toString());
        throw ServerException(ErrorCode.PARSE_ERROR, '');
      }
    }
  }

  @override
  Future<dynamic> performDownloadRequest(String url, String path) async {
    try {
      final response = await dio.download(url, path,
          options: Options(responseType: ResponseType.bytes, followRedirects: false, receiveTimeout: const Duration(minutes: 2)));
      if (response.statusCode == 200) return response.data;
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        AppSnackBar.showToast('checkTheQualityOfTheInternetConnection'.tr);

        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(ex.message);
    } catch (e) {
      if (e is ServerException) rethrow;
      if (e is DioException) {
        log(e.toString());
        ErrorHandler.handleRemoteError(e.response?.statusCode ?? 404, e.message.toString());
        rethrow;
      } else {
        log("TTTTTTTTTTT");
        log(e.toString());
        throw ServerException(ErrorCode.PARSE_ERROR, '');
      }
    }
  }
}
