import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class WarningDialog {
  static void show({
    required BuildContext context,
    required String title,
    String? desc,
    required Function() btnCancelOnPress,
    required Function() btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
    )..show();
  }
}
