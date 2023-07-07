import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/home/controllers/home_controller.dart';
import 'package:mall_ukm/app/modules/recommend_page/controllers/recommend_page_controller.dart';

import 'app/modules/profile/controllers/profile_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<HomeController>(
      () => HomeController(),fenix: true
    );
Get.lazyPut<RecommendPageController>(
      () => RecommendPageController(),fenix: true
    );
     Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}
