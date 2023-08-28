import 'package:flutter/material.dart';

void showLoadingDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 300),
    pageBuilder: (BuildContext context, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    },
  );
}
