import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_ukm/app/modules/profile/controllers/profile_controller.dart';
import 'package:mall_ukm/app/modules/profile/views/signup_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SigninView extends GetView<ProfileController> {
  var ctrLogin = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 85, left: 40, right: 50, bottom: 20),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 80),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Halo.',
                    style: GoogleFonts.inter(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff034779),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Silahkan login jika anda sudah memiliki akun',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 23,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: ctrLogin.cemail,
              decoration: InputDecoration(
                hintText: 'Email',
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Obx(() => TextFormField(
                  obscureText: !controller.isPasswordVisible.value,
                  controller: ctrLogin.cpw,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    focusColor: Colors.white,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.togglePasswordVisibility();
                      },
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
                onTap: () async {
                  // var wa = profileCompany.profileCompany.value.phone;
                  try {
                    final Uri _url = Uri.parse(
                        'https://wa.me/6283823065878?text=Haloo Admin Mall UKM Kota Cirebon, Saya mengalami lupa password pada akun saya, Tolong bantu saya.');
                    await launchUrl(_url, mode: LaunchMode.externalApplication);
                  } catch (err) {
                    debugPrint('Something bad happened');
                  }
                },
                child: Text(
                  'Lupa pasword? Hubungi admin',
                  style: TextStyle(color: Colors.blue.shade900, fontSize: 12),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 180,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff5EE8D1),
                shape: StadiumBorder(),
              ),
              child: Text(
                'Login',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                await ctrLogin.loginWithEmail();
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Belum mempunyai akun?',
            style: GoogleFonts.inter(),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 100,
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffF8C800),
                shape: const StadiumBorder(),
              ),
              child: Text(
                'Buat akun',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
              onPressed: () async {
                Get.toNamed('signup');
              },
            ),
          ),
          const SizedBox(
            height: 160,
          ),
        ],
      ),
    );
  }
}
