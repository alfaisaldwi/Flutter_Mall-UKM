import 'dart:convert';

import 'package:get/get.dart';
import 'package:mall_ukm/app/model/profile_company/profile_company.dart';
import 'package:http/http.dart' as http;
import 'package:mall_ukm/app/service/api_service.dart';

class ProfileCompanyController extends GetxController {
  var profileCompany = ProfileCompany().obs;

  Future<void> fetchProfileCompany() async {
    try {
      var headers = {
        'Accept': 'application/json',
      };

      var url = Uri.parse(
        ApiEndPoints.baseUrl + ApiEndPoints.profileCompany.index,
      );
      http.Response response = await http.get(url, headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        profileCompany.value = ProfileCompany.fromJson(responseData['data']);
        print(profileCompany.value.id);
      } else {
        throw Exception('Failed to load profile company');
      }
    } catch (e) {
      throw Exception('Failed to fetch profile company: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
