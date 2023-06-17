import 'package:get/get.dart';
import 'package:holland_bazar/Routes/routes.dart';
import 'package:holland_bazar/Views/OnBoarding/onboarding_binding.dart';
import 'package:holland_bazar/Views/OnBoarding/onboarding_screen.dart';
import 'package:holland_bazar/Views/Splash/splash_binding.dart';
import 'package:holland_bazar/Views/Splash/splash_screen.dart';

final pages = <GetPage>[
  GetPage(name: AppRoutes.splash, page: () => const SplashScreen(), binding: SplashBinding()),
  GetPage(name: AppRoutes.onBoarding, page: () => const OnBoardingScreen(), binding: OnBoardingBinding()),
];
