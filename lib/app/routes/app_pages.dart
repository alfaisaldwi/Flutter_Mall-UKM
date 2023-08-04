import 'package:get/get.dart';

import 'package:mall_ukm/app/modules/address/bindings/address_binding.dart';
import 'package:mall_ukm/app/modules/address/views/address_index_view.dart';
import 'package:mall_ukm/app/modules/address/views/address_view.dart';
import 'package:mall_ukm/app/modules/cart/bindings/cart_binding.dart';
import 'package:mall_ukm/app/modules/cart/views/cart_view.dart';
import 'package:mall_ukm/app/modules/category/bindings/category_binding.dart';
import 'package:mall_ukm/app/modules/category/views/category_view.dart';
import 'package:mall_ukm/app/modules/checkout/bindings/checkout_binding.dart';
import 'package:mall_ukm/app/modules/checkout/views/checkout_offline_view.dart';
import 'package:mall_ukm/app/modules/checkout/views/checkout_view.dart';
import 'package:mall_ukm/app/modules/home/bindings/home_binding.dart';
import 'package:mall_ukm/app/modules/home/views/home_view.dart';
import 'package:mall_ukm/app/modules/navbar_page/bindings/navbar_page_binding.dart';
import 'package:mall_ukm/app/modules/navbar_page/views/navbar_page_view.dart';
import 'package:mall_ukm/app/modules/product_detail/bindings/product_detail_binding.dart';
import 'package:mall_ukm/app/modules/product_detail/views/product_detail_promo.dart';
import 'package:mall_ukm/app/modules/product_detail/views/product_detail_view.dart';
import 'package:mall_ukm/app/modules/profile/bindings/profile_binding.dart';
import 'package:mall_ukm/app/modules/profile/views/profile_view.dart';
import 'package:mall_ukm/app/modules/profile/views/signin_view.dart';
import 'package:mall_ukm/app/modules/profile/views/signup_view.dart';
import 'package:mall_ukm/app/modules/profile_company/bindings/profile_company_binding.dart';
import 'package:mall_ukm/app/modules/profile_company/views/profile_company_view.dart';
import 'package:mall_ukm/app/modules/recommend_page/bindings/recommend_page_binding.dart';
import 'package:mall_ukm/app/modules/recommend_page/views/recommend_page_view.dart';
import 'package:mall_ukm/app/modules/survey_page/bindings/survey_page_binding.dart';
import 'package:mall_ukm/app/modules/survey_page/views/survey_page_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/bindings/transaction_page_binding.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction_detail.dart';
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
    GetPage(
      name: _Paths.SURVEY_PAGE,
      page: () => SurveyPageView(),
      binding: SurveyPageBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => ProductDetailView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL_PROMO,
      page: () => ProductDetailPromoView(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupPageView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS,
      page: () => AddressView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.ADDRESS_INDEX,
      page: () => AddressIndexView(),
      binding: AddressBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_OFFLINE,
      page: () => CheckoutOfflineView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_DETAIL,
      page: () => TransactionDetailView(),
      binding: TransactionPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_COMPANY,
      page: () => ProfileCompanyView(),
      binding: ProfileCompanyBinding(),
    ),
  ];
}
