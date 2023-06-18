import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/home/controllers/home_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<HomeController>(
      () => HomeController(),fenix: true
    );

  }
}
