import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/transaction/transaction_index_model.dart';
import 'package:mall_ukm/app/model/transaction/transaction_show.dart';
import 'package:mall_ukm/app/modules/checkout/views/webwiew_checkout%20.dart';
import 'package:mall_ukm/app/service/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class TransactionPageController extends GetxController {
  final iconSize = 350.0.obs;
  var transactionIndexList = <Transaction>[].obs;
  var transactionIndexPaid = <Transaction>[].obs;
  var transactionIndexUnpaid = <Transaction>[].obs;
  var isLoading = true.obs;
  var transactionDetail = Rx<TransactionShow>(TransactionShow());
  WebViewController ctr = WebViewController();

  final count = 0.obs;
  @override
  void onInit() {
    getTransaction();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<void> getTransaction() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.transactionEndPoints.index);
      http.Response response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['code'] == 200) {
          final addressData = jsonResponse['data'] as List<dynamic>;
          List<Transaction> transactionListData = [];
          for (var data in addressData) {
            var address = Transaction.fromJson(data);
            transactionListData.add(address);
          }
          transactionIndexList.assignAll(transactionListData);
          print(transactionListData);
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

  Future<TransactionShow> fetchDetailTransaction(int transactionId) async {
    try {
      String? token = GetStorage().read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var url = Uri.parse(
        ApiEndPoints.baseUrl +
            ApiEndPoints.transactionEndPoints.show +
            '/$transactionId',
      );
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var transactionShow = TransactionShow.fromJson(jsonData['data']);
        return transactionShow;
      } else {
        throw Exception('Failed to load category data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load category data');
    }
  }

  String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

  void callGettrs() {
    getTransaction();
  }

  void bayar(String url) {
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
      ..loadRequest(Uri.parse(url));

    Get.offAll((WebviewCheckout()), arguments: url);

    // Navigator.push(
    //     Get.context!,
    //     MaterialPageRoute(
    //       builder: (context) => MyHomePage(
    //         url: paymentUrl,
    //       ),
    //     ));
    print(url);
  }
}
