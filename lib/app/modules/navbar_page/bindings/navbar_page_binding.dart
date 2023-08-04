import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/home/controllers/home_controller.dart';
import 'package:mall_ukm/app/modules/profile/controllers/profile_controller.dart';
import 'package:mall_ukm/app/modules/recommend_page/controllers/recommend_page_controller.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';

import '../controllers/navbar_page_controller.dart';

class NavbarPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarPageController>(
      () => NavbarPageController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<TransactionPageController>(
      () => TransactionPageController(),
    );
    Get.lazyPut<RecommendPageController>(
      () => RecommendPageController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
