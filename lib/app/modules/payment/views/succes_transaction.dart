import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/component/awesome_dialog.dart';
import 'package:mall_ukm/app/modules/navbar_page/controllers/navbar_page_controller.dart';
import 'package:mall_ukm/app/modules/navbar_page/views/navbar_page_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction_page_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TransactionSucces extends StatefulWidget {
  const TransactionSucces({super.key});

  @override
  State<TransactionSucces> createState() => _TransactionSuccesState();
}

class _TransactionSuccesState extends State<TransactionSucces> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SuccessDialog.show(
        context: context,
        title: 'Pembayaran Sukses',
        desc: 'Silahkan lihat dimenu Transaksi',
        btnOkOnPress: () async {
          // Navigator.of(context).pushAndRemoveUntil(
          //   MaterialPageRoute(
          //     builder: (BuildContext context) {
          //       return TransactionPageView();
          //     },
          //   ),
          //   (_) => false,
          // );
          NavbarPageController navbarPageController =
              Get.put(NavbarPageController());
          navbarPageController.tabController.index = 2;

          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: NavbarPageView(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      );
    });
  }

  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
