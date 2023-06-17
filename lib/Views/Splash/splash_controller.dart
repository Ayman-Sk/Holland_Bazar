import 'package:get/get.dart';
import 'package:holland_bazar/Routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () async {
      Get.offAndToNamed(AppRoutes.onBoarding);
    });
  }
}
