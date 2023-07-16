import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mall_ukm/app/model/address/address_select.dart';
import 'package:mall_ukm/app/service/repository/users_repository.dart';

class CheckoutController extends GetxController {
  TextEditingController selectedCourier1 = TextEditingController();
  var selectedCourier = ''.obs;
  final selectedService = ''.obs;
  final services = <dynamic>[].obs;
  final costValue = 0.0.obs;
  var costSample = 0;

  final List<String> couriers = ['jne', 'pos', 'tiki'];
  final List<String> layanan = ['jne', 'pos', 'tiki'];

  void fetchServices() async {
    final String apiUrl = "https://pro.rajaongkir.com/api/cost";
    final String origin = "109";
    final String originType = "city";
    final String destination = "3577";
    final String destinationType = "subdistrict";
    final String weight = "1700";

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'key': 'ef61419fa7acff0b3771ac86a6b6e349', // Ganti dengan API key Anda
    };

    final Map<String, dynamic> requestBody = {
      "origin": origin,
      "originType": originType,
      "destination": destination,
      "destinationType": destinationType,
      "weight": weight,
      "courier": selectedCourier.value,
    };

    var response = await http.post(Uri.parse(apiUrl),
        headers: headers, body: json.encode(requestBody));
    var jsonData = json.decode(response.body);
    print(response.body);

    services.value =
        jsonData['rajaongkir']['results'][0]['costs'] as List<dynamic>;

    print(' serviceee ${services.value}');
  }

  Future<AddressSelect> getAddress() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.addressEndPoints.addressSelect);
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final data = responseData['data'];

      return AddressSelect.fromJson(data);
    } else {
      throw Exception('Gagal mengambil data alamat');
    }
  }

  Future<void> addToCart(cartItem) async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.cartEndPoints.store,
    );

    final body = jsonEncode(cartItem.toJson());

    http.Response response = await http.post(url, body: body, headers: headers);
    print('body $body ||| ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['code'] == 200) {
        print('Item berhasil ditambahkan ke keranjang');
      } else {
        print(
            'Gagal menambahkan item ke keranjang ${response.body} ||| ${jsonResponse['code']} || ${jsonResponse}');
      }
    }
  }

  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
