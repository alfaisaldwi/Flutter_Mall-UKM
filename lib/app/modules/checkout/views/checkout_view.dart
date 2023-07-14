import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  final List<String> addresses = ['Alamat 1', 'Alamat 2', 'Alamat 3'];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final RxString selectedAddress = ''.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Checkoout',
          style: Styles.headerStyles(weight: FontWeight.w500, size: 16),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, bottom: 1),
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.deepOrange[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Alamat Pengiriman',
                                    style: Styles.bodyStyle(size: 14),
                                  ),
                                  Text(
                                    'Ubah Alamat',
                                    style: Styles.bodyStyle(
                                        color: Colors.blue[700]),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 2),
                              child: Text(
                                'Alexx X nya 2 | 089640091779',
                                style: Styles.bodyStyle(size: 14),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, top: 2, bottom: 2),
                              child: Text(
                                'Jalan Krajan Nomor 25 Dusun Krajan, Desa Kalitengah, Kecamatan Purwonegoro Kabupaten Banjarnegara, Jawa Tengah  Jawa Tengah Jawa Tengah 53472',
                                textAlign: TextAlign.left,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.bodyStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: const Color(0xfff2f2f2),
                height: 120,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(children: [
                  Image.network(
                    'https://rimbakita.com/wp-content/uploads/2020/10/gambar-kartun-patrick.jpg',
                    width: 100,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 0.0, bottom: 4.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Patrik Patrik Patrik Patrik Patrik Patrik Patrik Patrik',
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.bodyStyle(size: 14),
                                ),
                                Text(
                                  'Varian : 1',
                                  textAlign: TextAlign.left,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Styles.bodyStyle(size: 14),
                                ),
                                Text(
                                  'Rp300.000',
                                  style: Styles.bodyStyle(size: 14),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'x2',
                                style:
                                    Styles.bodyStyle(color: Colors.grey[600]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
              Text(
                'Pesan',
                style: Styles.bodyStyle(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika untuk menangani klik tombol "Pesan Sekarang"
                  // Misalnya, validasi data dan pemrosesan pesanan
                  String name = nameController.text;
                  String phone = phoneController.text;
                  String address = selectedAddress.value;

                  // Lakukan sesuatu dengan data ini, seperti pemrosesan pesanan

                  // Contoh: Tampilkan data penerima, nomor handphone, dan alamat yang dipilih
                  print('Nama Penerima: $name');
                  print('Nomor Handphone: $phone');
                  print('Alamat: $address');
                },
                child: Text('Pesan Sekarang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
