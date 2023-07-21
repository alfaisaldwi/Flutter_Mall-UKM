import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavbarPageController extends GetxController {
  Rx<bool>? isSelected;
  final contr = PersistentTabController(initialIndex: 0);
  var transactionC = Get.put(TransactionPageController);

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
