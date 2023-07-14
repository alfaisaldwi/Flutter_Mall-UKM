import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/address/views/address_dialog.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();

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
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama Penerima'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: 'No. HP'),
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                // Tampilkan popup untuk memilih kecamatan, kota, dan provinsi
                Get.dialog(AddressSelectionDialog(
                  districtController: districtController,
                  cityController: cityController,
                  provinceController: provinceController,
                ));
              },
              child: IgnorePointer(
                child: TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Alamat'),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Alamat Lengkap'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Tambah Alamat'),
              onPressed: () {
                // Lakukan sesuatu saat tombol tambah alamat ditekan
              },
            ),
          ],
        ),
      ),
    );
  }
}
