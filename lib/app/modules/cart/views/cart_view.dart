// ignore_for_file: prefer_const_constructors

import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/cart/cartItem_model.dart';
import 'package:mall_ukm/app/model/cart/selectedCart.dart';
import 'package:mall_ukm/app/modules/cart/views/checkbox.dart';
import 'package:mall_ukm/app/style/styles.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    var selectAll = false.obs;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 60), // Tinggi app bar
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
                title: Text(
                  'Keranjang',
                  style: Styles.headerStyles(weight: FontWeight.w500, size: 16),
                ),
                backgroundColor: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  children: [
                    Obx(() {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text('Pilih Semua'),
                                value: selectAll.value,
                                onChanged: (bool? value) {
                                  controller.toggleSelectAll(value ?? false);
                                  selectAll.value = value ?? false;
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
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
                    child: Obx(() {
                      if (controller.totalHarga.value <= 0) {
                        Text('-');
                      } else {
                        return Text(
                          '${controller.convertToIdr(controller.totalHarga.value, 2)}',
                          style: Styles.bodyStyle(
                            weight: FontWeight.w500,
                            size: 15,
                          ),
                        );
                      }
                      return (Text('-'));
                    }),
                  )
                ],
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (controller.selectedItems.isNotEmpty) {
                      print(controller.totalHarga.value);
                      Get.toNamed('/checkout', arguments: [
                        controller.selectedItems,
                        controller.totalHarga.value,
                        controller.totalWeight.value,
                      ]);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Pilih barang terlebih dahulu',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.grey[800],
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    }
                  },
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
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10),
                    child: Obx(() {
                      if (controller.carts.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            await controller.fetchCart();
                          },
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 200,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Kamu belum memasukkan barang ke keranjang',
                                    style: Styles.bodyStyle(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            controller.fetchCart();
                          },
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: controller.carts.length,
                                itemBuilder: (context, index) {
                                  var cart = controller.carts[index];
                                  controller.subWeightC.add(RxDouble(0.0));
                                  controller.counter[index].value = cart.qty;
                                  controller.subWeightC[index].value =
                                      cart.weight;
                                  controller.priceC[index].value = cart.price;
                                  // var isChecked =
                                  //     controller.isChecked(index).obs;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Obx(
                                                () => CheckboxTile(
                                                  value: controller
                                                      .isCheckedList[index],
                                                  onChanged: (bool? value) {
                                                    controller.setChecked(
                                                        value ?? false, index);
                                                    if (value == true) {
                                                      controller.totalHarga
                                                          .value += controller
                                                              .priceC[index]
                                                              .value *
                                                          controller
                                                              .counter[index]
                                                              .value;
                                                      controller.totalWeight
                                                          .value += controller
                                                              .counter[index]
                                                              .value *
                                                          controller
                                                              .subWeightC[index]
                                                              .value;

                                                      controller.selectedItems
                                                          .add(SelectedCartItem(
                                                              isChecked: true,
                                                              cart: cart));
                                                      if (controller
                                                              .carts.length ==
                                                          controller
                                                              .selectedItems
                                                              .length) {
                                                        selectAll.value = true;
                                                        print('kondisi 1');
                                                      }
                                                    } else {
                                                      controller.totalHarga
                                                          .value -= controller
                                                              .priceC[index]
                                                              .value *
                                                          controller
                                                              .counter[index]
                                                              .value;
                                                      controller.totalWeight
                                                          .value -= controller
                                                              .counter[index]
                                                              .value *
                                                          controller
                                                              .subWeightC[index]
                                                              .value;
                                                      controller.selectedItems
                                                          .removeWhere((item) =>
                                                              item.cart ==
                                                              cart);

                                                      selectAll.value = false;
                                                      print('kondisi 2');
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 120,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.80,
                                              padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      '${cart.photo}',
                                                      width: 115,
                                                      height: 95,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 4.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(height: 8),
                                                          Text(
                                                            cart.title,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            'Varian: ${cart.unitVariant}',
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            controller
                                                                .convertToIdr(
                                                                    cart.price,
                                                                    2),
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Spacer(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Obx(() {
                                                                return CartStepperInt(
                                                                  value: controller
                                                                      .counter[
                                                                          index]
                                                                      .value,
                                                                  size: 22,
                                                                  style:
                                                                      CartStepperStyle(
                                                                    foregroundColor:
                                                                        Colors
                                                                            .black87,
                                                                    activeForegroundColor:
                                                                        Colors
                                                                            .black87,
                                                                    activeBackgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey),
                                                                    radius: const Radius
                                                                        .circular(
                                                                        8),
                                                                    elevation:
                                                                        0,
                                                                    buttonAspectRatio:
                                                                        1.5,
                                                                  ),
                                                                  didChangeCount:
                                                                      (count) async {
                                                                    if (controller
                                                                            .isCheckedList[index] ==
                                                                        true) {
                                                                      if (count >
                                                                          controller
                                                                              .counter[
                                                                                  index]
                                                                              .value) {
                                                                        cart.qty = controller
                                                                            .counter[index]
                                                                            .value;
                                                                        controller
                                                                            .counterPlus
                                                                            .value = true;
                                                                        cart.qty++;
                                                                        print(cart
                                                                            .qty);
                                                                        CartItem
                                                                            cartItem =
                                                                            CartItem(
                                                                          product_id:
                                                                              int.parse(cart.productId),
                                                                          qty:
                                                                              1,
                                                                          unit_variant:
                                                                              cart.unitVariant,
                                                                        );
                                                                        await controller.updateCart(
                                                                            cart.id,
                                                                            cartItem,
                                                                            index);
                                                                      } else if (count <
                                                                          controller
                                                                              .counter[index]
                                                                              .value) {
                                                                        if (controller.counter[index].value <=
                                                                            1) {
                                                                          // await controller
                                                                          //     .deleteCart(
                                                                          //         cart.id);
                                                                        } else if (count <
                                                                            controller.counter[index].value) {
                                                                          controller
                                                                              .counterPlus
                                                                              .value = false;
                                                                          CartItem
                                                                              cartItem =
                                                                              CartItem(
                                                                            product_id:
                                                                                int.parse(cart.productId),
                                                                            qty:
                                                                                -1,
                                                                            unit_variant:
                                                                                cart.unitVariant,
                                                                          );
                                                                          await controller.updateCart(
                                                                              cart.id,
                                                                              cartItem,
                                                                              index);
                                                                        }
                                                                      }
                                                                    } else {
                                                                      Fluttertoast
                                                                          .showToast(
                                                                        msg:
                                                                            'Ceklis Produk yang ingin kamu hitung',
                                                                        toastLength:
                                                                            Toast.LENGTH_SHORT,
                                                                        gravity:
                                                                            ToastGravity.BOTTOM,
                                                                        backgroundColor:
                                                                            Colors.grey[800],
                                                                        textColor:
                                                                            Colors.white,
                                                                        fontSize:
                                                                            14.0,
                                                                      );
                                                                    }
                                                                  },
                                                                );
                                                              }),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await controller
                                                                      .deleteCart(
                                                                          cart.id);
                                                                },
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .delete_outline_rounded,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
