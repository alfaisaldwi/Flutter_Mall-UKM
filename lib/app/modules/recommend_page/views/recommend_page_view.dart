import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/modules/home/controllers/home_controller.dart';
import 'package:mall_ukm/app/modules/home/views/search_view.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:search_page/search_page.dart';

import '../controllers/recommend_page_controller.dart';

class RecommendPageView extends GetView<RecommendPageController> {
  var productDetail = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    const int count = 16;
    const int itemsPerRow = 2;
    const double ratio = 1 / 1;
    const double horizontalPadding = 0;
    final double calcHeight = ((width / itemsPerRow) - (horizontalPadding)) *
        (count / itemsPerRow).ceil() *
        (1 / ratio);
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: SearchPage(
                      barTheme: ThemeData.light(useMaterial3: true),
                      onQueryUpdate: print,
                      items: productDetail.products,
                      searchLabel: 'Cari..',
                      suggestion: const Center(
                        child: Text('Cari produk yang kamu kebutuhan'),
                      ),
                      failure: const Center(
                        child: Text('Produk yang kamu cari tidak ada :('),
                      ),
                      filter: (product) => [
                        product.title,
                      ],
                      builder: (product) => SearchView(
                        products: product,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logoMall.png',
                      width: 45,
                      height: 45,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 240,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const TextField(
                        enabled: false,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          border: InputBorder
                              .none, // Hapus border pada input decoration TextField
                          hintText: 'Cari Produk di Mall UKM',
                          hintStyle: const TextStyle(fontSize: 12),
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: GestureDetector(
                onTap: () {
                  String? token = GetStorage().read('token');
                  if (token != null) {
                    Get.toNamed('/cart');
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Silahkan Signin terlebih dahulu',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey[800],
                      textColor: Colors.white,
                      fontSize: 14.0,
                    );
                    Get.toNamed('/profile');
                  }
                },
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.black,
                  size: 22,
                ),
              ),
              onPressed: () {},
            ),
          ]),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 20),
                  child: Text(
                    'Rekomendasi Produk',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        controller.recomendProduct();
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: controller.recomends.length,
                                itemBuilder: (context, index) {
                                  var recomend = controller.recomends[index];
                                  int lenghtMax = 20;
                                  String title =
                                      recomend.title!.length <= lenghtMax
                                          ? recomend.title!
                                          : recomend.title!
                                                  .substring(0, lenghtMax) +
                                              "...";

                                  return Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Container(
                                      width: 140,
                                      padding: const EdgeInsets.all(5),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0,
                                            left: 0.0,
                                            right: 8.0,
                                            bottom: 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    title,
                                                    style:
                                                        Styles.headerStyles(),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () async {
                                                        var categoryDetail =
                                                            await productDetail
                                                                .categotyDetail(
                                                                    recomend
                                                                        .id!);
                                                        print(recomend.id);

                                                        Get.toNamed('category',
                                                            arguments: [
                                                              categoryDetail,
                                                              recomend.title
                                                            ]);
                                                      },
                                                      child: Opacity(
                                                        opacity: 0.7,
                                                        child: Text(
                                                          'Lihat Semua',
                                                          style: Styles
                                                              .headerStyles(
                                                                  size: 13,
                                                                  color: Color(
                                                                      0xffc77d08)),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                            if (recomend.products!.isEmpty)
                                              Container(
                                                  height: 100,
                                                  width: double.infinity,
                                                  child: Center(
                                                    child: Text(
                                                        'Tidak ada produk pada kategori ini'),
                                                  )),
                                            SizedBox(
                                              height: 180,
                                              child: ListView.builder(
                                                physics:
                                                    const ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: min(
                                                    recomend.products!.length,
                                                    6),
                                                itemBuilder: (context, index) {
                                                  var product =
                                                      recomend.products![index];
                                                  return GestureDetector(
                                                    onTap: () async {
                                                      var productDetails =
                                                          await productDetail
                                                              .fetchProductDetails(
                                                                  product.id!);
                                                      Get.toNamed(
                                                          'product-detail',
                                                          arguments: [
                                                            productDetails
                                                          ]);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2.0),
                                                      child: Card(
                                                        child: Container(
                                                          width: 140,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5.0,
                                                                    left: 8.0,
                                                                    right: 8.0,
                                                                    bottom:
                                                                        0.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                    child: Image
                                                                        .network(
                                                                      product
                                                                          .photo!,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width:
                                                                          140,
                                                                      height:
                                                                          90,
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8.0,
                                                                      vertical:
                                                                          4.0),
                                                                  child: Text(
                                                                    product
                                                                        .title!,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          12.0,
                                                                      vertical:
                                                                          2.0),
                                                                  child: Text(
                                                                    'Rp. ${product.price}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
