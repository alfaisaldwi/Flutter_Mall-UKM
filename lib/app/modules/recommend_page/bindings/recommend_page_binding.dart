import 'package:get/get.dart';

import '../controllers/recommend_page_controller.dart';

class RecommendPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecommendPageController>(
      () => RecommendPageController(),
    );
  }
}
