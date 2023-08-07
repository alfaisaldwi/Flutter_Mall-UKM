// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/transaction/transaction_show.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

class TransactionDetailView extends GetView<TransactionPageController> {
  @override
  Widget build(BuildContext context) {
    var trsDetail = Get.arguments as TransactionShow;
    controller.startCountdown(trsDetail.createdAt!);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Column(
          children: [
            Text(
              'Detail Transaksi',
              style: Styles.headerStyles(weight: FontWeight.w400, size: 16),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nomor Transaksi :',
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        trsDetail.orderId!,
                        softWrap: true,
                        maxLines: 2,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Detail Transaksi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Nama Pembeli:'),
                          Text(
                            ' ${trsDetail.userUsernameSender}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:'),
                          Text(
                            ' ${controller.convertToIdr(int.parse(trsDetail.total!), 2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      if (trsDetail.statusPayment == 'online')
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.local_shipping),
                                Text(trsDetail.courier!.toUpperCase()),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Ongkos Kirim:'),
                                Text(
                                  ' ${controller.convertToIdr(int.parse(trsDetail.costCourier!), 2)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Status:'),
                          Text(
                            trsDetail.status!.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: trsDetail.status == 'paid' ||
                                      trsDetail.status == 'delivered' ||
                                      trsDetail.status == 'sending'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      if (trsDetail.status == 'paid' &&
                          trsDetail.statusPayment == 'online')
                        Column(
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Nomor Resi:'),
                                Text(
                                  trsDetail.receiptNumber != null
                                      ? '${trsDetail.receiptNumber}'
                                      : 'Belum Dikirim',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (trsDetail.status == 'unpaid')
                        Column(
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sisa waktu pembayaran:'),
                                Obx(() => Text(
                                      controller.remainingTime.value,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Jenis Pembayaran :'),
                          Text(
                            trsDetail.statusPayment!.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Detail Produk:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: trsDetail.detailTransaction?.length,
                itemBuilder: (context, index) {
                  var detail = trsDetail.detailTransaction?[index];
                  return Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(detail!.productPhoto,
                            width: 80, height: 70),
                        title: Text('${detail.productName} - *${detail.qty}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              'Varian: ${detail.variant}',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Harga:  ${controller.convertToIdr(int.parse(detail.price), 2)}',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Total:  ${controller.convertToIdr(int.parse(detail.subtotal), 2)}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              if (trsDetail.statusPayment == 'online')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat Pengiriman:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(
                                  'Nama Penerima: ${trsDetail.addressUsername}'),
                              subtitle: Text(
                                  'Nomor Telepon: ${trsDetail.addressPhone}'),
                            ),
                            SizedBox(height: 8),
                            ListTile(
                              leading: Icon(Icons.location_on),
                              title:
                                  Text('Alamat: ${trsDetail.addressInAddress}'),
                              subtitle: Text(
                                  'Detail Alamat: ${trsDetail.addressAddressDetail}'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 16),
              if (trsDetail.status == 'paid' &&
                  trsDetail.statusPayment == 'offline')
                GestureDetector(
                  onTap: () async {
                    await controller.updateStatus(trsDetail.id!, "delivered");
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: const Color(0xff198754),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text('Sudah dibayar',
                            style: Styles.bodyStyle(
                                color: Colors.white, size: 14)),
                      ),
                    ),
                  ),
                ),
              if (trsDetail.status == 'paid' &&
                  trsDetail.statusPayment == 'online')
                Column(
                  children: [
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: const Color(0xff198754),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text('Sudah dibayar',
                              style: Styles.bodyStyle(
                                  color: Colors.white, size: 14)),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await controller.updateStatus(
                            trsDetail.id!, "canceled");
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Color.fromARGB(255, 247, 255, 15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text('Batalkan  Pesanan ?',
                                style: Styles.bodyStyle(
                                    color: Colors.black, size: 14)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (trsDetail.status == 'unpaid')
                GestureDetector(
                  onTap: () {
                    controller.bayar(trsDetail.paymentUrl!);
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: const Color(0xff034779),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text('Bayar',
                            style: Styles.bodyStyle(
                                color: Colors.white, size: 14)),
                      ),
                    ),
                  ),
                ),
              if (trsDetail.status == 'sending')
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: const Color(0xff034779),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text('Sedang dikirim ke alamat',
                          style:
                              Styles.bodyStyle(color: Colors.white, size: 14)),
                    ),
                  ),
                ),
              if (trsDetail.status == 'delivered')
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11),
                    color: const Color(0xff034779),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text('Pesanan Selesai',
                          style:
                              Styles.bodyStyle(color: Colors.white, size: 14)),
                    ),
                  ),
                ),
              if (trsDetail.status == 'canceled')
                Column(
                  children: [
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: const Color(0xffBB2124),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text('Pesanan dibatalkan',
                              style: Styles.bodyStyle(
                                  color: Colors.white, size: 14)),
                        ),
                      ),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () async {
                        try {
                          final Uri _url = Uri.parse(
                              'https://wa.me/6283823065878?text=Haloo Admin Mall UKM Kota Cirebon, Saya ingin bertanya sesuatu nih.');
                          await launchUrl(_url,
                              mode: LaunchMode.externalApplication);
                        } catch (err) {
                          debugPrint('Something bad happened');
                        }
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Color.fromARGB(255, 43, 250, 91),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text('Hubungi Admin',
                                style: Styles.bodyStyle(
                                    color: Colors.white, size: 14)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
