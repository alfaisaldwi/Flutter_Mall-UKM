import 'package:get/get.dart';

import '../controllers/navbar_page_controller.dart';

class NavbarPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarPageController>(
      () => NavbarPageController(),
    );
  }
}
