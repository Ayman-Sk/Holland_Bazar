import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void openErrorSnackBar({String title = '', String message = ''}) {
    Get.snackbar(
      backgroundColor: const Color(0xFFFADFB9).withOpacity(0.4),
      colorText: Get.theme.secondaryHeaderColor,
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void openSuccessSnackBar({String title = '', String message = ''}) {
    Get.snackbar(
      backgroundColor: const Color(0xFFB4EDC3).withOpacity(0.4),
      colorText: const Color(0xFF3CB7B8),
      title,
      message,
      snackPosition: SnackPosition.TOP,
    );
  }

  static void openSnackBar({String title = '', String message = ''}) {
    Get.snackbar(
      // backgroundColor: const Color(0xFFB4EDC3).withOpacity(0.4),
      colorText: Colors.white,
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Get.theme.primaryColor.withOpacity(0.8)
        // duration
        );
  }

  static void openLoadingDialog({Color? color}) {
    if (Get.isDialogOpen!) return;
    Get.dialog(
        barrierDismissible: false,
        Container(
            alignment: Alignment.center,
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              color: color ?? Get.theme.primaryColor,
            )));
  }

  static void openMessageDialog({required String message}) {
    if (Get.isDialogOpen!) Get.back();

    AlertDialog alertDialog = AlertDialog(backgroundColor: Get.theme.scaffoldBackgroundColor, content: Text(message));
    Get.dialog(alertDialog);
  }

  // static void openAlertDialog(
  //     {required String title, required Function onNextButton}) {
  //   if (Get.isDialogOpen!) return;
  //   // set up the buttons
  //   Widget cancelButton = TextButton(
  //     onPressed: () => Get.back(),
  //     child: Text("cancel".tr),
  //   );
  //   Widget continueButton = TextButton(
  //     onPressed: () => onNextButton(),
  //     child: Text("continue".tr),
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     backgroundColor:
  //         Get.find<AppController>().themeData.colorScheme.secondary,
  //     title: const Text(""),
  //     content: Text(title, style: AppTextStyle.regularBlack),
  //     actions: [
  //       cancelButton,
  //       continueButton,
  //     ],
  //   );
  //   Get.dialog(alert);
  // }
}
