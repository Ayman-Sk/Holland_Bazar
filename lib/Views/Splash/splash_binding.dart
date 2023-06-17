import 'package:get/get.dart';
import 'package:holland_bazar/Views/Splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
