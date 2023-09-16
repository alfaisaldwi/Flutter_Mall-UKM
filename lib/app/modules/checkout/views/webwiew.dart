import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:mall_ukm/app/modules/navbar_page/controllers/navbar_page_controller.dart';
import 'package:mall_ukm/app/modules/payment/views/pending_transaction.dart';
import 'package:mall_ukm/app/modules/payment/views/succes_transaction.dart';
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
          elevation: 0,
          title: Text(
            'Pembayaran',
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionPending(),
                    ));
                // controllerNav.tabController.index = 2;
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
              await Get.offNamed('navbar-page');
              controllerNav.tabController.index = 2;
              return true;
            }
          },
          child: WebViewWidget(
              controller: contr.ctr, gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{}),
        )));
  }
}
