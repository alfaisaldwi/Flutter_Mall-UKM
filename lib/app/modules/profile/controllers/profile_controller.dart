import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/navbar_page/controllers/navbar_page_controller.dart';
import 'package:mall_ukm/app/routes/app_pages.dart';
import 'package:mall_ukm/app/service/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  TextEditingController cemail = TextEditingController();
  TextEditingController cpw = TextEditingController();
  TextEditingController cnamalengkap = TextEditingController();
  TextEditingController cusername = TextEditingController();
  TextEditingController cnohp = TextEditingController();
  var cNav = NavbarPageController();

  var isLoading = true.obs;
  var isError = false.obs;
  var errmsg = "".obs;
  var accountData = RxMap<String, dynamic>({});

  Dio dio = Dio();
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    String? token = GetStorage().read('token');
    // GetStorage().remove('token');

    print('print tokennn ---- $token');
    print('print akuuubn ---- $accountData');
  }

  @override
  void onReady() {
    getUsers();
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
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
        var token = json['data'];
        GetStorage().write('token', token);
        cNav.tabController.index = 2;
        Timer(const Duration(seconds: 1),
            () =>Get.toNamed('navbar-page'));
        cemail.clear();
        cpw.clear();
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occurred";
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

  Future<void> logout() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.logout);
      http.Response response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData['code'] == '200') {
          print(responseData['message']);
          GetStorage().remove('token');
          Timer(const Duration(seconds: 1),
              () => Get.offAndToNamed(Routes.NAVBAR_PAGE));

          // Lakukan tindakan yang diperlukan setelah logout berhasil
        } else {
          throw 'Gagal logout: ${responseData['message']}';
        }
      } else {
        throw 'Gagal logout: ${response.reasonPhrase}|| ${response.statusCode}';
      }
    } catch (error) {
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

  // Future<void> fetchUsers() async {
  //   try {
  //     var fetchedUsers = await getUsers();
  //     accountData.assignAll(fetchedUsers);
  //   } catch (error) {
  //     // Handle error jika terjadi kesalahan dalam mengambil pengguna
  //     print('Terjadi kesalahan: $error');
  //   }
  // }
}
