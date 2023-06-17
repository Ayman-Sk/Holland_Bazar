import 'package:dartz/dartz.dart';
import '../../app/app_pref.dart';
import '../../data/data_source/remote_data_source.dart';
import '../../data/network/error_handler.dart';
import '../../data/network/failure.dart';
import '../../data/network/network_info.dart';

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
  Future<Either<Failure, String>> getToken();

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
  Future<Either<Failure, String>> getRefreshToken();

  Future<Either<Failure, T>> requestWithToken<T>(FutureEitherOrWithToken<T> body);
}

/// [BaseRepositoryImpl] is the implementation of the [BaseRepository] interface
/// each repository must extend this class and implement a sub-interface of [BaseRepository] interface.
class BaseRepositoryImpl implements BaseRepository {
  final NetworkInfo networkInfo;
  final AppPreferences appPreferences;
  // final RemoteDataSource remoteDataSource;

  BaseRepositoryImpl({
    required this.appPreferences,
    required this.networkInfo,
    // required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, T>> checkNetwork<T>(FutureEitherOr<T> body) async {
    if (await networkInfo.isConnected) {
      return body();
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    final token = appPreferences.getUserToken();

    if (token != null && token.isNotEmpty) {
      return Right(token);
    } else {
      return Left(DataSource.cacheError.getFailure());
    }
  }

  @override
  Future<Either<Failure, T>> requestWithToken<T>(
    FutureEitherOrWithToken<T> body,
  ) async {
    return await checkNetwork<T>(() async {
      // try {
      final token = await getToken();
      return await token.fold(
        (failure) => body(''),
        (token) async {
          return body(token);
        },
      );
    });
  }

  @override
  Future<Either<Failure, String>> getRefreshToken() async {
    return Left(DataSource.unAuthorised.getFailure());
  }
}
