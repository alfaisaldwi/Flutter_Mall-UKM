import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/model/csi/question.dart';

import '../controllers/survey_page_controller.dart';

class SurveyPageView extends GetView<SurveyPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survei'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.questions.length,
                      itemBuilder: (context, index) {
                        var question = controller.questions[index];
                        return buildQuestionCard(question, index);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      maxLines: 5,
                      decoration: InputDecoration(labelText: 'Saran'),
                      onChanged: (value) {
                        controller.setSuggestion(value);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      controller.sendSurvey();
                    },
                    child: Text('Kirim Survey'),
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildQuestionCard(Map<String, dynamic> question, int questionIndex) {
    var number = questionIndex + 1;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${number}. ${question['title']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kinerja'),
                Obx(() => Row(
                      children: List.generate(
                        5,
                        (index) => Radio(
                          value: index + 1,
                          groupValue: controller.kinerjaValues[questionIndex],
                          onChanged: (value) {
                            controller.setKinerja(questionIndex, value!);
                          },
                        ),
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kepentingan'),
                Obx(() => Row(
                      children: List.generate(
                        5,
                        (index) => Radio(
                          value: index + 1,
                          
                          groupValue:
                              controller.kepentinganValues[questionIndex],
                          onChanged: (value) {
                            controller.setKepentingan(questionIndex, value!);
                          },
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
