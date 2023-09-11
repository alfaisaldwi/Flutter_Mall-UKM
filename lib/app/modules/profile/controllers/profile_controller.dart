import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/component/awesome_dialog.dart';
import 'package:mall_ukm/app/modules/navbar_page/controllers/navbar_page_controller.dart';
import 'package:mall_ukm/app/modules/navbar_page/views/navbar_page_view.dart';
import 'package:mall_ukm/app/routes/app_pages.dart';
import 'package:mall_ukm/app/service/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/component/show_general_dialog.dart';
import 'package:mall_ukm/app/component/toast_dialog.dart';

class ProfileController extends GetxController {
  TextEditingController cemail = TextEditingController();
  TextEditingController cpw = TextEditingController();
  TextEditingController cnamalengkap = TextEditingController();
  TextEditingController cusername = TextEditingController();
  TextEditingController cnohp = TextEditingController();

  var cNav = NavbarPageController();
  var isPasswordVisible = false.obs;
  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = "".obs;
  var accountData = RxMap<String, dynamic>({});

  @override
  void onInit() {
    super.onInit();
    String? token = GetStorage().read('token');
    print(token);
    // GetStorage().remove('token');
  }

  @override
  void onReady() {
    getUsers();
    super.onReady();
  }

  @override
  void onClose() {}
  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {'email': cemail.text.trim(), 'password': cpw.text};
      showLoadingDialog(Get.context!);
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['code'] == "200") {
          var token = json['data'];
          GetStorage().write('token', token);
          // cNav.tabController.index = 2;
          ToastUtil.showToast(msg: 'Login Berhasil');

          await Get.offAllNamed('navbar-page');
          cemail.clear();
          cpw.clear();
        } else {
          ErrorDialog.show(
            context: Get.context!,
            title: 'Gagal Mengubah Password',
            desc: 'Password lama tidak sesuai',
            btnCancelOnPress: () {},
            btnOkOnPress: () {},
          );
        }
      } else {
        Navigator.of(Get.context!, rootNavigator: true).pop();
        ErrorDialog.show(
            context: Get.context!,
            title: 'Gagal',
            desc: 'Periksa kembali email dan password',
            btnOkOnPress: (() {
              Get.back();
            }));
      }
    } catch (error) {
      error;
    }
  }

  Future<void> signUp() async {
    var headers = {'Content-Type': 'application/json'};

    var url =
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.register);
    Map body = {
      'name': cnamalengkap.text,
      'email': cemail.text.trim(),
      'password': cpw.text
    };
    showLoadingDialog(Get.context!);
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (json['code'] == 200) {
        cNav.tabController.index = 2;
        Timer(const Duration(seconds: 1), () => Get.toNamed('navbar-page'));
        cemail.clear();
        cpw.clear();
        ToastUtil.showToast(msg: 'Register Berhasil');
      } else if (json['code'] == 400) {
        ToastUtil.showToast(
            msg:
                '\n ${json['message']['password']?[0] ?? ' '} \n${json['message']['email']?[0] ?? ' '} \n');
      } else {
        ToastUtil.showToast(
            msg:
                '${json['message']['password']?[0] ?? ' '} \n${json['message']['email']?[0] ?? ' '}');
      }
    } else {
      ToastUtil.showToast(msg: 'Periksa kembali nama, email dan password ');
    }
    Navigator.of(Get.context!, rootNavigator: true).pop();
  }

  Future<void> me() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.me);
      http.Response response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['code'] == '200') {
          print(responseData['message']);
          GetStorage().remove('token');

          // Lakukan tindakan yang diperlukan setelah logout berhasil
        } else {
          throw 'Gagal : ${responseData['message']}';
        }
      } else {
        throw 'Gagal : ${response.reasonPhrase}|| ${response.statusCode}';
      }
    } catch (error) {
      GetStorage().remove('token');

      print('print tokennn ---- $token');

      throw 'Terjadi kesalahan saat logout: $error ||||| $token';
    }
  }

  Future<void> logout() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    GetStorage().remove('token');
    showLoadingDialog(Get.context!);
    try {
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.logout);
      http.Response response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['code'] == '200') {
          print(responseData['message']);
          GetStorage().remove('token');
          ToastUtil.showToast(msg: 'Logout Berhasil');

          Timer(
              const Duration(seconds: 1), () => Get.offAll((NavbarPageView())));
        } else {
          throw 'Gagal logout: ${responseData['message']}';
        }
      } else {
        throw 'Gagal logout: ${response.reasonPhrase}|| ${response.statusCode}';
      }
      Navigator.of(Get.context!, rootNavigator: true).pop();
    } catch (error) {
      GetStorage().remove('token');

      print('print tokennn ---- $token');

      throw 'Terjadi kesalahan saat logout: $error ||||| $token';
    }
  }

  void getUsers() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.me);
    http.Response response = await http.post(url, headers: headers);
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      accountData.value = RxMap<String, dynamic>(jsonData['data']);
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
}
