import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holland_bazar/App/app_text_style.dart';
import 'package:holland_bazar/App/extensions.dart';
import 'package:holland_bazar/Resources/assets_manger.dart';
import 'package:holland_bazar/Resources/string_manger.dart';
import 'package:holland_bazar/Views/OnBoarding/onboarding_controller.dart';
import 'package:holland_bazar/Widgets/app_button.dart';
import 'package:holland_bazar/Widgets/app_locale_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  OnBoardingScreen({super.key});

  final List<Widget> pages = const [
    AppLocaleImage(path: ImageAssets.onBoarding1, isSvg: true),
    AppLocaleImage(path: ImageAssets.onBoarding2, isSvg: true),
    AppLocaleImage(path: ImageAssets.onBoarding3, isSvg: true),
  ];

  final List<String> titles = [AppStrings.findFoodyouLove, AppStrings.fastDelivery, AppStrings.liveTracking];
  final List<String> subTitles = ['', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 9.w()),
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                  width: 60.w(),
                  height: 36.h(),
                  child: PageView(
                    allowImplicitScrolling: true,
                    controller: controller.pageController,
                    children: pages,
                  )),
            ),
            SizedBox(height: 5.h()),
            SmoothPageIndicator(
              controller: controller.pageController,
              textDirection: TextDirection.ltr,
              count: 3,
              effect: WormEffect(activeDotColor: Get.theme.primaryColor, radius: Get.width / 50, dotWidth: 2.1.w(), dotHeight: 2.1.w()),
            ),
            SizedBox(height: 5.h()),
            // Text(data),
            // Text(data),
            SizedBox(height: 5.h()),
            AppButton(
              onPressed: () => controller.onChangePage(),
              borderRadius: 12,
              title: AppStrings.next.tr,
              titlStyle: AppTextStyle.mediumGreyBold,
            )
          ],
        ),
      ),
    );
  }
}
