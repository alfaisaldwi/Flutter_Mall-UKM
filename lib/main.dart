import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() {   
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
  runApp(
    GetMaterialApp(
      title: "Mall UKM",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
