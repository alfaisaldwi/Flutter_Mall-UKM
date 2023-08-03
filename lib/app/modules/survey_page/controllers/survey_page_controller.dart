import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/model/csi/question.dart';
import 'package:http/http.dart' as http;
import 'package:mall_ukm/app/service/api_service.dart';

class SurveyPageController extends GetxController {
  var questions = <Question>[].obs;
  var isLoading = true.obs;
  var pertanyaanList = [].obs;
  var selectedAnswers = <String, int>{};
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
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        pertanyaanList.value = data['data'];
        selectedAnswers.clear();
        for (var pertanyaan in pertanyaanList) {
          var number = pertanyaan['id'].toString();
          selectedAnswers['kepentingan$number'] = 0;
          selectedAnswers['kinerja$number'] = 0;
        }
      }
    } catch (e) {
      print('Error fetching questions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void submitAnswers() async {
    String? token = GetStorage().read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.csi.store);
      var body = json.encode({
        "suggestion": suggestion.value,
        "answers": selectedAnswers,
      });

      http.Response response =
          await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Jawaban berhasil dikirim ke API');
        // Tambahkan logika lain yang diperlukan setelah pengiriman berhasil
        // Misalnya, menampilkan notifikasi atau pindah ke halaman lain.
      } else {
        print('Gagal mengirim jawaban ke API');
        // Tambahkan logika lain untuk menangani kegagalan
      }
    } catch (e) {
      print('Error submitting answers: $e');
    }
  }
}
