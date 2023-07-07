import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/profile/controllers/profile_controller.dart';

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
  }
}
