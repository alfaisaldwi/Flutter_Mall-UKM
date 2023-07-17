import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/address/address_select.dart';
import 'package:mall_ukm/app/model/cart/cart_model.dart';
import 'package:mall_ukm/app/model/cart/kurir_model.dart';
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
    var addressId = 0;
    var productId = 0;
    var cartId = 0;
    var priceProduct = 0;
    var variantProduct = '';
    var ongkir = 0.0.obs;
    RxString totalakhir = ''.obs;
    // int subtotValue = int.parse(subtot.value.toString());
    // NumberFormat formatter = NumberFormat.decimalPattern();
    // String formattedValue = formatter.format(subtotValue);
    // totalakhir.value = formattedValue;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Checkout',
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
                      child: Obx(() => Text(
                            '${subtot.value}',
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
                    CheckoutData checkoutData = CheckoutData(
                      addressId: addressId,
                      courier: controller.selectedCourier.value,
                      costCourier: ongkir.value.toInt(),
                      total: subtot.value.toInt(),
                      products: [
                        {
                          "id": cartId,
                          "product_id": productId,
                          "price": priceProduct,
                          "quantity": qty.value,
                          "variant": variantProduct
                        },
                      ],
                    );

                    controller.tambahDataTransaksi(checkoutData);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Alamat Pengiriman',
                        style: Styles.bodyStyle(size: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/address-index');
                        },
                        child: Text(
                          'Ubah Alamat',
                          style: Styles.bodyStyle(color: Colors.blue[700]),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8, bottom: 1),
                            child: Icon(
                              Icons.location_on_outlined,
                              color: Colors.deepOrange[700],
                            ),
                          ),
                        ),
                        FutureBuilder<AddressSelect>(
                          future: controller.getAddress(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Ketika sedang menunggu respons dari API
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              // Ketika terjadi kesalahan
                              return Align(
                                  alignment: Alignment.center,
                                  child: Text('Kamu belum memilih alamat.'));
                            } else if (snapshot.hasData) {
                              // Ketika data berhasil diambil
                              final addressData = snapshot.data!;
                              addressId = addressData.id;
                              controller.idkecamatan =
                                  addressData.destinationId;

                              return Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 2),
                                      child: Container(
                                        width: 150,
                                        child: Text(
                                          '${addressData.username} | ${addressData.phone}',
                                          style: Styles.bodyStyle(size: 14),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 2),
                                      child: Text(
                                        '${addressData.addressDetail}',
                                        style: Styles.bodyStyle(size: 14),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, top: 2, bottom: 2),
                                      child: Text(
                                        '${addressData.address}',
                                        textAlign: TextAlign.left,
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.bodyStyle(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              // Ketika tidak ada data yang ditemukan
                              return Text('Kamu belum memilih alamat.');
                            }
                          },
                        )
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
                    qty.value = cart.cart.qty;
                    productId = int.parse(cart.cart.productId);
                    cartId = cart.cart.id;
                    priceProduct = cart.cart.price.toInt();
                    variantProduct = cart.cart.unitVariant;
                    // controller.weight = cart.cart.

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
                                          '${cart.cart.price.toStringAsFixed(2)}',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefix: Text('Pesan : '),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedCourier.value.isNotEmpty
                        ? controller.selectedCourier.value
                        : null,
                    decoration: InputDecoration(labelText: 'Kurir'),
                    onChanged: (value) {
                      if (controller.selectedCourier.value == '') {
                        controller.selectedCourier.value = value!;
                      } else {
                        controller.selectedService.value = '';
                      }
                      controller.selectedCourier.value = value!;
                      controller.fetchServices();
                    },
                    items: controller.couriers.map((courier) {
                      return DropdownMenuItem<String>(
                        value: courier,
                        child: Text(courier.toUpperCase()),
                      );
                    }).toList(),
                  ),
                ),
                Obx(() => DropdownButtonFormField<String>(
                      value: controller.selectedService.value.isNotEmpty
                          ? controller.selectedService.value
                          : null,
                      decoration: InputDecoration(labelText: 'Service'),
                      onChanged: (value) {
                        controller.selectedService.value = value!;
                        final selectedService = controller.services.value
                            .firstWhere(
                                (service) => service['service'] == value);
                        final costValue =
                            selectedService['cost'][0]['value'].toString();
                        controller.costValue.value = double.parse(costValue);

                        ongkir.value =
                            double.parse(controller.costValue.toString());
                        subtot.value =
                            double.parse(controller.costValue.toString()) +
                                (double.parse(hargaBarang.toString()));
                        print(subtot.value);
                      },
                      items: controller.services.isNotEmpty
                          ? controller.services.value
                              .map<DropdownMenuItem<String>>((service) {
                              final String serviceValue =
                                  service['service'] as String;
                              final String description =
                                  service['description'] as String;
                              final String costValue =
                                  service['cost'][0]['value'].toString();

                              // Mengubah 'cost' menjadi 'description'
                              return DropdownMenuItem<String>(
                                value: serviceValue,
                                child: Row(
                                  children: [
                                    Text(description),
                                    SizedBox(width: 10),
                                    Text(': Rp.$costValue'),
                                  ],
                                ),
                              );
                            }).toList()
                          : <
                              DropdownMenuItem<
                                  String>>[], // Mengubah tipe data menjadi <DropdownMenuItem<String>>
                    )),
                const SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  child: Row(children: [
                    Text(
                      'Harga Barang : $hargaBarang',
                      style: Styles.bodyStyle(),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  child: Row(children: [
                    Obx(() => Text(
                          'Ongkir : ${ongkir.value}.',
                          style: Styles.bodyStyle(),
                        )),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   color: Colors.white,
                //   child: Row(children: [
                //     Text(
                //       'Subtotal',
                //       style: Styles.bodyStyle(),
                //     ),
                //     Obx(() => Text('${subtot.value}')),
                //   ]),
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
