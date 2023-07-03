import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavbarPageController extends GetxController {
  Rx<bool>? isSelected;
  final contr = PersistentTabController(initialIndex: 0);
  

final PersistentTabController tabController = PersistentTabController();

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
