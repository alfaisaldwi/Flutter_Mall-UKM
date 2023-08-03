import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/model/csi/question.dart';
import 'package:http/http.dart' as http;
import 'package:mall_ukm/app/service/api_service.dart';

class SurveyPageController extends GetxController {
  // var questions = <Question>[].obs;
  var isLoading = true.obs;
  // var pertanyaanList = [].obs;
  // var selectedAnswers = <String, int>{};
  // var suggestion = ''.obs;

  var suggestions = ''.obs;
  var answers = [].obs;
  var questions = [].obs;

  // Variabel untuk menyimpan nilai kinerja dan kepentingan dari setiap pertanyaan
  var kinerjaValues = <int, int>{}.obs;
  var kepentinganValues = <int, int>{}.obs;

  // Variabel untuk menyimpan saran dari pengguna
  var suggestion = ''.obs;
  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  // void fetchQuestions() async {
  //   String? token = GetStorage().read('token');
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };

  //   try {
  //     var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.csi.question);
  //     http.Response response = await http.get(url, headers: headers);
  //     print(response.statusCode);
  //     print(response.body);

  //     if (response.statusCode == 200) {
  //       var data = json.decode(response.body);
  //       pertanyaanList.value = data['data'];
  //       selectedAnswers.clear();
  //       for (var pertanyaan in pertanyaanList) {
  //         var number = pertanyaan['id'].toString();
  //         selectedAnswers['kepentingan$number'] = 0;
  //         selectedAnswers['kinerja$number'] = 0;
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching questions: $e');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
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
        'mis': kinerjaValues[i] ?? 0,
        'mss': kepentinganValues[i] ?? 0,
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
        print('Survey berhasil dikirim!');
      } else {
        print('Gagal mengirim survey: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error sending survey: $e');
    }
  }

  // void submitAnswers() async {
  //   String? token = GetStorage().read('token');
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   };

  //   try {
  //     var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.csi.store);
  //     var body = json.encode({
  //       "suggestion": suggestion.value,
  //       "answers": selectedAnswers,
  //     });

  //     http.Response response =
  //         await http.post(url, headers: headers, body: body);
  //     if (response.statusCode == 200) {
  //       print('Jawaban berhasil dikirim ke API');
  //       // Tambahkan logika lain yang diperlukan setelah pengiriman berhasil
  //       // Misalnya, menampilkan notifikasi atau pindah ke halaman lain.
  //     } else {
  //       print('Gagal mengirim jawaban ke API');
  //       // Tambahkan logika lain untuk menangani kegagalan
  //     }
  //   } catch (e) {
  //     print('Error submitting answers: $e');
  //   }
  // }
}
