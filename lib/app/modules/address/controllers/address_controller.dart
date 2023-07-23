import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mall_ukm/app/model/address/address_index.dart';
import 'package:mall_ukm/app/model/address/address_model.dart';
import 'package:mall_ukm/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:mall_ukm/app/service/api_service.dart';

class AddressController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController addressDetail = TextEditingController();
  var provinceId = ''.obs;
  var cityId = ''.obs;
  var districtId = ''.obs;

  var addressIndexList = <AddressIndex>[].obs;

  RxList<String> addressList = <String>[].obs;
  var provinces = [].obs;
  var cities = [].obs;
  var subdistrictId = ''.obs;
  var selectedSubdistrictId = ''.obs;
  var districts = [].obs;
  var addressName = ''.obs;
  var alamatNameObs = ''.obs;
  var selectedProvinceName = ''.obs;
  var selectedCityName = ''.obs;
  var selectedDistrictName = ''.obs;
  Rx<AddressIndex?> selectedAddress = Rx<AddressIndex?>(null);

  bool isSelected(AddressIndex address) {
    return selectedAddress.value?.id == address.id;
  }

  void fetchProvinces() async {
    final String apiUrl = "https://pro.rajaongkir.com/api/province";
    final String apiKey =
        "ef61419fa7acff0b3771ac86a6b6e349"; // Ganti dengan API key Anda
    var response = await http.get(Uri.parse(apiUrl), headers: {
      'key': apiKey,
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      provinces.value = jsonData['rajaongkir']['results'];
    }
  }

  String? lastSelectedProvinceId;
  String? lastSelectedCityId;

  void fetchCities(String provinceId) async {
    lastSelectedProvinceId = provinceId;
    final String apiUrl =
        "https://pro.rajaongkir.com/api/city?province=$provinceId";
    final String apiKey =
        "ef61419fa7acff0b3771ac86a6b6e349"; // Ganti dengan API key Anda
    var response = await http.get(Uri.parse(apiUrl), headers: {
      'key': apiKey,
    });

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      cities.value = jsonData['rajaongkir']['results'];
    }
  }

  void fetchSubdistricts(String cityId) async {
    lastSelectedCityId = cityId;
    final String apiUrl =
        "https://pro.rajaongkir.com/api/subdistrict?city=$cityId";
    final String apiKey = "ef61419fa7acff0b3771ac86a6b6e349"; //
    var response = await http.get(Uri.parse(apiUrl), headers: {
      'key': apiKey,
    });
    var jsonData = json.decode(response.body);
    districts.value = jsonData['rajaongkir']['results'];
  }

  final count = 0.obs;
  @override
  void onInit() {
    fetchProvinces();
    getAddress();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getAdrresNow() {
    CheckoutController checkoutController = Get.find<CheckoutController>();
    checkoutController.getAddress();
  }

  Future<void> getAddress() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.addressEndPoints.addressIndex);
      http.Response response = await http.get(url, headers: headers);
      print('response getadress ${response.statusCode}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('response getadress decode  ${response.statusCode}');

        if (jsonResponse['code'] == "200") {
          final addressData = jsonResponse['data'] as List<dynamic>;
          List<AddressIndex> addressListData = [];
          for (var data in addressData) {
            var address = AddressIndex.fromJson(data);
            addressListData.add(address);
          }
          addressIndexList.assignAll(addressListData);
          print(addressList);
        } else {
          throw jsonResponse['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occurred";
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> addAdress(Address address) async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.addressEndPoints.addressAdd,
    );

    final body = jsonEncode(address.toJson());

    http.Response response = await http.post(url, body: body, headers: headers);
    print('body $body ||| ${response.body} ||| STATUS ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['code'] == "200") {
        Fluttertoast.showToast(
          msg: 'Berhasil menambahkan alamat ',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
        getAddress();
        Get.offAndToNamed('/adress-index');
        print('Alamat berhasil ditambahkan');
      } else {
        print(
            'Gagal menambahkan Alamat ${response.body} ||| ${jsonResponse['code']} || ${jsonResponse}');
      }
    }
  }

  Future<void> updateStatus(int idAddress) async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
      ApiEndPoints.baseUrl +
          ApiEndPoints.addressEndPoints.updateStatus +
          '$idAddress/selected',
    );

    http.Response response = await http.post(url, headers: headers);
    print(' ||| ${response.body} ||| STATUS ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['code'] == "200") {
        Fluttertoast.showToast(
          msg: 'Berhasil mengubah alamat utama',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
        print('Alamat berhasil dipilih');
      } else {
        print(
            'Gagal menambahkan Alamat ${response.body} ||| ${jsonResponse['code']} || ${jsonResponse}');
      }
    }
  }

  Future<void> deleteAdress(int idAddress) async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
      ApiEndPoints.baseUrl +
          ApiEndPoints.addressEndPoints.addressDelete +
          '$idAddress',
    );

    http.Response response = await http.post(url, headers: headers);
    print(' ||| ${response.body} ||| STATUS ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['code'] == "200") {
        getAddress();

        Fluttertoast.showToast(
          msg: 'Berhasil mengahapus alamat',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
      } else {
        print(
            'Gagal menambahkan Alamat ${response.body} ||| ${jsonResponse['code']} || ${jsonResponse}');
      }
    }
  }
}
