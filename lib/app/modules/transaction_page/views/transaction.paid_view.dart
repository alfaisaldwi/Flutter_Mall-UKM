import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/transaction/transaction_index_model.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';

class TransactionPaidView extends GetView<TransactionPageController> {
  @override
  Widget build(BuildContext context) {
    var ctrT = Get.put(TransactionPageController());
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
        child: Obx(
          () => ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              itemCount: ctrT.transactionIndexList.length,
              itemBuilder: (context, index) {
                var trs = ctrT.transactionIndexList[index];
                // var trsDetail =
                //     ctrT.transactionIndexList.detailTransactions[index];

                if (trs.status == 'paid') {
                  return TransactionCard(transaction: trs);
                } else {
                  return Container(); // Jika status bukan "paid", tampilkan container kosong
                }
              }),
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.parse(transaction.createdAt);
    final formattedDate = DateFormat('dd MMM yyyy').format(createdAt);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$formattedDate'),
                    Text('${transaction.status}'),
                  ],
                ),
              ),
              ListTile(
                leading: Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(transaction.productPhoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(transaction.productName),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kurir: ${transaction.courier}'),
                    Text('Total: ${transaction.total}'),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // Tambahkan logika untuk menavigasi ke halaman rincian transaksi
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
