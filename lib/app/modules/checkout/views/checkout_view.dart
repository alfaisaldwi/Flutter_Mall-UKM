import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/address/address_select.dart';
import 'dart:math';
import 'package:mall_ukm/app/model/cart/selectedCart.dart';
import 'package:mall_ukm/app/model/transaction/checkout_data.dart';
import 'package:mall_ukm/app/modules/address/controllers/address_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  var address = Get.put(AddressController());
  final List<SelectedCartItem> dataCart =
      Get.arguments[0] as List<SelectedCartItem>;

  var hargaBarang = Get.arguments[1];
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
              controller.goToCartAndRefresh();
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
                      child: Obx(() => Text(
                            controller.convertToIdr(subtot.value, 2),
                            style: Styles.bodyStyle(
                              weight: FontWeight.w500,
                              size: 15,
                            ),
                          )))
                ],
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (!controller.isLoading.value) {
                      if (addressId != 0) {
                        if (controller.selectedCourier.value != '') {
                          controller.isLoading.value = true;
                          List<Map<String, dynamic>> productsList = [];
                          for (int i = 0; i < dataCart.length; i++) {
                            Map<String, dynamic> product = {
                              "id": dataCart[i].cart.id,
                              "product_id": dataCart[i].cart.productId,
                              "price": dataCart[i].cart.price,
                              "quantity": dataCart[i].cart.qty,
                              "variant": dataCart[i].cart.unitVariant
                            };
                            productsList.add(product);
                          }

                          CheckoutData checkoutData = CheckoutData(
                            addressId: addressId,
                            courier: controller.selectedCourier.value,
                            costCourier: ongkir.value.toInt(),
                            statusPayment: 'online',
                            total: subtot.value.toInt(),
                            products: productsList,
                          );

                          controller
                              .tambahDataTransaksi(checkoutData)
                              .then((response) {
                            controller.isLoading.value = false;
                          }).catchError((error) {
                            controller.isLoading.value = false;
                            print('Error: $error');
                          });
                          
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Kamu belum memilih Kurir',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        }
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
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: dataCart.length,
                    itemBuilder: (context, index) {
                      var cart = dataCart[index];
                      qty.value = dataCart[index].cart.qty;
                      productId = int.parse(dataCart[index].cart.productId);
                      cartId = dataCart[index].cart.id;
                      priceProduct = dataCart[index].cart.price.toInt();
                      unitVariant = dataCart[index].cart.unitVariant;

                      return Container(
                          color: const Color(0xfff2f2f2),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Row(children: [
                            Image.network(
                              cart.cart.photo,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            cart.cart.title,
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Styles.bodyStyle(size: 14),
                                          ),
                                          Text(
                                            'Varian : ${cart.cart.unitVariant}',
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Styles.bodyStyle(size: 14),
                                          ),
                                          Text(
                                            controller.convertToIdr(
                                                cart.cart.price, 2),
                                            style: Styles.bodyStyle(size: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          'x${cart.cart.qty}',
                                          style: Styles.bodyStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]));
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //   child: TextFormField(
                  //     decoration: const InputDecoration(
                  //       labelText: 'Pesan',
                  //       prefixIcon: Icon(Icons.message),
                  //       floatingLabelBehavior: FloatingLabelBehavior.always,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Obx(
                            () => ListTile(
                              title: const Text('Kurir'),
                              subtitle: DropdownButtonFormField<String>(
                                value:
                                    controller.selectedCourier.value.isNotEmpty
                                        ? controller.selectedCourier.value
                                        : null,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.all(12.0)),
                                onChanged: (value) {
                                  if (addressId != 0) {
                                    if (controller.selectedCourier.value ==
                                        '') {
                                      controller.selectedCourier.value = value!;
                                    } else {
                                      controller.selectedService.value = '';
                                    }
                                    controller.selectedCourier.value = value!;
                                    controller.fetchServices();
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
                                items: controller.couriers.map((courier) {
                                  return DropdownMenuItem<String>(
                                    value: courier,
                                    child: Text(courier.toUpperCase()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Obx(() => ListTile(
                                title: const Text('Service'),
                                subtitle: DropdownButtonFormField<String>(
                                  value: controller
                                          .selectedService.value.isNotEmpty
                                      ? controller.selectedService.value
                                      : null,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.all(12.0)),
                                  onChanged: (value) {
                                    controller.selectedService.value = value!;
                                    final selectedService = controller
                                        .services.value
                                        .firstWhere((service) =>
                                            service['service'] == value);
                                    final costValue = selectedService['cost'][0]
                                            ['value']
                                        .toString();
                                    controller.costValue.value =
                                        double.parse(costValue);
                                    ongkir.value = double.parse(
                                        controller.costValue.toString());
                                    subtot.value = double.parse(
                                            controller.costValue.toString()) +
                                        double.parse(hargaBarang.toString());
                                  },
                                  items: controller.services.isNotEmpty
                                      ? controller.services.value
                                          .map<DropdownMenuItem<String>>(
                                              (service) {
                                          final String serviceValue =
                                              service['service'] as String;
                                          final String description =
                                              service['description'] as String;
                                          final String costValue =
                                              service['cost'][0]['value']
                                                  .toString();
                                          return DropdownMenuItem<String>(
                                            value: serviceValue,
                                            child: Text(
                                                '$description: Rp.$costValue'),
                                          );
                                        }).toList()
                                      : [],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ListTile(
                        title: const Text(
                          'Harga Barang',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          controller.convertToIdr(hargaBarang, 2),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    margin: const EdgeInsets.all(8.0),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ListTile(
                        title: const Text(
                          'Berat Total',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '${double.parse(controller.totalWeight.value).toStringAsFixed(2)}gram',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Obx(
                        () => ListTile(
                          title: Text(
                            'Ongkir',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            controller.convertToIdr(ongkir.value, 2),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ),
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
