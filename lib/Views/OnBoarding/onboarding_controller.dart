import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController();
  final RxInt _index = 0.obs;

  get index => _index.value;
  set index(value) => _index.value = value;

  onChangePage() {
    index += 1;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }
}
