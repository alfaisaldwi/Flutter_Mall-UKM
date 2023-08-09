import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/model/address/address_model.dart';
import 'package:mall_ukm/app/modules/address/views/address_dialog.dart';
import 'package:mall_ukm/app/modules/checkout/controllers/checkout_offline_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  final AddressController address = Get.put(AddressController());

  var provinceName = ''.obs;
  var cityName = ''.obs;
  var districtName = ''.obs;

  @override
  Widget build(BuildContext context) {
    var checkoutO = Get.put(CheckoutOfflineController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Alamat',
          style: Styles.headerStyles(weight: FontWeight.w500, size: 16),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: address.nameController,
              decoration: const InputDecoration(labelText: 'Nama Penerima'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: address.phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'No. HP'),
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                // Tampilkan popup untuk memilih kecamatan, kota, dan provinsi
                Get.dialog(AddressSelectionDialog());
              },
              child: IgnorePointer(
                child: Align(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Alamat')),
                      Obx(() => TextField(
                            controller: address.addressController,
                            decoration: InputDecoration(
                                labelText: address.addressName.value),
                          )),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: controller.addressDetail,
              decoration: InputDecoration(labelText: 'Alamat Lengkap'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Tambah Alamat'),
              onPressed: () async {
                if (address.nameController.text.isEmpty ||
                    address.phoneController.text.isEmpty ||
                    address.addressName.value.isEmpty ||
                    address.selectedSubdistrictId.value == '') {
                  Fluttertoast.showToast(
                    msg: 'Mohon isi semua field ',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.grey[800],
                    textColor: Colors.white,
                    fontSize: 14.0,
                  );
                } else {
                  var idKecamatan =
                      int.parse(address.selectedSubdistrictId.value);
                  Address addressItem = Address(
                      username: address.nameController.text,
                      phone: address.phoneController.text,
                      address: address.addressName.value,
                      addressDetail: address.addressDetail.text,
                      destinationId:
                          int.parse(address.selectedSubdistrictId.value),
                      status: 'unselected');

                  checkoutO.refreshAddress();
                  await address.addAdress(addressItem);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
