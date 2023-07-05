import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/model/users/users_model.dart';
import 'package:mall_ukm/app/modules/home/views/home_view.dart';
import 'package:mall_ukm/app/service/helper/users_helper.dart';
import 'package:mall_ukm/app/service/repository/users_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  TextEditingController cemail = TextEditingController();
  TextEditingController cpw = TextEditingController();
  TextEditingController cnamalengkap = TextEditingController();
  TextEditingController cusername = TextEditingController();
  TextEditingController cnohp = TextEditingController();

  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = "".obs;
  var acountData = <UserModel>[].obs;

  Dio dio = Dio();
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // getUser().then((data) {
    //   print('Data: $data');
    // });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  // Future<List<UserModel>> getUser() async {
  //   isLoading(true);
  //   try {
  //     final result = await ApiClient().getData(ApiConst.path);
  //     final List data = result["data"];
  //     isLoading(false);
  //     isError(false);
  //     acountData.value = data.map((e) => UserModel.fromMap(e)).toList();
  //     print(acountData);
  //     return acountData;
  //   } catch (e) {
  //     isLoading(false);
  //     isError(true);
  //     errmsg(e.toString());
  //     throw Exception(e);
  //   }
  // }

  showToast(fName, lName, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${fName}  ${lName}"),
    ));
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.loginEmail);
      Map body = {'email': cemail.text.trim(), 'password': cpw.text};
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 0) {
          var token = json['data']['Token'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('token', token);

          emailController.clear();
          passwordController.clear();
          Get.offAll(HomeView());
        } else if (json['code'] == 1) {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
