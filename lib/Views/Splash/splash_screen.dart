import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holland_bazar/Resources/assets_manger.dart';
import 'package:holland_bazar/Views/Splash/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(width: Get.width, height: Get.height, child: Image.asset(ImageAssets.splash, fit: BoxFit.cover)),
    );
  }
}
