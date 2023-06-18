import 'package:get/get.dart';

import '../controllers/transaction_page_controller.dart';

class TransactionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionPageController>(
      () => TransactionPageController(),
    );
  }
}
