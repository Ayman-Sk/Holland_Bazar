import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:holland_bazar/App/constants.dart';
import 'package:holland_bazar/Core/Data/Model/base_local_data_source.dart';
import 'package:holland_bazar/Core/Data/Model/base_remote_datasource.dart';
import 'package:holland_bazar/Core/Data/Repository/base_repository.dart';
import 'package:holland_bazar/Core/Network/network_info.dart';
import 'package:holland_bazar/app_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

///
/// The [init] function is responsible for adding the instances to the graph
///
Future<void> init() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final sharedPreferences = await SharedPreferences.getInstance();
  final rxPrefs = SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => rxPrefs);

  /// Adding the [Dio] instance to the graph to be later used by the local data sources
  sl.registerLazySingleton(
    () {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 20),
          baseUrl: Endpoints.BASE_URL,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          responseType: ResponseType.plain,
        ),
      );
      dio.interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          responseHeader: true,
          requestHeader: true,
          request: true,
        ),
      );
      return dio;
    },
  );

  /// Adding the [DataConnectionChecker] instance to the graph to be later used by the [NetworkInfoImpl]
  sl.registerLazySingleton(() => InternetConnectionChecker());

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  //! Core
  ///Creating [NetworkInfoImpl] class
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Local Data sources
  /// Instantiating the [BaseLocalDataSourceImpl]
  sl.registerLazySingleton<BaseLocalDataSource>(() => BaseLocalDataSourceImpl(sharedPreferences: sl()));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Remote Data sources
  /// Instantiating the [BaseRemoteDataSourceImpl]
  sl.registerLazySingleton<BaseRemoteDataSource>(() => BaseRemoteDataSourceImpl(dio: sl()));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Repository
  /// Instantiating the [BaseRepositoryImpl]
  sl.registerLazySingleton<BaseRepository>(() => BaseRepositoryImpl(networkInfo: sl(), baseLocalDataSource: sl(), baseRemoteDataSource: sl()));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Usecase
  /// Instantiating the [LoginUseCase]
  // sl.registerLazySingleton<>(() => (: sl()));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Get.put(AppController(), permanent: true);
}
