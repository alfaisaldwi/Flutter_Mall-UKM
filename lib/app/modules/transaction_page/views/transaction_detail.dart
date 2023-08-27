// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/transaction/transaction_show.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:url_launcher/url_launcher.dart';

class TransactionDetailView extends GetView<TransactionPageController> {
  @override
  Widget build(BuildContext context) {
    var trsDetail = Get.arguments as TransactionShow;
    var status = ''.obs;
    if (trsDetail.status == 'paid') {
      status.value = 'Sudah Bayar';
    } else if (trsDetail.status == 'unpaid') {
      status.value = 'Belum Bayar';
    } else if (trsDetail.status == 'sending') {
      status.value = 'Sedang Dikirim';
    } else if (trsDetail.status == 'delivered') {
      status.value = 'Selesai';
    } else {
      status.value = 'Dibatalkan';
    }

    controller.startCountdown(trsDetail.createdAt!);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
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
                      Row(
                        children: [
                          Text(
                            trsDetail.orderId!,
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: trsDetail.orderId));
                              Fluttertoast.showToast(
                                msg: 'Disalin',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey[800],
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.copy,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
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
                            status.toUpperCase(),
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
                      if (trsDetail.status == 'sending' &&
                          trsDetail.statusPayment == 'online')
                        Column(
                          children: [
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Nomor Resi:'),
                                Row(
                                  children: [
                                    Text(
                                      trsDetail.receiptNumber != null
                                          ? '${trsDetail.receiptNumber}'
                                          : 'Belum Dikirim',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: trsDetail.receiptNumber));
                                        Fluttertoast.showToast(
                                          msg: 'Disalin',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.grey[800],
                                          textColor: Colors.white,
                                          fontSize: 14.0,
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Icon(
                                          Icons.copy,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ],
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
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Image.network(detail!.productPhoto,
                            width: 80, height: 70),
                        title:
                            Text('${detail.productName} - *${detail.qty}pcs'),
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
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
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
                    Get.defaultDialog(
                      title: "Yakin ingin mengubah status pemesanan?",
                      titleStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                        ],
                      ),
                      confirm: ElevatedButton(
                        onPressed: () async {
                          Get.back();
                          await controller.updateStatus(
                              trsDetail.id!, "delivered");
                          print("Status pemesanan berubah");
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text("Ya"),
                      ),
                      cancel: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        child: Text("Tidak"),
                      ),
                    );
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
                        child: Text('Terima pesanan',
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
                        border: Border.all(
                          color: const Color(0xff198754),
                        ),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text('Pembayaran telah dikonfirmasi',
                              style: Styles.bodyStyle(
                                  color: Color(0xff198754), size: 14)),
                        ),
                      ),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () async {
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "",
                          desc: "Yakin ingin membatalkan pesanan?",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Tidak",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Colors.grey,
                            ),
                            DialogButton(
                              child: Text(
                                "Ya",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                Get.back();
                                await controller.updateStatus(
                                    trsDetail.id!, "canceled");
                              },
                              color: Color.fromRGBO(0, 179, 134, 1.0),
                            )
                          ],
                        ).show();
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text('Batalkan  Pesanan ?',
                                style: Styles.bodyStyle(
                                    color: Colors.red, size: 14)),
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
                    border: Border.all(
                      color: const Color(0xff198754),
                    ),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text('Sedang dikirim ke alamat',
                          style: Styles.bodyStyle(
                              color: Color(0xff198754), size: 14)),
                    ),
                  ),
                ),
              if (trsDetail.status == 'delivered')
                Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff198754),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text('Pesanan Sudah diterima',
                          style: Styles.bodyStyle(
                              color: Color(0xff198754), size: 14)),
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
                        border: Border.all(
                            color: const Color(0xffBB2124), width: 1),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text('Pesanan telah dibatalkan',
                              style: Styles.bodyStyle(
                                  color: Color(0xffBB2124), size: 14)),
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
                          color: Color.fromARGB(255, 13, 139, 43),
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
