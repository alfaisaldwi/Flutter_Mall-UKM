import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/model/cart/cartItem_model.dart';
import 'package:mall_ukm/app/model/cart/selectedCart.dart';
import 'package:mall_ukm/app/modules/cart/views/checkbox.dart';
import 'package:mall_ukm/app/style/styles.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    RxDouble totalHarga = 0.0.obs;

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
                    child: Obx(() {
                      return Text(
                        '${totalHarga}',
                        style: Styles.bodyStyle(
                          weight: FontWeight.w500,
                          size: 15,
                        ),
                      );
                    }),
                  )
                ],
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (controller.selectedItems.isNotEmpty) {
                      print(totalHarga.value);
                      Get.toNamed('/checkout', arguments: [
                        controller.selectedItems,
                        totalHarga.value
                      ]);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Masukan barang ke keranjang ',
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
            child: Obx(() {
              if (controller.carts.isEmpty) {
                return Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Kamu belum memasukkan barang ke keranjang',
                        style: Styles.bodyStyle(),
                      ),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: controller.carts.length,
                  itemBuilder: (context, index) {
                    var cart = controller.carts[index];
                    var counter = cart.qty.obs;
                    var isChecked = controller.isChecked(index).obs;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Obx(
                              () => CheckboxTile(
                                value: isChecked.value ?? false,
                                onChanged: (bool? value) {
                                  isChecked.value = value ?? false;
                                  if (value == true) {
                                    totalHarga.value += cart.price * cart.qty;
                                    controller.selectedItems.add(
                                        SelectedCartItem(
                                            isChecked: true, cart: cart));
                                  } else {
                                    totalHarga.value -= cart.price * cart.qty;
                                    controller.selectedItems.removeWhere(
                                        (item) => item.cart == cart);
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.85,
                            padding: EdgeInsets.all(5),
                            child: Row(
                              children: [
                                Image.network(
                                  '${cart.photo}',
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
                                        SizedBox(height: 8),
                                        Text(
                                          cart.title,
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.bodyStyle(),
                                        ),
                                        Text(
                                          'Varian: ${cart.unitVariant}',
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.bodyStyle(),
                                        ),
                                        Text(
                                          'Rp${cart.price}',
                                          style: Styles.bodyStyle(),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Obx(() {
                                                return CartStepperInt(
                                                  value: counter.value,
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
                                                  didChangeCount:
                                                      (count) async {
                                                    if (count > counter.value) {
                                                      totalHarga.value +=
                                                          cart.price;
                                                      counter.value++;
                                                      CartItem cartItem =
                                                          CartItem(
                                                        product_id: int.parse(
                                                            cart.productId),
                                                        qty: 1,
                                                        unit_variant:
                                                            cart.unitVariant,
                                                      );
                                                      await controller
                                                          .updateCart(cart.id,
                                                              cartItem);
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            'Berhasil menambahkan kuantitas',
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        backgroundColor:
                                                            Colors.grey[800],
                                                        textColor: Colors.white,
                                                        fontSize: 14.0,
                                                      );
                                                    } else if (count <
                                                        counter.value) {
                                                      if (counter.value <= 1) {
                                                        await controller
                                                            .deleteCart(
                                                                cart.id);
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              'Item dihapus dari keranjang',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          backgroundColor:
                                                              Colors.grey[800],
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 14.0,
                                                        );
                                                      } else if (count <
                                                          counter.value) {
                                                        totalHarga.value -=
                                                            cart.price;
                                                        counter.value--;
                                                        CartItem cartItem =
                                                            CartItem(
                                                          product_id: int.parse(
                                                              cart.productId),
                                                          qty: -1,
                                                          unit_variant:
                                                              cart.unitVariant,
                                                        );
                                                        await controller
                                                            .updateCart(cart.id,
                                                                cartItem);
                                                        Fluttertoast.showToast(
                                                          msg:
                                                              'Berhasil mengurangi kuantitas',
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          backgroundColor:
                                                              Colors.grey[800],
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 14.0,
                                                        );
                                                      }
                                                    }
                                                  },
                                                );
                                              }),
                                              GestureDetector(
                                                onTap: () async {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        'Berhasil menghapus barang dari keranjang',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor:
                                                        Colors.grey[800],
                                                    textColor: Colors.white,
                                                    fontSize: 14.0,
                                                  );
                                                  await controller
                                                      .deleteCart(cart.id);
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                  child: Icon(
                                                    Icons
                                                        .delete_outline_rounded,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
