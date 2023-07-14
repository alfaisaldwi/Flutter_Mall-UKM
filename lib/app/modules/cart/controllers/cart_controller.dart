// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/model/cart/cartItem_model.dart';
import 'package:mall_ukm/app/model/cart/cart_model.dart';
import 'package:mall_ukm/app/service/repository/users_repository.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  RxBool checkbox = false.obs;
  RxInt counter = 1.obs;
  var carts = <Cart>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    fetchCart();

    super.onReady();
  }

  Future<void> addToCart(CartItem cartItem) async {
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

  Future<List<Cart>> getStoreData() async {
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
      if (jsonResponse['code'] == 200) {
        final cartData = jsonResponse['data'];
        List<Cart> cartList = [];
        for (var data in cartData) {
          var cart = Cart.fromJson(data);
          cartList.add(cart);
        }
        return cartList; // Return outside the loop
      } else {
        print('Data Store berhasil diambil: $jsonResponse');
      }
    } else {
      print('Gagal mengambil data Store');
    }
    return []; // Return an empty list as default value
  }

  Future<void> fetchCart() async {
    try {
      var fetchedProducts = await getStoreData();
      carts.assignAll(fetchedProducts);
    } catch (error) {
      // Handle error if there is an issue fetching the products
      print('Error fetching products: $error');
    }
  }

  Future<void> deleteCart(int cartId) async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.cartEndPoints.delete + '$cartId');
    print(url);
    final response = await http.post(url, headers: headers);
    print('response');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['code'] == 200) {
        carts.removeWhere((cart) => cart.id == cartId);
        print('Cart berhasil dihapus');
      } else {
        print('Gagal menghapus cart: ${jsonResponse['message']}');
      }
    } else {
      print('Gagal menghapus cart. Kode status: ${response.statusCode}');
    }
  }

  Future<void> updateCart(int cartId, CartItem cartItem) async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.cartEndPoints.update + '$cartId');
    final body = jsonEncode(cartItem.toJson());

    print(url);
    final response = await http.post(url, body: body, headers: headers);
    print('response');
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['code'] == 200) {
        print('Item berhasil diupdate');
      } else {
        print('Gagal mengupdate cart: ${jsonResponse['message']}');
      }
    } else {
      print('Gagal mengupdate cart. Kode status: ${response.statusCode}');
    }
  }
}
