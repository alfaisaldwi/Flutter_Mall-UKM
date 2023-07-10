import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/modules/navbar_page/controllers/navbar_page_controller.dart';
import 'package:mall_ukm/app/modules/profile/views/account_view.dart';
import 'package:mall_ukm/app/modules/profile/views/signin_view.dart';
import 'package:mall_ukm/app/style/styles.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    String? token = GetStorage().read('token');
    RxString tokenRx = RxString(token ?? '');
    return Obx(() => Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  if (tokenRx.value.isNotEmpty)
                    GetBuilder<ProfileController>(
                      init: ProfileController(),
                      builder: (controller) => AccountView(),
                    ),
                  if (tokenRx.value.isEmpty)
                    GetBuilder<ProfileController>(
                      init: ProfileController(),
                      builder: (controller) => SigninView(),
                    ),
                ],
              ),
            ),
          ),
        ));
  }
}
