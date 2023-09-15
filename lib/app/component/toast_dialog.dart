  
import 'package:fluttertoast/fluttertoast.dart';
  
  
import 'package:flutter/material.dart';

class ToastUtil {
  static void showToast({
    String? msg,
    ToastGravity? gravity,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
  }) {
    Fluttertoast.showToast(
      
      msg: msg!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.grey[800],
      textColor: textColor ?? Colors.white,
      fontSize: fontSize ?? 14.0,
    );
  }
}
