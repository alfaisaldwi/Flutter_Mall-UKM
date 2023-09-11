import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction.canceled_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction.delivered_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction.sending_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction.unpaid_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction.paid_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction.semua_view.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/transaction_page_controller.dart';

class TransactionPageView extends GetView<TransactionPageController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 10,
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            indicatorPadding: EdgeInsets.zero,
            tabs: [
              Tab(
                child: Text(
                  'Semua ',
                  style: Styles.bodyStyle(size: 14, weight: FontWeight.w400),
                ),
              ),
              Tab(
                child: Text(
                  'Belum Bayar',
                  style: Styles.bodyStyle(size: 11, weight: FontWeight.w400),
                ),
              ),
              Tab(
                child: Text(
                  'Sudah bayar',
                  style: Styles.bodyStyle(size: 12, weight: FontWeight.w400),
                ),
              ),
              Tab(
                child: Text(
                  'Sedang dikirim',
                  style: Styles.bodyStyle(size: 12, weight: FontWeight.w400),
                ),
              ),
              Tab(
                child: Text(
                  'Selesai',
                  style: Styles.bodyStyle(size: 12, weight: FontWeight.w400),
                ),
              ),
              Tab(
                child: Text(
                  'Dibatalkan',
                  style: Styles.bodyStyle(size: 14, weight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            controller.callGettrs();
          },
          child: TabBarView(
            children: [
              GetBuilder<TransactionPageController>(
                init: TransactionPageController(),
                builder: (controller) => TransactionSemuaView(),
              ),
              GetBuilder<TransactionPageController>(
                init: TransactionPageController(),
                builder: (controller) => TransactionUnpaidView(),
              ),
              GetBuilder<TransactionPageController>(
                init: TransactionPageController(),
                builder: (controller) => TransactionPaidView(),
              ),
              GetBuilder<TransactionPageController>(
                init: TransactionPageController(),
                builder: (controller) => TransactionSendingView(),
              ),
              GetBuilder<TransactionPageController>(
                init: TransactionPageController(),
                builder: (controller) => TransactionDeliveredView(),
              ),
              GetBuilder<TransactionPageController>(
                init: TransactionPageController(),
                builder: (controller) => TransactionCanceledView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
