import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/cart/cartItem_model.dart';
import 'package:mall_ukm/app/model/cart/cart_model.dart';
import 'package:mall_ukm/app/model/cart/selectedCart.dart';
import 'package:mall_ukm/app/service/api_service.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  RxList<Cart> carts = <Cart>[].obs;
  RxList<bool> isCheckedList = <bool>[].obs;
  RxList<SelectedCartItem> selectedItems = <SelectedCartItem>[].obs;
  RxList<RxInt> counter = <RxInt>[].obs;
  RxBool counterPlus = false.obs;
  RxDouble totalHarga = 0.0.obs;
  RxBool? isCheckedBox;
  RxList<RxDouble> priceC = <RxDouble>[].obs;
  RxDouble totalWeight = 0.0.obs;
  RxList<RxDouble> subWeightC = <RxDouble>[].obs;
  var selectAllChecked = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    fetchCart();
    super.onReady();
  }

  void updateTotalValues() {
    double totalHargaValue = 0;
    double totalWeightValue = 0;

    for (int index = 0; index < carts.length; index++) {
      if (isChecked(index) == true) {
        totalHargaValue +=
            priceC[index].value * counter[index].value.toDouble();
        totalWeight.value += counter[index].value * subWeightC[index].value;
      }
    }

    totalHarga.value = totalHargaValue;
    // totalWeight.value = totalWeightValue;
  }

  String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  bool? isChecked(int index) {
    if (index >= 0 && index < isCheckedList.length) {
      return isCheckedList[index];
    }
    return null;
  }

  void setChecked(bool value, int index) {
    if (index >= 0 && index < isCheckedList.length) {
      isCheckedList[index] = value;
    }
  }

  void setCheckedAll(bool value) {
    for (int i = 0; i < isCheckedList.length; i++) {
      isCheckedList[i] = value;
    }
  }

  Future<void> fetchCart() async {
    try {
      var fetchedProducts = await getStoreData();
      carts.assignAll(fetchedProducts);
      isCheckedList
          .assignAll(List<bool>.generate(carts.length, (index) => false));
      counter
          .assignAll(List<RxInt>.generate(carts.length, (index) => RxInt(0)));
      priceC.assignAll(
          List<RxDouble>.generate(carts.length, (index) => RxDouble(0.0)));
    } catch (error) {
      // Handle error if there is an issue fetching the products
      print('Error fetching products: $error');
    }
  }

  Future<void> addToCart(CartItem cartItem) async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var url =
        Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.cartEndPoints.store);

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

    var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.cartEndPoints.cart);

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
        return cartList;
      } else {
        print('Data Store berhasil diambil: $jsonResponse');
      }
    } else {
      print('Gagal mengambil data Store');
    }
    return [];
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
        selectedItems.clear();
        totalHarga.value = 0;
        update();
        Fluttertoast.showToast(
          msg: 'Berhasil menghapus barang dari keranjang',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
        print('Cart berhasil dihapus');
      } else {
        carts.removeWhere((cart) => cart.id == cartId);
        Fluttertoast.showToast(
          msg: 'Gagal menghapus barang dari keranjang',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
        print('Gagal menghapus cart: ${jsonResponse['message']}');
      }
    } else {
      print('Gagal menghapus cart. Kode status: ${response.statusCode}');
    }
  }

  Future<void> updateCart(int cartId, CartItem cartItem, int index) async {
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
        if (counterPlus.value == true) {
          counter[index].value++;
          totalHarga.value += priceC[index].value;
          totalWeight.value += subWeightC[index].value;
          // Fluttertoast.showToast(
          //   msg: 'Berhasil menambahkan kuantitas',
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: Colors.grey[800],
          //   textColor: Colors.white,
          //   fontSize: 14.0,
          // );
        } else if (counterPlus.value == false) {
          counter[index].value--;
          totalHarga.value -= priceC[index].value;
          totalWeight.value -= subWeightC[index].value;

          // Fluttertoast.showToast(
          //   msg: 'Berhasil mengurangi kuantitas',
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: Colors.grey[800],
          //   textColor: Colors.white,
          //   fontSize: 14.0,
          // );
        }
        print('Item berhasil diupdate');
      } else if (jsonResponse['code'] == 400) {
        Fluttertoast.showToast(
          msg:
              'Tidak bisa menambah kuantitas karena jumlah yang anda masukkan melebihi stok produk',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );

        print(
            'Gagal mengupdate cart: ${jsonResponse['message']} ${jsonResponse['code']}');
      }
    } else {
      print('Gagal mengupdate cart. Kode status: ${response.statusCode}');
    }
  }

  void refreshCartData() {
    selectedItems.clear();
    Get.put(CartController());
    // update();
    // totalHarga.value = 0.0;
    // isCheckedList.clear();
    // totalWeight.value = 0;
  }
}
