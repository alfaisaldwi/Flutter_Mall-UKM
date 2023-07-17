import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/model/transaction/transaction_index_model.dart';
import 'package:mall_ukm/app/service/repository/users_repository.dart';
import 'package:http/http.dart' as http;

class TransactionPageController extends GetxController {
  final iconSize = 350.0.obs;
  var transactionIndexList = <Transaction>[].obs;

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

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('response getadress decode  ${response.statusCode}');

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
}
