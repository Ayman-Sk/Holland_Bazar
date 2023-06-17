import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unProcessableEntity,
  unknown
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(code: ResponseCode.success, message: ResponseMessage.successApi.tr);
      case DataSource.noContent:
        return Failure(code: ResponseCode.noContent, message: ResponseMessage.noContent.tr);
      case DataSource.badRequest:
        return Failure(code: ResponseCode.badRequest, message: ResponseMessage.badRequest.tr);
      case DataSource.forbidden:
        return Failure(code: ResponseCode.forbidden, message: ResponseMessage.forbidden.tr);
      case DataSource.unAuthorised:
        return Failure(code: ResponseCode.unauthorized, message: ResponseMessage.unauthorized.tr);
      case DataSource.notFound:
        return Failure(code: ResponseCode.notFound, message: ResponseMessage.notFound.tr);
      case DataSource.internalServerError:
        return Failure(code: ResponseCode.internalServerError, message: ResponseMessage.internalServerError.tr);
      case DataSource.connectTimeOut:
        return Failure(code: ResponseCode.connectTimeOut, message: ResponseMessage.connectTimeOut.tr);
      case DataSource.cancel:
        return Failure(code: ResponseCode.cancel, message: ResponseMessage.cancelApi.tr);
      case DataSource.receiveTimeOut:
        return Failure(code: ResponseCode.receiveTimeout, message: ResponseMessage.receiveTimeout.tr);
      case DataSource.sendTimeOut:
        return Failure(code: ResponseCode.sendTimeOut, message: ResponseMessage.sendTimeOut.tr);
      case DataSource.cacheError:
        return Failure(code: ResponseCode.cacheError, message: ResponseMessage.cacheError.tr);
      case DataSource.noInternetConnection:
        return Failure(code: ResponseCode.noInternetConnecting, message: ResponseMessage.noInternetConnecting.tr);
      case DataSource.unknown:
        return Failure(code: ResponseCode.unknown, message: ResponseMessage.unknown.tr);
      case DataSource.unProcessableEntity:
        return Failure(code: ResponseCode.unprocessableEntity, message: ResponseMessage.unProcessableEntity.tr);
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeOut.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null && error.response!.statusCode != null && error.response!.statusMessage != null) {
        if (error.response!.statusCode == 422) {
          return Failure(code: error.response!.statusCode ?? 0, message: error.response!.data['message']);
        } else if (error.response!.statusCode! < 422 && error.response!.statusCode! >= 400) {
          return Failure(code: error.response!.statusCode!, message: error.response!.data['message']);
        } else {
          return Failure(code: error.response!.statusCode ?? 0, message: error.response!.statusMessage ?? "");
        }
      } else {
        return DataSource.unknown.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.badRequest.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.unknown:
      return DataSource.unknown.getFailure();
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int unprocessableEntity = 404;
  static const int internalServerError = 500;

  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnecting = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static const String successApi = 'successApi';
  static const String noContent = 'noContent';
  static const String badRequest = 'badRequest';
  static const String forbidden = 'forbidden';
  static const String unauthorized = 'unauthorized';
  static const String notFound = 'notFound';
  static const String unProcessableEntity = 'unProcessableEntity';
  static const String internalServerError = 'internalServerError';

  // local status code
  static const String connectTimeOut = 'connectTimeOut';
  static const String cancelApi = 'cancelApi';
  static const String receiveTimeout = 'receiveTimeout';
  static const String sendTimeOut = 'sendTimeOut';
  static const String cacheError = 'cacheError';
  static const String noInternetConnecting = 'noInternetConnecting';
  static const String unknown = 'unknown';
}

class ApiInternalStatus {
  static const int success = 1;
  static const int failure = 0;
}
