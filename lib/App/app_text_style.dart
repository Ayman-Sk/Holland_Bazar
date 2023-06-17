// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextStyle {
  static const double mini_font_size = 10.0;

  static const double small_font_size = 11.0;
  static const double xSmall_font_size = 12.0;

  static const double regular_font_size = 13.0;
  static const double xRegular_font_size = 14.0;

  static const double medium_font_size = 16.0;
  static const double xMedium_font_size = 18.0;

  static const double large_font_size = 20.0;
  static const double mLarge_font_size = 22.0;
  static const double xLarge_font_size = 24.0;
  static const double xxLarge_font_size = 30.0;

  static get largeGreyBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: large_font_size);
  static get largeGreyBold700 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: large_font_size);

  static get mediumGreyBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: medium_font_size);

  static get mediumGrey => const TextStyle(color: Colors.white, fontSize: medium_font_size);

  static get xMediumGreyBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: xMedium_font_size);

  static TextStyle get regularBlack => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: regular_font_size);

  static get xSmallDarkGreyBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: xSmall_font_size);

  static get xSmallSecondaryBoldWithUnderLine => TextStyle(
        color: Get.theme.secondaryHeaderColor,
        fontWeight: FontWeight.w500,
        fontSize: xSmall_font_size,
        decoration: TextDecoration.underline,
      );

  static get xSmallWhiteBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: xSmall_font_size);

  static get regularGreyBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: regular_font_size);

  static get regularGrey => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: regular_font_size);

  static get xRegularGreyBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: xRegular_font_size);

  static get xLargeBlackBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: xLarge_font_size);

  static get xlargeWhiteBold700 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: xLarge_font_size);

  static get xMediumBlackeBold700 => const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: xMedium_font_size);
  static get xxMediumWhite400 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 17);
  static xMediumColored600({Color? color}) => TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w600, fontSize: xMedium_font_size);
  static xMediumColored700({Color? color}) => TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w700, fontSize: xMedium_font_size);
  static mediumColored700({Color? color}) => TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w700, fontSize: medium_font_size);
  static mediumColored500({Color? color}) => TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w500, fontSize: medium_font_size);
  static xSmallColored700({Color? color}) => TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w700, fontSize: xSmall_font_size);
  static xRegularWhiteBold700({Color? color}) => TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w700, fontSize: xRegular_font_size);
  static xRegularColored400({Color? color}) => TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w400, fontSize: xRegular_font_size);

  static get xRegularWhiteBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: xRegular_font_size);
  static get xxLargeWhiteBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 28);
  static get mediumGrey700 => const TextStyle(color: Color(0xFF87888A), fontWeight: FontWeight.w700, fontSize: medium_font_size);
  static get xRegularGrey400 => const TextStyle(color: Color(0xFF87888A), fontWeight: FontWeight.w400, fontSize: xRegular_font_size);
  static get xMediumGrey400 => const TextStyle(color: Color(0xFF87888A), fontWeight: FontWeight.w400, fontSize: xMedium_font_size);
  static get xRegularWhite700 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: xRegular_font_size);
  static get xRegularWhite400 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: xRegular_font_size);
  static get mLargeWhite400 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: mLarge_font_size);
  static get mLargeWhite700 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: mLarge_font_size);
  static mLargeColored700({Color? color}) => TextStyle(
      color: color ?? Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: mLarge_font_size,
      decoration: TextDecoration.underline,
      decorationColor: color ?? Colors.white,
      decorationThickness: 1);
  static get mediumWhiteBold700 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: medium_font_size);
  static get xMediumWhiteBold700 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: xMedium_font_size);
  static get xMediumWhite400 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: xMedium_font_size);
  static get xMediumWhite500 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: xMedium_font_size);
  static get mediumWhite400 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: medium_font_size);
  static get mediumWhite500 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: medium_font_size);
  static get xSmallWhite400 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: xSmall_font_size);
  static get smallWhite400 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: small_font_size);
  static get miniWhite400 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: mini_font_size);
  static get xSmallRed400 => const TextStyle(color: Colors.red, fontWeight: FontWeight.w400, fontSize: xSmall_font_size);
  static get xMediumWhiteBold800 => const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: xMedium_font_size);

  static get regularWhitekBold => const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: regular_font_size);

  static get mediumBlack => const TextStyle(color: Colors.black, fontSize: medium_font_size);
  static xMediumSecondaryBold700(context) => TextStyle(color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.w600, fontSize: xMedium_font_size);

  static largeSecondaryBold700(context) => TextStyle(color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.bold, fontSize: large_font_size);

  static xMediumPrimaryBold700(context, {Color? color}) =>
      TextStyle(color: color ?? Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: xMedium_font_size);

  static mediumPrimaryBold700(context, {Color? color}) =>
      TextStyle(color: color ?? Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: medium_font_size);

  static regularPrimaryBold700(context) => TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: regular_font_size);

  // static mediumGreyBold700(context) => TextStyle(color: AppColors.darkGrey, fontWeight: FontWeight.w600, fontSize: medium_font_size);

  static xxlargePrimaryBold700(context, {Color? color}) =>
      TextStyle(color: color ?? Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: xxLarge_font_size);

  static xlargePrimaryBold700(context, {Color? color}) =>
      TextStyle(color: color ?? Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: xLarge_font_size);

  static largePrimaryBold700(context, {Color? color}) =>
      TextStyle(color: color ?? Theme.of(context).primaryColor, fontWeight: FontWeight.w600, fontSize: large_font_size);

  static regularSecondaryBold500(context) => TextStyle(color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.w500, fontSize: regular_font_size);

  static smallSecondaryBold500(context) => TextStyle(color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.w500, fontSize: small_font_size);

  static mediumBlackWithBold(context) => const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: medium_font_size);

  static smallLightGrey(context) => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: small_font_size);

  static largeLightGrey(context) => const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 16, letterSpacing: 1.1);

  static regularSecondary(context) => TextStyle(color: Theme.of(context).secondaryHeaderColor, fontWeight: FontWeight.w500, fontSize: regular_font_size);

  static smallLightGreyWithLineThrough(context) =>
      const TextStyle(color: Colors.grey, fontWeight: FontWeight.w800, decoration: TextDecoration.lineThrough, fontSize: small_font_size);

  static smallTextStyle(context) => const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: small_font_size);
}
