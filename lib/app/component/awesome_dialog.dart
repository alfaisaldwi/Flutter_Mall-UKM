import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class SuccessDialog {
  static void show({
    required BuildContext context,
    required String title,
    String? desc,
    required Function() btnCancelOnPress,
    required Function() btnOkOnPress,
  }) {
    AwesomeDialog(
      btnOkText: 'Oke',
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnOkOnPress: btnOkOnPress,
    )..show();
  }
}


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
       btnOkText: 'Oke',
      btnCancelText: 'Batal',
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
    )..show();
  }
}

class ErrorDialog {
  static void show({
    required BuildContext context,
    required String title,
    String? desc,
     Function()? btnCancelOnPress,
     Function()? btnOkOnPress,
  }) {
    AwesomeDialog(
      btnOkText: 'Oke',
      btnCancelText: 'Batal',
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.bottomSlide,
      title: title,
      desc: desc,
      btnCancelOnPress: btnCancelOnPress,
      btnOkOnPress: btnOkOnPress,
    )..show();
  }
}
