// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_ukm/app/component/awesome_dialog.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Ubah password',
          style: Styles.headerStyles(weight: FontWeight.w500, size: 16),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Password Lama',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Obx(() => TextFormField(
                    obscureText: !controller.isOldPasswordVisible.value,
                    controller: controller.oldPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      focusColor: Colors.white,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.toggleOldPasswordVisibility();
                        },
                        icon: Icon(
                          controller.isOldPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  )),
              SizedBox(height: 16),
              Text(
                'Password Baru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Obx(() => TextFormField(
                    obscureText: !controller.isPasswordVisible.value,
                    controller: controller.newPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      focusColor: Colors.white,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.togglePasswordVisibility();
                        },
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  )),
              SizedBox(height: 32),
              GestureDetector(
                onTap: (() {
                  if (controller.oldPasswordController.text == '' &&
                      controller.newPasswordController.text == '') {
                    Fluttertoast.showToast(
                      msg: 'Harap isi semua field nya',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey[800],
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                  } else {
                    WarningDialog.show(
                      context: context,
                      title: 'Yakin mengubah password ?',
                      btnCancelOnPress: () {
                        Get.back();
                      },
                      btnOkOnPress: () {
                        controller.updatePassword();
                      },
                    );
                  }
                }),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 95,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xff034779),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text('Ubah Password',
                          style: Styles.bodyStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
