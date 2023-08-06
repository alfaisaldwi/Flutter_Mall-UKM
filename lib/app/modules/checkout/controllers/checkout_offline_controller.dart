import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/address/address_select.dart';
import 'package:mall_ukm/app/model/transaction/checkout_data_offline.dart';
import 'package:mall_ukm/app/model/transaction/transaction_store_model.dart';
import 'package:mall_ukm/app/modules/address/controllers/address_controller.dart';
import 'package:mall_ukm/app/modules/cart/controllers/cart_controller.dart';
import 'package:mall_ukm/app/modules/cart/views/cart_view.dart';
import 'package:mall_ukm/app/modules/checkout/views/webwiew.dart';
import 'package:mall_ukm/app/modules/checkout/views/webwiew_offline.dart';
import 'package:mall_ukm/app/modules/navbar_page/controllers/navbar_page_controller.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:mall_ukm/app/service/api_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutOfflineController extends GetxController {
  var controllerNav = Get.put(NavbarPageController());
  TextEditingController selectedCourier1 = TextEditingController();
   var isLoading = false.obs;

  WebViewController ctr = WebViewController();
  var idkecamatan = '';
  var weight = ''.obs;
  RxList<RxInt> weight2 = <RxInt>[].obs;
  var totalWeight = ''.obs;
  Rx<Future<AddressSelect>>? futureAddress;

  Future<TransaksiStore> tambahDataTransaksiOffline(
      CheckoutDataOffline checkoutDataOffline) async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.transactionEndPoints.storeOffline);
    final body = jsonEncode(checkoutDataOffline.toJson());

    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 200) {
      TransaksiStore transaksi =
          TransaksiStore.fromJson(jsonDecode(response.body));
      print(response.body);

      if (transaksi.data!.paymentUrl != null) {
        String paymentUrl = transaksi.data!.paymentUrl!;
        ctr = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(const Color(0x00000000))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                // Update loading bar.
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              onWebResourceError: (WebResourceError error) {},
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(paymentUrl));

        Get.offAll((WebviewCheckoutOffline()), arguments: url);

        print(paymentUrl);
      }

      return transaksi;
    } else {
      // Jika gagal, lempar exception atau lakukan penanganan kesalahan sesuai kebutuhan
      throw Exception(
          'Gagal menambahkan data transaksi. Status code: ${response.statusCode} ${response.body}');
    }
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

  void refreshAddress() {
    futureAddress!.value = getAddress();
  }

  @override
  void onInit() {
    futureAddress = Rx<Future<AddressSelect>>(getAddress());
    print(totalWeight);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // Get.back(result: null);
    super.onClose();
  }

  String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  void callTransaksi() {
    TransactionPageController transaksiController =
        Get.find<TransactionPageController>();
    transaksiController.callGettrs();
  }

  void callAdress() {
    AddressController addressController = Get.find<AddressController>();
    addressController.getAddress();
  }

  void goToCartAndRefresh() {
    Get.off(() => CartView()); // Kembali ke halaman cart
    Get.find<CartController>().refreshCartData();
    Get.find<CartController>().fetchCart();
    Get.find<CartController>().totalHarga.value = 0.0;
    // Refresh controller cart
    // Refresh controller cart
  }
}
