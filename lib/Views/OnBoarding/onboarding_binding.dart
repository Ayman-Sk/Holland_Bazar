import 'package:get/get.dart';
import 'package:holland_bazar/Views/OnBoarding/onboarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => OnBoardingController());
}
