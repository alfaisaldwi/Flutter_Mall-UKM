import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 60.0),
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * .2,
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
                          'Akun',
                          style: Styles.headerStyles,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.settings_outlined,
                            size: 25,
                          ),
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
                          Expanded(
                            child: Text(
                              'Alleexx Lexxaa Xyeeee',
                              style: Styles.headerStyles,
                            ),
                          ),
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
                            style: Styles.headerStyles,
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
                              leading: const Icon(
                                Icons.wallet_rounded,
                                size: 20,
                              ),
                              title: Text(
                                'Daftar Transaksi',
                                style: Styles.bodyStyle,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.flight),
                              title: Text(
                                'Flight',
                                style: Styles.bodyStyle,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.train,
                                size: 25,
                              ),
                              title: Text(
                                'Train',
                                style: Styles.bodyStyle,
                              ),
                            )
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
                            style: Styles.headerStyles,
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
                              leading: const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                              ),
                              title: Text(
                                'Alamat Pengiriman',
                                style: Styles.bodyStyle,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.key_outlined),
                              title: Text(
                                'Ubah Kata Sandi',
                                style: Styles.bodyStyle,
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
                            style: Styles.headerStyles,
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
                              leading: const Icon(
                                Icons.headphones_outlined,
                                size: 20,
                              ),
                              title: Text(
                                'Hubungi Customer Service Mall UKM Cirebon',
                                style: Styles.bodyStyle,
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.file_copy_outlined),
                              title: Text(
                                'Syarat dan Ketentuan',
                                style: Styles.bodyStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
