import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/model/csi/question.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/survey_page_controller.dart';

class SurveyPageView extends GetView<SurveyPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Survey Kepuasan Pelanggan',
          style: Styles.headerStyles(weight: FontWeight.w500, size: 16),
        ),
        backgroundColor: Colors.white,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: const [
                              Text(
                                'Penilaian akan dibagi menjadi 2 section yaitu Kinerja dan Kepentingan. ',
                                style: TextStyle(fontSize: 16),
                              ),
                              Divider(),
                              Text(
                                '1. Penilaian Kinerja : melibatkan evaluasi seberapa baik Mall UKM Kota Cirebon memenuhi harapan pelanggan dalam berbagai aspek, seperti kecepatan pelayanan dan kualitas produk.',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.justify,
                              ),
                              Divider(),
                              Text(
                                  '2.Penilaian Kepentingan : adalah elemen-elemen spesifik yang dianggap penting oleh pelanggan, seperti ketersediaan produk dan harga yang bersaing.',
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.justify),
                              Divider(),
                              Text(
                                  'Keterangan : 5 = Sangat Puas 4 = Puas 3 = Cukup 2 = Kurang Puas 1 = Tidak Puas'),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: controller.questions.length,
                      itemBuilder: (context, index) {
                        var question = controller.questions[index];
                        return buildQuestionCard(question, index);
                      },
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        maxLines: 3,
                        decoration: InputDecoration(labelText: 'Saran'),
                        onChanged: (value) {
                          controller.setSuggestion(value);
                        },
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: GestureDetector(
                        onTap: () {
                          controller.sendSurvey();
                        },
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: const Color(0xff198754),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Text('Kirim Survey',
                                  style: Styles.bodyStyle(
                                      color: Colors.white, size: 14)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                        (index) => Column(
                          children: [
                            Radio(
                              value: index + 1,
                              groupValue:
                                  controller.kinerjaValues[questionIndex],
                              onChanged: (value) {
                                controller.setKinerja(questionIndex, value!);
                              },
                            ),
                            Text('${index + 1}'),
                          ],
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
                        (index) => Column(
                          children: [
                            Radio(
                              value: index + 1,
                              groupValue:
                                  controller.kepentinganValues[questionIndex],
                              onChanged: (value) {
                                controller.setKepentingan(
                                    questionIndex, value!);
                              },
                            ),
                            Text('${index + 1}'),
                          ],
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
