import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_ukm/app/component/awesome_dialog.dart';
import 'package:mall_ukm/app/model/profile_company/profile_company.dart';
import 'package:mall_ukm/app/modules/navbar_page/controllers/navbar_page_controller.dart';
import 'package:mall_ukm/app/modules/profile/controllers/profile_controller.dart';
import 'package:mall_ukm/app/modules/checkout/views/webwiew.dart';
import 'package:mall_ukm/app/modules/profile_company/controllers/profile_company_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:mall_ukm/app/style/first_capitalize.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AccountView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    var profileCompany = Get.put(ProfileCompanyController());
    NavbarPageController controllerNav = Get.find<NavbarPageController>();
    ProfileController controllerP = Get.find<ProfileController>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Column(children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bg-profile.jpg'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 10.0),
                    child: (Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Profil',
                            style: Styles.headerStyles(),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 22.0, horizontal: 25),
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  height: 40,
                                  child: Image.asset(
                                      'assets/images/profile-avatar.png')),
                            ),
                            Obx(() {
                              return Expanded(
                                child: Text(
                                  (controllerP.accountData.value['name'] ??
                                      'User'),
                                  style: Styles.headerStyles(),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 10, left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Aktifitas Akun',
                              style: Styles.headerStyles(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controllerNav.tabController.index = 2;
                                },
                                child: ListTile(
                                  leading: Icon(
                                    Icons.wallet_outlined,
                                    size: 20,
                                    color: Styles.colorPrimary(),
                                  ),
                                  title: Text(
                                    'Daftar Transaksi',
                                    style: Styles.bodyStyle(),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => (Get.toNamed('/cart')),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 20,
                                    color: Styles.colorPrimary(),
                                  ),
                                  title: Text(
                                    'Keranjang',
                                    style: Styles.bodyStyle(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 10, left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Pengaturan Akun',
                              style: Styles.headerStyles(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.toNamed('/address-index');
                                },
                                leading: Icon(
                                  Icons.location_on_outlined,
                                  size: 20,
                                  color: Styles.colorPrimary(),
                                ),
                                title: Text(
                                  'Alamat Pengiriman',
                                  style: Styles.bodyStyle(),
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.toNamed('/change-password');
                                },
                                leading: Icon(
                                  Icons.key_outlined,
                                  color: Styles.colorPrimary(),
                                ),
                                title: Text(
                                  'Ubah Kata Sandi',
                                  style: Styles.bodyStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 10, left: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Pusat Bantuan',
                              style: Styles.headerStyles(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            children: [
                              // ListTile(
                              //   onTap: () async {
                              //     await profileCompany.fetchProfileCompany();
                              //     Get.toNamed('survey-page');
                              //   },
                              //   leading: const Icon(Icons.feedback_rounded),
                              //   title: Text(
                              //     'Survey Kepuasan Pengguna Mall UKM Kota Cirebon',
                              //     style: Styles.bodyStyle(),
                              //   ),
                              // ),
                              ListTile(
                                onTap: () async {
                                  await profileCompany.fetchProfileCompany();
                                  var wa =
                                      profileCompany.profileCompany.value.phone;
                                  try {
                                    final Uri _url = Uri.parse(
                                        '$wa?text=Haloo Admin Mall UKM Kota Cirebon, Saya ingin bertanya sesuatu nih.');
                                    print(_url);
                                    await launchUrl(_url,
                                        mode: LaunchMode.externalApplication);
                                  } catch (err) {
                                    debugPrint('Something bad happened ,$err');
                                  }
                                },
                                leading: Icon(
                                  Icons.quick_contacts_dialer_outlined,
                                  size: 20,
                                  color: Styles.colorPrimary(),
                                ),
                                title: Text(
                                  'Hubungi Customer Service',
                                  style: Styles.bodyStyle(),
                                ),
                              ),
                              ListTile(
                                onTap: () async {
                                  await profileCompany.fetchProfileCompany();
                                  Get.toNamed('profile-company');
                                },
                                leading: Icon(
                                  Icons.file_copy_rounded,
                                  color: Styles.colorPrimary(),
                                ),
                                title: Text(
                                  'Syarat dan Ketentuan',
                                  style: Styles.bodyStyle(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        WarningDialog.show(
                          context: context,
                          title: 'Anda yakin ingin keluar ?',
                          btnCancelOnPress: () {
                            Get.back();
                          },
                          btnOkOnPress: () {
                            controllerP.logout();
                          },
                        );

                        // GetStorage().remove('token');
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_outlined,
                            color: Colors.red.shade600,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Keluar',
                            style:
                                Styles.headerStyles(color: Colors.red.shade600),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
