import 'package:holland_bazar/App/constants.dart';

///
///
/// [Failure] interface
///
/// Each failure class must implement this interface
///
/// Sub-classes:
///   a- [ServerFailure]
///   b- [CacheFailure]
///
abstract class Failure {
  final ErrorCode? errorCode;
  final String? message;
  Failure({this.errorCode, this.message});
}

///
/// The [ServerFailure] class is responsible for presenting the errors caused by remote data sources error
/// which holds [errorCode] inside it
///
/// [ServerFailure] implements [Failure] interface
///
/// [ServerFailure] is returned from the repositories after catching the [ServerException] thrown by the remote data sources
///
class ServerFailure implements Failure {
  @override
  final ErrorCode errorCode;
  @override
  final String message;

  ServerFailure(this.errorCode, this.message);
}

///
/// The [CacheFailure] class is responsible for presenting the errors caused by local data sources error
///
/// [CacheFailure] implements [Failure] interface
///
/// [CacheFailure] is returned from the repositories after catching the [CacheException] thrown by the local data sources
///
class CacheFailure implements Failure {
  @override
  final ErrorCode? errorCode;
  @override
  final String? message;

  CacheFailure({this.errorCode, this.message});
}
