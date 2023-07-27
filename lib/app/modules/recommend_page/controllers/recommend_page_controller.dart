import 'dart:convert';

import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/product/reccomend_product_detail.dart';
import 'package:mall_ukm/app/model/recomend/recomend_model.dart';
import 'package:mall_ukm/app/service/api_service.dart';
import 'package:http/http.dart' as http;

class RecommendPageController extends GetxController {
  //TODO: Implement RecommendPageController
  var recomend = <RecommendProductDetail>[].obs;
  var recomends = List<Recomend>.empty().obs;

  var recomend2 = <RecommendProductDetail>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    // fetchRecomend();
    recomendProduct();
    // fetchRecomend2();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<List<RecommendProductDetail>> getRecomend() async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.recomend + '7',
      );
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          final data = jsonResponse['data'] as List<dynamic>;
          final recomendDetails = data
              .map(
                  (productData) => RecommendProductDetail.fromJson(productData))
              .toList();
          return recomendDetails;
        } else {
          throw Exception(
              'Failed to fetch product details: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch product details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching product details: $e');
    }
  }

  Future<void> fetchRecomend() async {
    try {
      var fetchedProducts = await getRecomend();
      recomend.assignAll(fetchedProducts);
    } catch (error) {
      // Handle error if there is an issue fetching the products
      print('Error fetching products: $error');
    }
  }

  Future<List<RecommendProductDetail>> getRecomend2() async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.recomend + '7',
      );
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          final data = jsonResponse['data'] as List<dynamic>;
          final recomendDetails = data
              .map(
                  (productData) => RecommendProductDetail.fromJson(productData))
              .toList();
          return recomendDetails;
        } else {
          throw Exception(
              'Failed to fetch product details: ${jsonResponse['message']}');
        }
      } else {
        throw Exception(
            'Failed to fetch product details. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching product details: $e');
    }
  }

  Future<void> fetchRecomend2() async {
    try {
      var fetchedProducts2 = await getRecomend2();
      recomend2.assignAll(fetchedProducts2);
      print(recomend2);
    } catch (error) {
      // Handle error if there is an issue fetching the products
      print('Error fetching products: $error');
    }
  }

  Future<void> recomendProduct() async {
     var headers = {
      'Accept': 'application/json',
    };

      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.recomendshow,
      );
      http.Response response = await http.get(url, headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data['code']);
      List<Recomend> recomendList =
          (data['data'] as List).map((e) => Recomend.fromJson(e)).toList();
      recomends.value = recomendList;
    } else {
      // Handle error jika request gagal
      print('Failed to load data');
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
}
