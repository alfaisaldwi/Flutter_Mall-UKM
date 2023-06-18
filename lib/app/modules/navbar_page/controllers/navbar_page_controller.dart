import 'package:get/get.dart';

class NavbarPageController extends GetxController {
  var tabIndex = 0.obs;
  Rx<bool>? isSelected;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
