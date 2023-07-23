import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/product/reccomend_product_detail.dart';
import 'package:mall_ukm/app/service/api_service.dart';
import 'package:http/http.dart' as http;

class ProductDetailController extends GetxController {
  List<String> imageUrls = [];
  var recomend = <RecommendProductDetail>[].obs;
  var quantity = 1.obs;
  var selectedVariant = ''.obs;

  var currentIndex = 0.obs;

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    currentIndex.value = index;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void selectVariant(String variant) {
    selectedVariant.value = variant;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    fetchRecomend();
    super.onReady();
  }

  @override
  void onClose() {}

  Future<List<RecommendProductDetail>> getRecomend() async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.recomend + '6',
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
      print(recomend);
    } catch (error) {
      // Handle error if there is an issue fetching the products
      print('Error fetching products: $error');
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
