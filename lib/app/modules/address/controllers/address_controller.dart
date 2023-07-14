import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  RxList<String> addressList = <String>[].obs;
 final TextEditingController addressController = TextEditingController();
  void addAddress(String address) {
    addressList.add(address);
  }

  // Method untuk menghapus alamat dari daftar berdasarkan indeks
  void removeAddress(int index) {
    addressList.removeAt(index);
  }

  final count = 0.obs;
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
  void increment() => count.value++;
}
