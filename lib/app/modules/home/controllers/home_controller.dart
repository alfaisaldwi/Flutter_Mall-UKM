import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/service/repository/users_repository.dart';

import '../../../model/users/category/index_model.dart';

class HomeController extends GetxController {
  TextEditingController cSearch = TextEditingController();

  final count = 0.obs;
  var category = <Category>[].obs;

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
    fetchCategories();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  Future<List<Category>> getCategories() async {
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL25vbmFtZWFwaS5teS5pZC9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTY4ODU2OTA1MSwiZXhwIjoxNjg4NTcyNjUxLCJuYmYiOjE2ODg1NjkwNTEsImp0aSI6IjJGelp5Mm9kbU13dTJybUIiLCJzdWIiOiIzIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.31PffV3e-Sy6VjoQ1xZNYncUgeSEIzkWiXSrAE25k4c'
    };
    try {
      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.category,
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

  Future<void> fetchCategories() async {
    try {
      var fetchedCategories = await getCategories();
      category.assignAll(fetchedCategories);
    } catch (error) {
      // Handle error jika terjadi kesalahan dalam mengambil kategori
      print('Terjadi kesalahan: $error');
    }
  }
}
