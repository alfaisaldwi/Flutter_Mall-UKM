import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/carousel/carousel_model.dart';
import 'package:mall_ukm/app/model/product/product_detail_model.dart';
import 'package:mall_ukm/app/model/product/product_model.dart';
import 'package:mall_ukm/app/modules/profile/controllers/preferenceUtils.dart';
import 'package:mall_ukm/app/service/api_service.dart';

import '../../../model/category/category_model.dart';

class HomeController extends GetxController {
  TextEditingController cSearch = TextEditingController();

  final count = 0.obs;
  var category = <Category>[].obs;
  var products = <Product>[].obs;
  RxBool isLoading = false.obs;
  var carouselList = <CarouselIndex>[].obs;
  Timer? _timer;

  @override
  void onInit() {
    fetchProduct();
    startDataRefreshTimer();
    fetchCategories();
    getCarouselData();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _timer?.cancel();
  }

  void startDataRefreshTimer() {
    const refreshInterval =
        Duration(minutes: 1); // Set the refresh interval as desired

    // Start the timer
    _timer = Timer.periodic(refreshInterval, (timer) {
      // Fetch data periodically
      fetchProduct();
      getCarouselData();
      fetchCategories();
    });
  }

  void reFetch() {
    fetchProduct();
    fetchCategories();
    getCarouselData();
  }

  Future<void> getCarouselData() async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.carousel);
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          final carouselData = jsonResponse['data'] as List<dynamic>;
          List<CarouselIndex> carouselListData = [];
          for (var data in carouselData) {
            var carousel = CarouselIndex.fromJson(data);
            carouselListData.add(carousel);
          }
          carouselList.assignAll(carouselListData);
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

  Future<List<Category>> getCategories() async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.category,
      );
      http.Response response = await http.get(url, headers: headers);

      // print(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 200) {
          List<Category> categories = [];
          for (var data in json['data']) {
            var category = Category.fromJson(data);
            categories.add(category);
          }
          return categories;
        } else {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<List<Product>> getProduct() async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.product);
      http.Response response = await http.get(url, headers: headers);

      // print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          final productData = jsonResponse['data'] as List<dynamic>;
          List<Product> productsList = [];
          for (var data in productData) {
            var product = Product.fromJson(data);
            productsList.add(product);
          }
          return productsList;
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

  Future<ProductDetail> fetchProductDetails(int productId) async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse(
        ApiEndPoints.baseUrl +
            ApiEndPoints.productEndPoints.show +
            '$productId',
      );
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          final data = jsonResponse['data'];
          final productDetail = ProductDetail.fromJson(data);
          return productDetail;
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

  Future<ProductDetail> fetchProductDetail(int productId) async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse(
        ApiEndPoints.baseUrl +
            ApiEndPoints.productEndPoints.show +
            '$productId',
      );
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['code'] == 200) {
          final data = jsonResponse['data'];
          final productDetail = ProductDetail.fromJson(data);
          return productDetail;
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

  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await getCategories();
      category.assignAll(fetchedCategories);
    } catch (error) {
      // Handle error jika terjadi kesalahan dalam mengambil kategori
      print('Terjadi kesalahan: $error');
    }
  }

  Future<void> fetchProduct() async {
    try {
      var fetchedProducts = await getProduct();
      products.assignAll(fetchedProducts);
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
