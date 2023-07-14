import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressSelectionDialog extends StatelessWidget {
  final TextEditingController districtController;
  final TextEditingController cityController;
  final TextEditingController provinceController;

  AddressSelectionDialog({
    required this.districtController,
    required this.cityController,
    required this.provinceController,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: districtController,
              decoration: InputDecoration(labelText: 'Kecamatan'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: cityController,
              decoration: InputDecoration(labelText: 'Kota'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: provinceController,
              decoration: InputDecoration(labelText: 'Provinsi'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () {
                Get.back(); // Tutup dialog
              },
            ),
          ],
        ),
      ),
    );
  }
}
