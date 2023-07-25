import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/profile/controllers/profile_controller.dart';
import 'package:mall_ukm/app/modules/recommend_page/controllers/recommend_page_controller.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavbarPageController extends GetxController {
  Rx<bool>? isSelected;
  final contr = PersistentTabController(initialIndex: 0);
  var transactionC = Get.put(TransactionPageController);

  final PersistentTabController tabController = PersistentTabController();
  void _callGettrs() {
    TransactionPageController transaksiController =
        Get.find<TransactionPageController>();
    transaksiController.getTransaction();

    RecommendPageController recommendPageController =
        Get.find<RecommendPageController>();
    recommendPageController.fetchRecomend();
    recommendPageController.fetchRecomend2();
    ProfileController profileController = Get.find<ProfileController>();
    profileController.getUsers();
  }

  @override
  void onInit() {
    _callGettrs();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
