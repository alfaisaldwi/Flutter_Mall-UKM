import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/address/controllers/address_controller.dart';

class AddressSelectionDialog extends StatelessWidget {
  final AddressController address = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => DropdownButtonFormField<String>(
                style: TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
                value: address.provinces.isNotEmpty
                    ? address.provinces[0]['province_id']
                    : null,
                decoration: InputDecoration(
                  labelText: 'Provinsi',
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                onChanged: (value) {
                  address.cityId.value = '';
                  address.districtId.value = '';

                  address.provinceId.value = value!;

                  address.selectedProvinceName.value = address.provinces
                          .firstWhere((province) =>
                              province['province_id'] == value)['province']
                      as String;
                  address.addressName.value =
                      '${address.selectedProvinceName.value}, ${address.selectedCityName.value}, ${address.selectedDistrictName.value}';
                  Get.find<AddressController>().fetchCities(value);
                },
                items: address.provinces.map((province) {
                  return DropdownMenuItem<String>(
                    value: province['province_id'] as String,
                    child: Text(province['province'] as String),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10.0),
            Obx(
              () => DropdownButtonFormField<String>(
                value: address.cityId.value.isNotEmpty
                    ? address.cityId.value
                    : null,
                decoration: InputDecoration(
                  labelText: 'Kota',
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                onChanged: (value) {
                  address.districtId.value = '';
                  address.cityId.value = value!;
                  address.selectedCityName.value =
                      '${address.cities.firstWhere((city) => city['city_id'] == value)['type']} ${address.cities.firstWhere((city) => city['city_id'] == value)['city_name']}'
                          as String;
                  address.addressName.value =
                      '${address.selectedProvinceName.value}, ${address.selectedCityName.value}, ${address.selectedDistrictName.value}';
                  Get.find<AddressController>().fetchSubdistricts(value);
                },
                items: address.cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city['city_id']
                        as String, // Menggunakan city_id sebagai nilai unik
                    child: Row(
                      children: [
                        Text(city['type'] as String),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(city['city_name'] as String),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => DropdownButtonFormField<String>(
                value: address.districtId.value.isNotEmpty
                    ? address.districtId.value
                    : null,
                decoration: InputDecoration(
                  labelText: 'Kecamatan',
                  labelStyle: TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                onChanged: (value) {
                  address.districtId.value = value!;

                  address.selectedDistrictName.value = address.districts
                      .firstWhere((district) =>
                          district['subdistrict_id'] ==
                          value)['subdistrict_name'] as String;
                  address.addressName.value =
                      '${address.selectedProvinceName.value}, ${address.selectedCityName.value}, ${address.selectedDistrictName.value}';
                  address.selectedSubdistrictId.value = value;
                },
                items: address.districts.map((district) {
                  return DropdownMenuItem<String>(
                    value: district['subdistrict_id'] as String,
                    child: Text(district['subdistrict_name'] as String),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Warna latar belakang tombol
                onPrimary: Colors.white, // Warna teks tombol saat ditekan
              ),
              child: Text('Simpan Alamat'),
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
