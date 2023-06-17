import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holland_bazar/Resources/string_manger.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController();
  final RxInt _index = 0.obs;

  get index => _index.value;
  set index(value) => _index.value = value;

  final List<String> titles = [AppStrings.findFoodyouLove, AppStrings.fastDelivery, AppStrings.liveTracking];
  final List<String> subTitles = ['', '', ''];

  onChangePage() {
    index += 1;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }
}
