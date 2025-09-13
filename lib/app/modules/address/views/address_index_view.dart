import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/component/awesome_dialog.dart';
import 'package:mall_ukm/app/modules/address/controllers/address_controller.dart';
import 'package:mall_ukm/app/modules/checkout/controllers/checkout_offline_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddressIndexView extends GetView<AddressController> {
  const AddressIndexView({super.key});

  @override
  Widget build(BuildContext context) {
    RxDouble tot = 0.0.obs;
    var idAddress = 0.obs;
    var checkoutO = Get.put(CheckoutOfflineController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              checkoutO.refreshAddress();
              controller.getAdrresNow();
              Get.back();
            }),
        iconTheme: IconThemeData(color: Styles.colorPrimary()),
        title: Text(
          'Alamat',
          style: Styles.headerStyles(weight: FontWeight.w500, size: 16),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: kToolbarHeight + 15,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: GestureDetector(
              onTap: () async {
                await controller.updateStatus(idAddress.value);
                controller.getAddress();
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Styles.colorPrimary(),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text('Pilih Alamat',
                        style: Styles.bodyStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.refreshAddress();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: const Text(
                          'Alamat Pengiriman',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16),
                        child: Obx(() {
                          if (controller.addressIndexList.isEmpty) {
                            return SingleChildScrollView(
                              child: Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height - 200,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Kamu belum menambahkan Alamat',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            checkoutO.refreshAddress();
                                            controller.fetchProvinces();
                                            Get.toNamed('/address');
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.add,
                                                  color: Color(0xff034779),
                                                  size: 26,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text('Tambah Alamat',
                                                    style: Styles.bodyStyle(
                                                        size: 17,
                                                        color:
                                                            Color(0xff034779))),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  itemCount: controller.addressIndexList.length,
                                  itemBuilder: (context, index) {
                                    var adr =
                                        controller.addressIndexList[index];
                                    if (adr.status == 'selected') {
                                      controller.selectedAddress.value = adr;
                                    }

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Obx(() => GestureDetector(
                                                onTap: () {
                                                  controller.selectedAddress
                                                      .value = adr;
                                                  idAddress.value = adr.id;
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: controller
                                                                  .selectedAddress
                                                                  .value
                                                                  ?.id ==
                                                              adr.id
                                                          ? Colors
                                                              .deepOrange[700]!
                                                          : Colors.grey[400]!,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: controller
                                                                .selectedAddress
                                                                .value
                                                                ?.id ==
                                                            adr.id
                                                        ? Icon(
                                                            Icons.check,
                                                            color: Colors
                                                                    .deepOrange[
                                                                700],
                                                            size: 18,
                                                          )
                                                        : const Icon(
                                                            Icons.check,
                                                            color: Colors
                                                                .transparent,
                                                            size: 18,
                                                          ),
                                                  ),
                                                ),
                                              )),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          right: 8,
                                                          bottom: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 8.0,
                                                                      top: 2),
                                                              child: Text(
                                                                '${adr.username} | ${adr.phone}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                ),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 8.0,
                                                                      top: 2,
                                                                      bottom:
                                                                          2),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            5.0),
                                                                    child: Text(
                                                                      adr.addressDetail,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      maxLines:
                                                                          5,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            5.0),
                                                                    child: Text(
                                                                      '${adr.address}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      maxLines:
                                                                          5,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 20.0),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                WarningDialog
                                                                    .show(
                                                                        context:
                                                                            context,
                                                                        title:
                                                                            'Hapus alamat ini?',
                                                                        btnCancelOnPress:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        btnOkOnPress:
                                                                            (() {
                                                                          controller
                                                                              .deleteAdress(adr.id);
                                                                        }));
                                                              },
                                                              child:  Icon(
                                                                PhosphorIcons
                                                                    .trashSimple,
                                                                color: Colors
                                                                    .deepOrange,
                                                                size: 20,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    checkoutO.refreshAddress();
                                    controller.fetchProvinces();
                                    Get.toNamed('/address');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          color: Color(0xff034779),
                                          size: 26,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text('Tambah Alamat',
                                            style: Styles.bodyStyle(
                                                size: 17,
                                                color: Color(0xff034779))),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
