import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mall_ukm/app/model/carousel/carousel_model.dart';
import 'package:mall_ukm/app/model/category/category_show.dart';
import 'package:mall_ukm/app/model/product/product_detail_model.dart';
import 'package:mall_ukm/app/model/product/product_model.dart';
import 'package:mall_ukm/app/model/product/product_promo_model.dart';
import 'package:mall_ukm/app/modules/product_detail/views/product_detail_promo.dart';
import 'package:mall_ukm/app/service/api_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../model/category/category_model.dart';

class HomeController extends GetxController {
  TextEditingController cSearch = TextEditingController();
  var categoryData = <CategoryShow>[].obs;
  var category = <Category>[].obs;
  var products = <Product>[].obs;
  var isLoadingProduct = true.obs;
  var isLoadingCategory = true.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var radius;
  var productsPromo = <ProductPromo>[].obs;

  var carouselList = <CarouselIndex>[].obs;
  Timer? _timer;

  @override
  void onInit() {
    fetchProduct();
    startDataRefreshTimer();
    requestLocationPermission();
    fetchCategories();
    getCarouselData();
    fetchPromo();

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
    const refreshInterval = Duration(minutes: 1);

    _timer = Timer.periodic(refreshInterval, (timer) {
      fetchPromo();
      fetchProduct();
      getCarouselData();
      fetchCategories();
    });
  }

  void reFetch() {
    postCurrentLocation();
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
      throw '${error.toString()}';
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

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['code'] == 200) {
          List<Category> categories = [];
          for (var data in json['data']) {
            var category = Category.fromJson(data);
            categories.add(category);
          }
          // isLoadingCategory.value = false;

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

  Future<void> fetchCategories() async {
    isLoadingCategory.value = true;

    try {
      var fetchedCategories = await getCategories();
      category.assignAll(fetchedCategories);
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
    await Future.delayed(Duration(seconds: 1));
    isLoadingCategory.value = false;
  }

  Future<void> fetchProduct() async {
    isLoadingProduct.value = true;

    try {
      var fetchedProducts = await getProduct();
      products.assignAll(fetchedProducts);
    } catch (error) {
      // Handle error if there is an issue fetching the products
      print('Error fetching products: $error');
    }
    await Future.delayed(Duration(seconds: 1));
    isLoadingProduct.value = false;
  }

  Future<CategoryShow> categotyDetail(int categoryId) async {
    var headers = {
      'Accept': 'application/json',
    };

    var url = Uri.parse(
      ApiEndPoints.baseUrl +
          ApiEndPoints.productEndPoints.categoryshow +
          '/$categoryId',
    );
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      return CategoryShow.fromJson(jsonData);
    } else {
      throw Exception('Failed to load category data');
    }
  }

  Future<void> fetchPromo() async {
    var headers = {
      'Accept': 'application/json',
    };
    try {
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.productEndPoints.promo);
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];
        final List<ProductPromo> productList =
            responseData.map((item) => ProductPromo.fromJson(item)).toList();
        productsPromo.value = productList;
      } else {
        print('Berhasil ambil data promo');
      }
    } catch (e) {
      print('Error ambil data promo: $e');
    }
  }

  Future postCurrentLocation() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    try {
      geolocator.Position position =
          await geolocator.Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      Map<String, dynamic> requestBody = {
        "latitude": latitude.value,
        "longitude": longitude.value,
      };

      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.checkHaversine.check);

      http.Response response =
          await http.post(url, body: jsonEncode(requestBody), headers: headers);
      print('body $requestBody ||| ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        var radiusData = jsonResponse['data'];
        radius = radiusData;

        Fluttertoast.showToast(
          msg: 'Kamu berada diradius Mall UKM',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
      } else {
        final jsonResponse = jsonDecode(response.body);

        var radiusData = jsonResponse['data'];
        radius = radiusData;
        Fluttertoast.showToast(
          msg: 'Kamu tidak berada diradius Mall UKM',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  void storeOffline() async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };

    try {
      Map<String, dynamic> requestBody = {
        "latitude": latitude.value,
        "longitude": longitude.value,
      };

      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.checkHaversine.check);

      http.Response response =
          await http.post(url, body: jsonEncode(requestBody), headers: headers);
      print('body $requestBody ||| ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        var radiusData = jsonResponse['data'];
        radius = radiusData;

        print(' www ${radius}');

        Fluttertoast.showToast(
          msg: 'Berhasil, Kamu berada diradius Mall UKM',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
        showOrderDialogOffline(Get.context!);
      } else {
        final jsonResponse = jsonDecode(response.body);

        var radiusData = jsonResponse['data'];
        radius = radiusData;
        Fluttertoast.showToast(
          msg: 'Gagal, Kamu tidak berada diradius Mall UKM',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } catch (e) {
      print("Terjadi kesalahan: $e");
    }
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      LocationData locationData = await Location().getLocation();
    } else if (status.isDenied) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Akses Lokasi Diperlukan'),
          content: Text(
              'Anda telah menolak izin lokasi. Buka pengaturan untuk mengizinkannya?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: Text('Buka Pengaturan'),
            ),
          ],
        ),
      );
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Akses Lokasi Diperlukan'),
          content: Text(
              'Anda telah menolak izin lokasi secara permanen. Buka pengaturan untuk mengizinkannya?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Tutup'),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: Text('Buka Pengaturan'),
            ),
          ],
        ),
      );
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
