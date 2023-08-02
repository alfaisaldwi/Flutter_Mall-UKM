import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_ukm/app/modules/profile/controllers/profile_controller.dart';
import 'package:mall_ukm/app/modules/profile/views/profile_view.dart';
import 'package:mall_ukm/app/modules/profile/views/signin_view.dart';

class SignupPageView extends GetView<ProfileController> {
  var profileC = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(children: [
            Container(
              padding:
                  EdgeInsets.only(top: 85, left: 40, right: 50, bottom: 20),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Daftar.',
                      style: GoogleFonts.inter(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff034779)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nama Lengkap',
                  style: GoogleFonts.inter(fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: profileC.cnamalengkap,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(26.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: GoogleFonts.inter(fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: profileC.cemail,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: GoogleFonts.inter(fontSize: 12),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Obx(() => TextFormField(
                    obscureText: !profileC.isPasswordVisible.value,
                    controller: profileC.cpw,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      suffixIcon: IconButton(
                        onPressed: () {
                          profileC.togglePasswordVisibility();
                        },
                        icon: Icon(
                          profileC.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 180,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffF8C800),
                      shape: StadiumBorder()),
                  child: Text(
                    'Buat Akun',
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.black),
                  ),
                  onPressed: () async {
                    profileC.signUp();
                  }),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Sudah mempunyai akun?',
              style: GoogleFonts.inter(),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 120,
              height: 30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5EE8D1),
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  'Login',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                onPressed: () async {
                  Get.toNamed('/profile');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => ProfileView(),
                  //     ));
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
    );
  }
}
