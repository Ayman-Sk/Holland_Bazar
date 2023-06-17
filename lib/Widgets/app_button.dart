import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holland_bazar/App/app_text_style.dart';
import 'package:holland_bazar/App/extensions.dart';

class AppButton extends StatelessWidget {
  final Function? onPressed;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final Color? backGroundColor;
  final Color? borderColor;
  final TextStyle? titlStyle;
  final double? borderRadius;
  final Color? overlayColor;
  const AppButton(
      {super.key, this.onPressed, this.title, this.padding, this.backGroundColor, this.borderColor, this.titlStyle, this.borderRadius, this.overlayColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      height: 6.h(),
      width: 100.w(),
      child: ElevatedButton(
        onPressed: () => onPressed!(),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 15.0))),
          backgroundColor: MaterialStateProperty.all<Color>(backGroundColor ?? Get.theme.primaryColor),
          side: MaterialStatePropertyAll<BorderSide>(BorderSide(color: borderColor ?? backGroundColor ?? Get.theme.primaryColor)),
          overlayColor: MaterialStateProperty.all<Color?>(overlayColor),
        ),
        child: Text(
          title!,
          style: titlStyle ?? AppTextStyle.xMediumBlackeBold700,
        ),
      ),
    );
  }
}
