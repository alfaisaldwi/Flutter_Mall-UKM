import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/transaction_page/controllers/transaction_page_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';

class TransactionSemuaView extends GetView<TransactionPageController> {
  @override
  Widget build(BuildContext context) {
    var ctrT = Get.put(TransactionPageController());
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            itemCount: ctrT.transactionIndexList.length,
            itemBuilder: (context, index) {
              var trs = ctrT.transactionIndexList[index];
              // var trsDetail =
              //     ctrT.transactionIndexList.detailTransactions[index];
              return GestureDetector(
                onTap: () {
                  // Get.to(() => DetailKontentLokalView(),
                  //     arguments: kontenData[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    height: 120,
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    child: Row(children: [
                      // Image.network(
                      //     'https://paulkingart.com/wp-content/uploads/2019/07/Kurt-Cobain-1993_PWK.jpg',
                      //     width: 140,
                      //     height: 120),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                trs.status,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Styles.bodyStyle(),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('total ${trs.total}'),
                                  Wrap(children: [
                                    Icon(
                                      Icons.date_range,
                                      size: 18,
                                    ),
                                    Text(' ${trs.courier} ${trs.costCourier}'),
                                  ]),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
