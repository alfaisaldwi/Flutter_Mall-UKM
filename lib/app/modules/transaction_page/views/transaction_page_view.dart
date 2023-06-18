import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transaction_page_controller.dart';

class TransactionPageView extends GetView<TransactionPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TransactionPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TransactionPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
