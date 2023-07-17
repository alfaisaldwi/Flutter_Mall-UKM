import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyHomePage extends StatelessWidget {
  final String url;
  MyHomePage({Key? key, required this.url}) : super(key: key);
  var contr = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    WebViewController _controller;
    return Scaffold(body: SafeArea(child: WebViewWidget(controller: contr.ctr)));
  }
}
