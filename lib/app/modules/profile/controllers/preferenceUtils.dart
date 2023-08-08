// import 'package:get/get.dart';
// import 'package:get/get_rx/get_rx.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PreferenceUtils extends GetxController {
//   static RxString token = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     getToken();
//   }

//   static Future<SharedPreferences> getPrefsInstance() async {
//     return SharedPreferences.getInstance();
//   }

//   static Future<void> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     token.value = prefs.getString('token') ?? '';
//   }

//   static Future<void> setToken(String token) async {
//     final prefs = await getPrefsInstance();
//     await prefs.setString('token', token);
//   }

//   static Future<void> removeToken() async {
//     final prefs = await getPrefsInstance();
//     await prefs.remove('token');
//   }
// }
