import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/model/carousel/carousel_model.dart';
import 'package:mall_ukm/app/model/product/product_detail_model.dart';
import 'package:mall_ukm/app/model/product/product_model.dart';
import 'package:mall_ukm/app/modules/profile/controllers/preferenceUtils.dart';
import 'package:mall_ukm/app/service/repository/users_repository.dart';

import '../../../model/category/category_model.dart';

class HomeController extends GetxController {
  TextEditingController cSearch = TextEditingController();

  final count = 0.obs;
  var category = <Category>[].obs;
  var products = <Product>[].obs;
  RxBool isLoading = false.obs;
  var carouselList = <CarouselIndex>[].obs;
  List<CarouselItem> itemList = [
    CarouselItem(
      image: AssetImage('assets/images/thumbnail1.png'),
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title:
          'Push your creativity to its limits by reimagining this classic puzzle!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: AssetImage('assets/images/thumbnail2.png'),
      title: '@coskuncay published flutter_custom_carousel_slider!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: AssetImage('assets/images/thumbnail3.png'),
      title: '@coskuncay published flutter_custom_carousel_slider!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      onImageTap: (i) {},
    )
  ];

  @override
  void onInit() {
    fetchProduct();
    fetchCategories();
    getCarouselData();
    print('fetchhhh $fetchCategories');
    print('catergory $category');
    print(PreferenceUtils.token);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;


  Future<void> getCarouselData() async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url = Uri.parse( ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.carousel);
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

      print(response.body);
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

      print(response.body);
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

  // Future<void> fetchCarousel() async {
  //   try {
  //     var fetchedCarousel = await getCarouselData();
  //     carouselList.assignAll(fetchedCarousel);
  //   } catch (error) {
  //     // Handle error if there is an issue fetching the products
  //     print('Error fetching products: $error');
  //   }
  // }

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
}
