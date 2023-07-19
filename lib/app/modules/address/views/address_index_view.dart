import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/address/controllers/address_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddressIndexView extends GetView<AddressController> {
  @override
  Widget build(BuildContext context) {
    RxDouble tot = 0.0.obs;
    var idAddress = 0.obs;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Alamat',
          style: Styles.headerStyles(weight: FontWeight.w500, size: 16),
        ),
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
              onTap: () {
                Get.toNamed('/address');
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Tambah Alamat',
                    style:
                        Styles.headerStyles(weight: FontWeight.w400, size: 13),
                  ),
                ),
              ))
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: kToolbarHeight + 15,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                controller.updateStatus(idAddress.value);
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xff034779),
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 0),
                child: Obx(() {
                  if (controller.addressIndexList.isEmpty) {
                    return Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Kamu belum memasukan menambahkan Alamat',
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
                      itemCount: controller.addressIndexList.length,
                      itemBuilder: (context, index) {
                        var adr = controller.addressIndexList[index];
                        if (adr.status == 'selected') {
                          controller.selectedAddress.value = adr;
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => GestureDetector(
                                    onTap: () {
                                      controller.selectedAddress.value = adr;
                                      idAddress.value = adr.id;
                                      print(idAddress);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: controller.selectedAddress
                                                      .value?.id ==
                                                  adr.id
                                              ? Colors.deepOrange[700]!
                                              : Colors.grey[400]!,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: controller.selectedAddress.value
                                                    ?.id ==
                                                adr.id
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.deepOrange[700],
                                                size: 18,
                                              )
                                            : Icon(
                                                Icons.check,
                                                color: Colors.transparent,
                                                size: 18,
                                              ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Alamat Pengiriman',
                                                    style: Styles.bodyStyle(
                                                        size: 14),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0, top: 2),
                                                  child: Text(
                                                    '${adr.username} | ${adr.phone}',
                                                    style: Styles.bodyStyle(
                                                        size: 14),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          top: 2,
                                                          bottom: 2),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          adr.addressDetail,
                                                          textAlign:
                                                              TextAlign.left,
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: Styles
                                                              .bodyStyle(),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 5.0),
                                                        child: Text(
                                                          '${adr.address}',
                                                          textAlign:
                                                              TextAlign.left,
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: Styles
                                                              .bodyStyle(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: Icon(
                                              PhosphorIcons.notePencil,
                                              color: Color.fromARGB(
                                                  255, 255, 129, 91),
                                              size: 20,
                                            ),
                                          )
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
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
