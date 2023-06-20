import 'package:get/get.dart';

import '../controllers/survey_page_controller.dart';

class SurveyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurveyPageController>(
      () => SurveyPageController(),
    );
  }
}
