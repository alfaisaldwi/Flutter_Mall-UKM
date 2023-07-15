import 'package:get/get.dart';
import 'package:mall_ukm/app/model/cart/kurir_model.dart';

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController

  Rx<Kurir> selectedKurir = Rx<Kurir>(Kurir('', ''));

  final List<String> namaKurir = ['JNE', 'J&T', 'TIKI', 'POS Indonesia'];
  final RxString kurirTerpilih = ''.obs;
  void selectKurir(Kurir kurir) {
    selectedKurir.value = kurir;
  }

  @override
  void onInit() {
    kurirTerpilih.value = namaKurir[0];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
