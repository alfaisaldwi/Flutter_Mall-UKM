import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          title: Text(
            'Keranjang',
            style: Styles.headerStyles(weight: FontWeight.w500, size: 16),
          ),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          height: kToolbarHeight + 15,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 7.0, bottom: 10, top: 12),
                      child: Text('Total Harga', style: Styles.bodyStyle()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                      child: Text(
                        'Rp300.000',
                        style:
                            Styles.bodyStyle(weight: FontWeight.w500, size: 15),
                      ),
                    )
                  ],
                ),
                Center(
                  child: Container(
                    height: 45,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: const Color(0xff034779),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Text('Checkout',
                            style: Styles.bodyStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Obx(() => Checkbox(
                                value: controller.checkbox.value,
                                onChanged: (bool? value) {
                                  if (value == true) {
                                    controller.checkbox.value = value!;
                                  } else {
                                    controller.checkbox.value = value!;
                                  }
                                  print(controller.checkbox.value);
                                },
                              )),
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.85,
                            padding: EdgeInsets.all(5),
                            child: Row(children: [
                              Image.network(
                                'https://paulkingart.com/wp-content/uploads/2019/07/Kurt-Cobain-1993_PWK.jpg',
                                width: 100,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Produk Kurt Cobain Produk Kurt Cobain Produk Kurt Cobain Produk Kurt Cobain Produk Kurt Cobain',
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.bodyStyle(),
                                      ),
                                      Text(
                                        'Rp300.000',
                                        style: Styles.bodyStyle(),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Obx(() => CartStepperInt(
                                                  value:
                                                      controller.counter.value,
                                                  size: 22,
                                                  style: CartStepperStyle(
                                                    foregroundColor:
                                                        Colors.black87,
                                                    activeForegroundColor:
                                                        Colors.black87,
                                                    activeBackgroundColor:
                                                        Colors.white,
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    radius:
                                                        const Radius.circular(
                                                            8),
                                                    elevation: 0,
                                                    buttonAspectRatio: 1.5,
                                                  ),
                                                  didChangeCount: (count) {
                                                    controller.counter.value =
                                                        count;
                                                  },
                                                )),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Icon(
                                                Icons.delete_outline_rounded,
                                                color: Colors.red,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ));
  }
}
