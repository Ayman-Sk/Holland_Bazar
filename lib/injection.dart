import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:holland_bazar/app_controller.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import 'app_pref.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  Get.put(AppController());
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  Dio dio = await instance<DioFactory>().getDio();
}
