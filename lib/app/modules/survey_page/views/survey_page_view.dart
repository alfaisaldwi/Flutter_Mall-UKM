import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/survey_page_controller.dart';

class SurveyPageView extends GetView<SurveyPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SurveyPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SurveyPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
