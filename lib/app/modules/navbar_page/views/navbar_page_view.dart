import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/home/views/home_view.dart';
import 'package:mall_ukm/app/modules/profile/views/profile_view.dart';
import 'package:mall_ukm/app/modules/recommend_page/views/recommend_page_view.dart';
import 'package:mall_ukm/app/modules/transaction_page/views/transaction_page_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../controllers/navbar_page_controller.dart';

class NavbarPageView extends GetView<NavbarPageController> {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  List<Widget> _buildScreen() {
    return [
      HomeView(),
      RecommendPageView(),
      TransactionPageView(),
      ProfileView(),
    ];
  }
  List<PersistentBottomNavBarItem> _navbarItem() {
    return [
      PersistentBottomNavBarItem(
          title: 'Beranda',
          icon: const Icon(
            Icons.home_rounded,
            size: 24,
            color: Color.fromRGBO(36, 54, 101, 1.0),
          ),
          activeColorPrimary: const Color(0xffF8C800),
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.white),
      PersistentBottomNavBarItem(
          title: 'Rekomendasi',
          icon: const Icon(
            Icons.thumb_up_alt,
            size: 24,
            color: Color.fromRGBO(36, 54, 101, 1.0),
          ),
          activeColorPrimary: const Color(0xffF8C800),
          inactiveColorPrimary: CupertinoColors.systemGrey),
      PersistentBottomNavBarItem(
          title: 'Transaksi',
          activeColorSecondary: Colors.black,
          icon: const Icon(Icons.wallet_rounded,
              size: 24, color: Color.fromRGBO(36, 54, 101, 1.0)),
          activeColorPrimary: const Color(0xffF8C800),
          inactiveColorPrimary: Colors.grey,
          inactiveColorSecondary: Colors.white),
      PersistentBottomNavBarItem(
          title: 'Akun',
          activeColorSecondary: Colors.black,
          icon: const Icon(Icons.person_outline,
              size: 24, color: Color.fromRGBO(36, 54, 101, 1.0)),
          activeColorPrimary: const Color(0xffF8C800),
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
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      controller: controller.tabController,
    );
  }
}
