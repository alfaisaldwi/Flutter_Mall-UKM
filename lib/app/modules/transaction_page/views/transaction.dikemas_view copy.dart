import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';

class TransactionDikemasView extends GetView<TransactionPageController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Icon(Icons.key_sharp, size: controller.iconSize.value));
  }
}

class MyController extends GetxController {
  final iconSize = 350.0.obs;
}
