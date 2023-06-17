import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holland_bazar/App/injection.dart';
import 'package:holland_bazar/Config/theme.dart';
import 'package:holland_bazar/Routes/app_pages.dart';
import 'package:holland_bazar/Routes/routes.dart';
import 'package:holland_bazar/Resources/localization_service.dart';

import 'app_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  runApp(Obx(
    () => GetMaterialApp(
      title: 'Holland Bazar',
      debugShowCheckedModeBanner: false,
      getPages: pages,
      initialRoute: AppRoutes.splash,
      theme: ligthTheme,
      locale: Get.find<AppController>().lang.value,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    ),
  ));
}
