import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/model/csi/question.dart';
import 'package:http/http.dart' as http;
import 'package:mall_ukm/app/service/api_service.dart';

class SurveyPageController extends GetxController {
  var isLoading = true.obs;
  var suggestions = ''.obs;
  var answers = [].obs;
  var questions = [].obs;

  var kinerjaValues = <int, int>{}.obs;
  var kepentinganValues = <int, int>{}.obs;

  var suggestion = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  void fetchQuestions() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.csi.question);
      http.Response response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        questions.assignAll(data['data']);
      }
    } catch (e) {
      print('Error fetching questions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setKinerja(int questionIndex, int value) {
    kinerjaValues[questionIndex] = value;
  }

  void setKepentingan(int questionIndex, int value) {
    kepentinganValues[questionIndex] = value;
  }

  void setSuggestion(String value) {
    suggestion.value = value;
  }

  void sendSurvey() async {
    if (!_areAllFieldsFilled()) {
      Fluttertoast.showToast(
        msg: 'Harap isi semua field sebelum mengirim survei!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var answers = <Map<String, dynamic>>[];
    for (var i = 0; i < questions.length; i++) {
      var question = questions[i];
      var answer = {
        'number': i + 1,
        'title': question['title'],
        'mis': kepentinganValues[i] ?? 0,
        'mss': kinerjaValues[i] ?? 0,
      };
      answers.add(answer);
    }

    var data = {
      'suggestion': suggestion.value,
      'answers': answers,
    };
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.csi.store);
      http.Response response = await http.post(
        url,
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Terima kasih telah mengisi survey',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey[800],
          textColor: Colors.white,
          fontSize: 14.0,
        );

        Get.offAndToNamed('/navbar-page');
      } else {
        print('Gagal mengirim survey: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error sending survey: $e');
    }
  }

  bool _areAllFieldsFilled() {
    for (var i = 0; i < questions.length; i++) {
      if (kinerjaValues[i] == null || kepentinganValues[i] == null) {
        return false;
      }
    }
    return suggestion.value.trim().isNotEmpty;
  }
}
