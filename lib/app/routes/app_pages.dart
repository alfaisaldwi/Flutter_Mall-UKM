import 'package:get/get.dart';

import 'package:mall_ukm/app/modules/home/bindings/home_binding.dart';
import 'package:mall_ukm/app/modules/home/views/home_view.dart';
import 'package:mall_ukm/app/modules/navbar_page/bindings/navbar_page_binding.dart';
import 'package:mall_ukm/app/modules/navbar_page/views/navbar_page_view.dart';
import 'package:mall_ukm/app/modules/profile/bindings/profile_binding.dart';
import 'package:mall_ukm/app/modules/profile/views/profile_view.dart';
import 'package:mall_ukm/app/modules/recommend_page/bindings/recommend_page_binding.dart';
import 'package:mall_ukm/app/modules/recommend_page/views/recommend_page_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/bindings/transaction_page_binding.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction_page_view.dart';
import 'package:mall_ukm/splash_binding.dart';
import 'package:mall_ukm/splashscreen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR_PAGE,
      page: () => NavbarPageView(),
      binding: NavbarPageBinding(),
    ),
    GetPage(
      name: _Paths.RECOMMEND_PAGE,
      page: () => RecommendPageView(),
      binding: RecommendPageBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_PAGE,
      page: () => TransactionPageView(),
      binding: TransactionPageBinding(),
    ),
  ];
}
