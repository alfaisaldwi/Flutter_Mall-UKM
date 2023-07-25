import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/model/transaction/transaction_show.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';

class TransactionDetailView extends GetView<TransactionPageController> {
  @override
  Widget build(BuildContext context) {
    var trsDetail = Get.arguments as TransactionShow;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            'Detail Transaksi',
            style: Styles.headerStyles(weight: FontWeight.w400, size: 16),
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID Transaksi: ${trsDetail.id}'),
                        SizedBox(height: 8),
                        Text('Total: ${trsDetail.total}'),
                        SizedBox(height: 8),
                        Text('Courier: ${trsDetail.courier}'),
                        SizedBox(height: 8),
                        Text('Cost Courier: ${trsDetail.costCourier}'),
                        SizedBox(height: 8),
                        Text('Status: ${trsDetail.status}'),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text('Detail Produk:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: trsDetail.detailTransaction?.length,
                  itemBuilder: (context, index) {
                    var detail = trsDetail.detailTransaction?[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(detail!.productPhoto,
                            width: 50, height: 50),
                        title: Text(detail.productName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Harga: ${detail.price}'),
                            Text('Jumlah: ${detail.qty}'),
                            Text('Subtotal: ${detail.subtotal}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 16),
                Text('Alamat Pengiriman:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Nama Penerima: ${trsDetail.addressUsername}'),
                SizedBox(height: 8),
                Text('Nomor Telepon: ${trsDetail.addressPhone}'),
                SizedBox(height: 8),
                Text('Alamat: ${trsDetail.addressInAddress}'),
                SizedBox(height: 8),
                Text('Detail Alamat: ${trsDetail.addressAddressDetail}'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Aksi jika tombol pembayaran ditekan
                    // Contoh: Buka halaman pembayaran dengan URL yang diberikan
                    // Navigator.pushNamed(context, PaymentPage.routeName, arguments: transaction.paymentUrl);
                  },
                  child: Text('Bayar Sekarang'),
                ),
              ],
            ),
          ),
        ));
  }
}
