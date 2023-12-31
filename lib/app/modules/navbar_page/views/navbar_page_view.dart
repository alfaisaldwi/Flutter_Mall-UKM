import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/modules/home/views/home_view.dart';
import 'package:mall_ukm/app/modules/profile/views/account_view.dart';
import 'package:mall_ukm/app/modules/profile/views/profile_view.dart';
import 'package:mall_ukm/app/modules/profile/views/signin_view.dart';
import 'package:mall_ukm/app/modules/recommend_page/views/recommend_page_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction_index.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction_page_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../controllers/navbar_page_controller.dart';

class NavbarPageView extends GetView<NavbarPageController> {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);
  String? token = GetStorage().read('token');

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  List<Widget> _buildScreen() {
    RxString tokenRx = RxString(token ?? '');
    return [HomeView(), RecommendPageView(), TransactionIndex(), ProfileView()];
  }

  List<PersistentBottomNavBarItem> _navbarItem() {
    return [
      PersistentBottomNavBarItem(
          title: 'Beranda',
          icon: Icon(
            Icons.home_outlined,
            size: 28,
            color: Colors.indigo.shade900,
          ),
          activeColorPrimary: const Color(0xffc77d08),
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.white),
      PersistentBottomNavBarItem(
          title: 'Rekomendasi',
          icon: Icon(
            Icons.thumb_up_alt_outlined,
            size: 24,
            color: Colors.indigo.shade900,
          ),
          activeColorPrimary: const Color(0xffc77d08),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          title: 'Transaksi',
          icon: Icon(
            Icons.wallet_outlined,
            size: 24,
            color: Colors.indigo.shade900,
          ),
          activeColorPrimary: const Color(0xffc77d08),
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.white),
      PersistentBottomNavBarItem(
          title: 'Akun',
          icon: Icon(
            Icons.person_outline,
            size: 24,
            color: Colors.indigo.shade900,
          ),
          activeColorPrimary: const Color(0xffc77d08),
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.white),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      Get.context!,
      screens: _buildScreen(),
      items: _navbarItem(),
      stateManagement: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      navBarStyle: NavBarStyle.style3,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      controller: controller.tabController,
    );
  }
}
