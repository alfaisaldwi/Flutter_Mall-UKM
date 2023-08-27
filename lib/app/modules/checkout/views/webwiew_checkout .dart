import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:mall_ukm/app/modules/navbar_page/controllers/navbar_page_controller.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewCheckout extends GetView<TransactionPageController> {
  var contr = Get.put(CheckoutController());
  var controllerNav = Get.put(NavbarPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pembayaran'),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Get.offNamed('navbar-page');
                controllerNav.tabController.index = 2;
              },
            ),
          ],
        ),
        body: SafeArea(
            child: WillPopScope(
          onWillPop: () async {
            if (await contr.ctr.canGoBack()) {
              contr.ctr.goBack();
              return false;
            } else {
              contr.callTransaksi();
              Get.offNamed('navbar-page'); // Kembali ke halaman 'navbar-page'
              controllerNav.tabController.index = 2;
              return true;
            }
          },
          child: WebViewWidget(
              controller: controller.ctr, gestureRecognizers: const <
                  Factory<OneSequenceGestureRecognizer>>{}),
        )));
  }
}
