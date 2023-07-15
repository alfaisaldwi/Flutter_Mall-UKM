import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/address/controllers/address_controller.dart';

class AddressSelectionDialog extends StatelessWidget {
  final TextEditingController districtController;
  final TextEditingController cityController;
  final TextEditingController provinceController;

  final RxString provinceName;
  final RxString cityName;
  final RxString districtName;

  AddressSelectionDialog({
    required this.districtController,
    required this.cityController,
    required this.provinceController,
    required this.provinceName,
    required this.cityName,
    required this.districtName,
  });
  final AddressController address = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => DropdownButtonFormField<String>(
                value: address.provinces.isNotEmpty
                    ? address.provinces[0]['province_id']
                    : null,
                decoration: InputDecoration(labelText: 'Provinsi'),
                onChanged: (value) {
                  provinceController.text = value!;
                  address.selectedProvinceName.value = value!;
                  provinceName.value = address.provinces.firstWhere(
                          (province) =>
                              province['province_id'] == value)['province']
                      as String;
                  address.addressName.value =
                      '${provinceName.value}, ${cityName.value}, ${districtName.value}';
                  Get.find<AddressController>().fetchCities(value!);
                },
                items: address.provinces.map((province) {
                  return DropdownMenuItem<String>(
                    value: province['province_id'] as String,
                    child: Text(province['province'] as String),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            Obx(
              () => DropdownButtonFormField<String>(
                value:
                    cityController.text.isNotEmpty ? cityController.text : null,
                decoration: InputDecoration(labelText: 'Kota'),
                onChanged: (value) {
                  cityController.text = value!;
                  cityName.value =
                      '${address.cities.firstWhere((city) => city['city_id'] == value)['type']} ${address.cities.firstWhere((city) => city['city_id'] == value)['city_name']}'
                          as String;

                  address.addressName.value =
                      '${provinceName.value}, ${cityName.value}, ${districtName.value}';
                  Get.find<AddressController>().fetchSubdistricts(value);
                },
                items: address.cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city['city_id']
                        as String, // Menggunakan city_id sebagai nilai unik
                    child: Text(city['city_name'] as String),
                  );
                }).toList(),
              ),
            ),
            Obx(
              () => DropdownButtonFormField<String>(
                value: districtController.text.isNotEmpty
                    ? districtController.text
                    : null,
                decoration: InputDecoration(labelText: 'Kecamatan'),
                onChanged: (value) {
                  districtController.text = value!;
                  districtName.value = address.districts.firstWhere(
                          (district) => district['subdistrict_id'] == value)[
                      'subdistrict_name'] as String;
                  address.addressName.value =
                      '${provinceName.value}, ${cityName.value}, ${districtName.value}';
                  address.selectedSubdistrictId.value = value!;
                },
                items: address.districts.map((district) {
                  return DropdownMenuItem<String>(
                    value: district['subdistrict_id'] as String,
                    child: Text(district['subdistrict_name'] as String),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () {
                print(
                    ' haisl ==== ${address.selectedProvinceName.value} , ${address.selectedCityName.value}, ${address.selectedDistrictName.value}, id kecamatan ${address.selectedSubdistrictId.value}');
                print(
                    ' haisl ==== ${address.addressName.value}, ${address.selectedSubdistrictId}');

                Get.back(); // Tutup dialog
              },
            ),
          ],
        ),
      ),
    );
  }
}
