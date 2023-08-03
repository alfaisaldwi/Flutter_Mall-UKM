import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/transaction/transaction_index_model.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';

class TransactionCanceledView extends GetView<TransactionPageController> {
  @override
  Widget build(BuildContext context) {
    var ctrT = Get.put(TransactionPageController());
    bool hasPaidTransactions;

    return RefreshIndicator(
      onRefresh: () async {
        controller.callGettrs();
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: ctrT.transactionIndexList.length,
                    itemBuilder: (context, index) {
                      var trs = ctrT.transactionIndexList[index];
                      if (trs.status == 'canceled') {
                        hasPaidTransactions = true;
                        return TransactionCard(transaction: trs);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
            ),
            if (hasPaidTransactions = false)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 300.0),
                child: Container(
                  color: Colors.white,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text('Tidak ada transaksi'),
                  ),
                ),
              ),
          ],
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
    var ctrT = Get.put(TransactionPageController());

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
                    if (transaction.status == 'paid')
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'Sudah dibayar',
                              style: TextStyle(
                                color: Colors.green[
                                    800], // Tetapkan warna teks yang diinginkan
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )),
                    if (transaction.status == 'canceled')
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 10.0),
                            child: Text(
                              'Dibatalkan',
                              style: TextStyle(
                                color: Colors.grey[
                                    100], // Tetapkan warna teks yang diinginkan
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )),
                    if (transaction.status == 'unpaid')
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.yellowAccent[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Text(
                              'Belum Bayar',
                              style: TextStyle(
                                color: Colors
                                    .red, // Tetapkan warna teks yang diinginkan
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )),
                    if (transaction.status == 'sending')
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.yellowAccent[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6.0, horizontal: 8.0),
                            child: Text(
                              'Sedang dikirim',
                              style: TextStyle(
                                color: Colors.red[
                                    200], // Tetapkan warna teks yang diinginkan
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )),
                    if (transaction.status == 'delivered')
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.greenAccent[100],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'Selesai',
                              style: TextStyle(
                                color: Colors.green[
                                    800], // Tetapkan warna teks yang diinginkan
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )),
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
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                        'Total:  ${ctrT.convertToIdr(double.parse(transaction.total), 2)}'),
                  ],
                ),
                trailing: Icon(Icons.arrow_forward),
                onTap: () async {
                  var trsDetail =
                      await ctrT.fetchDetailTransaction(transaction.id);

                  Get.toNamed('/transaction-detail', arguments: trsDetail);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
