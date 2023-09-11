import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mall_ukm/app/component/awesome_dialog.dart';
import 'package:mall_ukm/app/service/api_service.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isOldPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> updatePassword() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.changePw,
    );
    Map<String, dynamic> body() {
      return {
        "old_password": oldPasswordController.text,
        "new_password": newPasswordController.text
      };
    }

    Map<String, dynamic> requestBody = body();
    String encodedBody = jsonEncode(requestBody);
    print(encodedBody);
    http.Response response =
        await http.post(url, body: encodedBody, headers: headers);
    print(' ||| ${response.body} ||| STATUS ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['code'] == 200) {
        Get.back();
        Fluttertoast.showToast(
          msg: 'Berhasil Mengubah password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
        print('Berhasil');
      } else if (jsonResponse['code'] == 400) {
        ErrorDialog.show(
          context: Get.context!,
          title: 'Gagal Mengubah Password',
          desc: 'Password lama tidak sesuai',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Gagal mengubah password',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
        print(
            'Gagal Mengubah password  ${response.body} ||| ${jsonResponse['code']} || ${jsonResponse}');
      }
    }
  }

  void toggleOldPasswordVisibility() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
