import 'package:get/get.dart';

class PaymentController extends GetxController {
  //TODO: Implement PaymentController

  var selectedPaymentMethod = ''.obs;

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
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
  void onClose() {
    super.onClose();
  }
}
