import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:holland_bazar/App/constants.dart';
import 'package:holland_bazar/Config/snack_bar.dart';
import 'package:holland_bazar/Core/Data/Model/base_local_data_source.dart';
import 'package:holland_bazar/Core/Data/Model/base_remote_datasource.dart';
import 'package:holland_bazar/Core/Errors/failures.dart';
import 'package:holland_bazar/Core/Network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef FutureEitherOr<T> = Future<Either<Failure, T>> Function();
typedef FutureEitherOrWithToken<T> = Future<Either<Failure, T>> Function(
  String token,
);

///
///
/// The [BaseRepository] interface declares the basic and shared interaction between the domain layer and the data layer.
///
/// All the getters and functions in this class returns a [Future] of [Either] a [T] OR [Failure]
///
/// Each repository interface must extend from this interface
///
///
abstract class BaseRepository {
  ///
  /// This function checks if the device is connected to the network
  /// uses [NetworkInfo] interface to check if it's connected or not
  ///
  ///
  /// Params:
  ///   [body] which is a function that has the same return type of the [checkNetwork] function,
  ///   it's triggered when the connection result was retrieved
  ///
  /// Returns:
  /// [Future] of [Either] a [Failure] OR [T]
  ///   return cases:
  ///     a- [ServerFailure] with [ErrorCode.NO_INTERNET_CONNECTION] if there was no Internet connection
  ///     b- Returns the value returned by the [body] function
  ///
  ///
  Future<Either<Failure, T>> checkNetwork<T>(FutureEitherOr<T> body);

  ///
  ///
  /// This function retrieves the user's token from the local data source
  ///
  ///
  /// Returns:
  /// [Future] of [Either] a [Failure] OR [String]
  ///   return cases:
  ///     a- [Failure] if the token was null or empty
  ///     b- [String] which is the token value if it was successfully retrieved
  ///
  ///
  // Future<Either<Failure, String>> getToken();

  ///
  ///
  /// This function retrieves the user's token from the local data source
  ///
  ///
  /// Returns:
  /// [Future] of [Either] a [Failure] OR [AppLanguage]
  ///   return cases:
  ///     a- [Failure] if the token was null or empty
  ///     b- [AppLanguage] which is the current language
  ///
  ///

  ///
  ///
  /// This function retrieves the user's refresh token from the local data source
  ///
  ///
  /// Returns:
  /// [Future] of [Either] a [Failure] OR [String]
  ///   return cases:
  ///     a- [Failure] if the token was null or empty
  ///     b- [String] which is the token value if it was successfully retrieved
  ///
  ///
  // Future<Either<Failure, String>> getRefreshToken();

  // Future<Either<Failure, String>> getFCMToken();

  // Future<Either<Failure, T>> requestWithToken<T>(FutureEitherOrWithToken<T> body);

  ///
  /// This function is used to refresh the current user session
  /// Returns:
  /// [Future] of [Either] a [Failure] OR [void]
  ///
  // Future<Either<Failure, void>> refreshSession();

  ///
  /// This function is used to delete user cached data and log him out of the app
  /// Returns:
  /// [Future] of [Either] a [Failure] OR [void]
  ///
  // Future<Either<Failure, bool>> logOutUser();

  // Future<Either<Failure, void>> getUser();
}

/// [BaseRepositoryImpl] is the implementation of the [BaseRepository] interface
/// each repository must extend this class and implement a sub-interface of [BaseRepository] interface.
class BaseRepositoryImpl implements BaseRepository {
  final BaseLocalDataSource? baseLocalDataSource;
  final NetworkInfo networkInfo;
  final BaseRemoteDataSource? baseRemoteDataSource;

  BaseRepositoryImpl({
    required this.baseLocalDataSource,
    required this.networkInfo,
    this.baseRemoteDataSource,
  });

  @override
  Future<Either<Failure, T>> checkNetwork<T>(FutureEitherOr<T> body) async {
    if (await networkInfo.isConnected) {
      return body();
    } else {
      // return Left(ServerFailure(ErrorCode.NO_INTERNET_CONNECTION, "noInternet".tr));
      AppSnackBar.showToast('No Internet Connection');
      throw const Left('No Internet Connection');
    }
  }

  Future<Either<Failure, String>> getToken() async {
    // final token = await baseLocalDataSource!.token;
    SharedPreferences instance = await SharedPreferences.getInstance();
    final token = instance.getString(SharedPreferencesKeys.TOKEN);
    log(token.toString());
    if (token != null && token.isNotEmpty) {
      return Right(token);
    } else {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, T>> requestWithToken<T>(
    FutureEitherOrWithToken<T> body,
  ) async {
    return await checkNetwork<T>(() async {
      // try {
      final token = await getToken();
      log('token is $token');
      return await token.fold(
        (failure) => body(''),
        (token) async {
          return body(token);
        },
      );
      // } catch (e) {
      //   log('e is cauuught $e');
      //   if (e is ServerException) {
      //     log('e is cauuught ${e.errorCode}');
      //     if (e.errorCode == ErrorCode.UNAUTHENTICATED) {
      //       log('token expired ');
      //       final result = await refreshSession();
      //       if (result.isLeft()) {
      //         log('is left');
      //         return Left(ServerFailure(ErrorCode.UNAUTHENTICATED, ""));
      //       } else {
      //         log('retrying');
      //         try {
      //           return await body(await baseLocalDataSource!.token ?? '');
      //         } catch (e) {
      //           log('exception from retry');
      //           return Left(ServerFailure(ErrorCode.UNAUTHENTICATED, ''));
      //         }
      //       }
      //     }
      //     return Left(ServerFailure(e.errorCode, e.message));
      //   } else {
      //     log(e.toString());
      //     return Left(ServerFailure(ErrorCode.TIMEOUT, "timeOut".tr));
      //   }
      // }
    });
  }

  // @override
  // Future<Either<Failure, String>> getRefreshToken() async {
  //   return Left(ServerFailure(ErrorCode.UNAUTHENTICATED, ''));
  // }

  Future<Either<Failure, void>> refreshSession() async {
    try {
      // final refreshToken = await baseLocalDataSource!.refreshToken;
      // final token = await baseLocalDataSource!.token;

      // final result =
      //     await baseRemoteDataSource!.performPostRequest<LoginResponseModel>(
      //    Endpoints.REFRESH_TOKEN_URL,
      //   {"refreshToken": refreshToken},
      //   token: token ?? '',
      // );
      // if (result.data?.refreshToken == null)
      //   await baseLocalDataSource.updateToken([result.data!.token]);
      // else
      //   await baseLocalDataSource.updateToken([
      //     result.data!.token,
      //     result.data!.refreshToken!,
      //   ]);
      return const Right(null);
    } catch (e) {
      log('catch');
      log('e is $e');
      // return Left(ServerFailure(ErrorCode.UNAUTHENTICATED, ''));
      rethrow;
    }
  }

  // @override
  // Future<Either<Failure, bool>> logOutUser() async {
  //   // baseRemoteDataSource.lo
  //   return Right(await baseLocalDataSource!.logOutUser());
  // }

  // @override
  // Future<Either<Failure, User>> getUser() async {
  //   final user = await baseLocalDataSource!.user;
  //   if (user?.isNotEmpty ?? false) {
  //     return Right(UserModel.fromJson(json.decode(user!)).toDomain());
  //   } else {
  //     return Left(CacheFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, String>> getFCMToken() async {
  //   final result = await baseLocalDataSource!.fcmToken;
  //   if (result == null) {
  //     return const Right('');
  //   }
  //   return Right(result);
  // }
}
