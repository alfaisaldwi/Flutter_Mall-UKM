import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/model/address/address_model.dart';
import 'package:mall_ukm/app/modules/address/views/address_dialog.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  final AddressController address = Get.put(AddressController());
  final RxString selectedProvinceName = ''.obs;
  final RxString selectedCityName = ''.obs;
  final RxString selectedDistrictName = ''.obs;
  final RxString selectedSubdistrictId = ''.obs;
  final RxString addressName = ''.obs;
  var provinceName = ''.obs;
  var cityName = ''.obs;
  var districtName = ''.obs;

  @override
  Widget build(BuildContext context) {
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
              decoration: InputDecoration(labelText: 'Nama Penerima'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: address.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'No. HP'),
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                // Tampilkan popup untuk memilih kecamatan, kota, dan provinsi
                Get.dialog(AddressSelectionDialog(
                  cityName: selectedCityName,
                  districtName: selectedDistrictName,
                  provinceName: selectedProvinceName,
                  districtController: address.districtController,
                  cityController: address.cityController,
                  provinceController: address.provinceController,
                ));
              },
              child: IgnorePointer(
                child: TextField(
                  controller: address.addressController,
                  decoration: InputDecoration(labelText: 'Alamat'),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: controller.addressDetail,
              decoration: InputDecoration(labelText: 'Alamat Lengkap'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Tambah Alamat'),
              onPressed: () async {
                var idKecamatan =
                    int.parse(address.selectedSubdistrictId.value);
                print(idKecamatan);
                print(
                  address.selectedSubdistrictId.value,
                );
                Address addressItem = Address(
                    username: address.nameController.text,
                    phone: address.phoneController.text,
                    address: address.addressName.value,
                    addressDetail: address.addressDetail.text,
                    destinationId:
                        int.parse(address.selectedSubdistrictId.value),
                    status: 'unselected');

                await address.addAdress(addressItem);
              },
            ),
          ],
        ),
      ),
    );
  }
}
