import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/model/address/address_select.dart';
import 'package:mall_ukm/app/model/cart/selectedCart.dart';
import 'package:mall_ukm/app/model/product/product_detail_model.dart';
import 'package:mall_ukm/app/model/transaction/checkout_data.dart';
import 'package:mall_ukm/app/model/transaction/checkout_data_offline.dart';
import 'package:mall_ukm/app/modules/address/controllers/address_controller.dart';
import 'package:mall_ukm/app/modules/checkout/controllers/checkout_offline_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';

class CheckoutOfflineView extends GetView<CheckoutOfflineController> {
  var address = Get.put(AddressController());
  var productPromoId = Get.arguments[0];
  var productDetail = Get.arguments[1];
  var kuantiti = Get.arguments[2];
  var pricePromo = Get.arguments[3];
  var hargaBarang = Get.arguments[1];
  var selectVariant = Get.arguments[4];
  var total = Get.arguments[5];
  var totalBefore = Get.arguments[6];
  var subtot = 0.0.obs;

  var qty = 0.obs;
  @override
  Widget build(BuildContext context) {
    controller.totalWeight.value = Get.arguments[2].toString();

    var addressId = 0;
    var productId = 0;
    var cartId = 0;
    var priceProduct = 0;
    var unitVariant = '';
    var ongkir = 0.0.obs;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Checkout',
          style: Styles.headerStyles(weight: FontWeight.w500, size: 16),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            }),
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
                        controller.convertToIdr(total, 2),
                        style: Styles.bodyStyle(
                          weight: FontWeight.w500,
                          size: 15,
                        ),
                      ))
                ],
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (addressId != 0) {
                      List<Map<String, dynamic>> productsList = [];
                      for (int i = 0; i < 1; i++) {
                        Map<String, dynamic> product = {
                          "product_id": productPromoId,
                          "price": pricePromo,
                          "quantity": kuantiti,
                          "variant": selectVariant
                        };
                        productsList.add(product);
                      }

                      CheckoutDataOffline checkoutDataOffline =
                          CheckoutDataOffline(
                        addressId: addressId,
                        statusPayment: 'offline',
                        total: total,
                        products: productsList,
                      );

                      controller
                          .tambahDataTransaksiOffline(checkoutDataOffline);
                    } else {
                      Fluttertoast.showToast(
                        msg: 'Kamu belum memilih alamat',
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
                        child: Text('Bayar',
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
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refreshAddress();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Alamat Pengiriman',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.callAdress();
                          controller.getAddress();
                          Get.toNamed('/address-index');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Ubah Alamat',
                            style: TextStyle(
                                fontSize: 14, color: Colors.blue[700]),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.deepOrange[700],
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Obx(() => FutureBuilder<AddressSelect>(
                                  future: controller.futureAddress!.value,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SizedBox(
                                        width: 50,
                                        height: 50,
                                        // child: const CircularProgressIndicator(
                                        //   value: 0.1,)
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Align(
                                        alignment: Alignment.center,
                                        child:
                                            Text('Kamu belum memilih alamat.'),
                                      );
                                    } else if (snapshot.hasData) {
                                      final addressData = snapshot.data!;
                                      addressId = addressData.id;
                                      controller.idkecamatan =
                                          addressData.destinationId;

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${addressData.username} | ${addressData.phone}',
                                            style: TextStyle(fontSize: 14),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${addressData.addressDetail}',
                                            style: TextStyle(fontSize: 14),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            '${addressData.address}',
                                            style: TextStyle(fontSize: 14),
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Text('Kamu belum memilih alamat.');
                                    }
                                  },
                                )),
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
                        productDetail.photo.first,
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
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      productDetail.title,
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.bodyStyle(size: 14),
                                    ),
                                    Text(
                                      'Varian : ${selectVariant}',
                                      textAlign: TextAlign.left,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Styles.bodyStyle(size: 14),
                                    ),
                                    Text(
                                      controller.convertToIdr(
                                          int.parse(productDetail.promo), 2),
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
                                    'x${kuantiti}pcs',
                                    style: Styles.bodyStyle(
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 6.0),
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text(
                              'Harga ASLI',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              controller.convertToIdr(totalBefore, 2),
                              style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              'Harga PROMO',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(
                              controller.convertToIdr(total, 2),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
