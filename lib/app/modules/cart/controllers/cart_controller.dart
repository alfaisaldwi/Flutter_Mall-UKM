import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/model/cart/cart_model.dart';
import 'package:mall_ukm/app/service/repository/users_repository.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  RxBool checkbox = false.obs;
  RxInt counter = 1.obs;

  Future<void> addToCart(CartItem cartItem) async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.cartEndPoints.cart,
    );

    final body = jsonEncode(cartItem.toJson());
    http.Response response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      print('Item berhasil ditambahkan ke keranjang');
    } else {
      print(
          'Gagal menambahkan item ke keranjang ${response.body} ||| ${response.statusCode}');
    }
  }

  @override
  void onInit() {
    super.onInit();
    getStoreData();
  }

  Future<void> getStoreData() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
      ApiEndPoints.baseUrl + ApiEndPoints.cartEndPoints.cart,
    );

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print('Data Store berhasil diambil: $jsonResponse');

      return jsonResponse['data'];
      // Lakukan pemrosesan data respons sesuai kebutuhan Anda
    } else {
      print('Gagal mengambil data Store');
    }
  }
}
