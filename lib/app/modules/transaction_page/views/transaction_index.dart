import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/modules/profile/controllers/profile_controller.dart';
import 'package:mall_ukm/app/modules/profile/views/signin_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction_page_view.dart';

class TransactionIndex extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    String? token = GetStorage().read('token');
    RxString tokenRx = RxString(token ?? '');

    // Widget yang akan digunakan berdasarkan status login
    Widget activeWidget;

    if (tokenRx.value.isNotEmpty) {
      activeWidget = TransactionPageView();
    } else {
      activeWidget = SigninView();
    }

    return Scaffold(body: activeWidget);
  }
}
