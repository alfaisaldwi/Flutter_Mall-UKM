import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/checkout/controllers/checkout_offline_controller.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
    Get.lazyPut<CheckoutOfflineController>(
      () => CheckoutOfflineController(),
    );
  }
}
