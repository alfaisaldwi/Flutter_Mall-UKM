import 'package:get/get.dart';

import '../controllers/profile_company_controller.dart';

class ProfileCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileCompanyController>(
      () => ProfileCompanyController(),
    );
  }
}
