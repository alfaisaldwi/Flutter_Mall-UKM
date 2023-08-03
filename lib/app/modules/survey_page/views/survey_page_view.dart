import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/model/csi/question.dart';

import '../controllers/survey_page_controller.dart';

class SurveyPageView extends GetView<SurveyPageController> {
  @override
  Widget build(BuildContext context) {
    var kepentingan = 0.obs;
    var kinerja = 0.obs;
    var jawabanKepentinganList = <int>[].obs;
    var jawabanKinerjaList = <int>[].obs;
    return Scaffold(
      appBar: AppBar(
        title: Text('SurveyPageView'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: controller.pertanyaanList.length,
                      itemBuilder: (context, index) {
                        var pertanyaan = controller.pertanyaanList[index];
                        var number = pertanyaan['id'].toString();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                pertanyaan['title'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('Kepentingan'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (int i = 1; i <= 5; i++)
                                  Row(
                                    children: [
                                      Obx(() => Radio<int>(
                                            value: i,
                                            groupValue:
                                                controller.selectedAnswers[
                                                    'kepentingan']!,
                                            onChanged: (int? value) {
                                              controller.selectedAnswers[
                                                  'kepentingan'] = value!;
                                            },
                                          )),
                                      Text('$i'),
                                    ],
                                  ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text('Kinerja'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (int i = 1; i <= 5; i++)
                                  Row(
                                    children: [
                                      Radio<int>(
                                        value: i,
                                        groupValue: controller
                                            .selectedAnswers['kinerja$number']!,
                                        onChanged: (int? value) {
                                          controller.selectedAnswers[
                                              'kinerja$number'] = value!;
                                        },
                                      ),
                                      Text('$i'),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    buildSaranField(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget buildQuestionCard(Question question) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildSaranField() {
    return TextFormField(
      onChanged: (value) {},
      maxLines: 5,
      decoration: InputDecoration(
        labelText: 'Saran',
        border: OutlineInputBorder(),
      ),
    );
  }
}
