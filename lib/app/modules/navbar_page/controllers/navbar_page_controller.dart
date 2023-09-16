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
  void callGettrs() {
    TransactionPageController transactionPageController =
        Get.put(TransactionPageController());

    transactionPageController.callGettrs();
    RecommendPageController recommendPageController =
        Get.put(RecommendPageController());
    // recommendPageController.fetchRecomend();
    recommendPageController.fetchRecomend();

    // recommendPageController.fetchRecomend2();
    ProfileController profilePageController = Get.put(ProfileController());

    profilePageController.getUsers();
  }

  @override
  void onInit() {
    callGettrs();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
