import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/modules/cart/views/cart_view.dart';
import 'package:mall_ukm/app/modules/home/controllers/home_controller.dart';
import 'package:mall_ukm/app/modules/home/views/search_view.dart';
import 'package:mall_ukm/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:search_page/search_page.dart';

import '../controllers/recommend_page_controller.dart';

class RecommendPageView extends GetView<RecommendPageController> {
  var productDetail = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    List people = [
      'Mike',
      'Barron',
      64,
    ];
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
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            height: 40,
            color: Color(0xfff7f7f7),
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
                child: Center(
                  child: TextField(
                    enabled: false,
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Cari Produk',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
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
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              onPressed: () {},
            ),
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.recomendProduct();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 10),
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

                            if (recomend.title == 'Konsol Game') {
                              // Jika kategori adalah 'Pakaian', 'Tas', atau 'Konsol Game', tampilkan dalam GridView
                              return GestureDetector(
                                onTap: () {
                                  // Get.to(() => DetailKontentLokalView(),
                                  //     arguments: kontenData[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Card(
                                    child: Container(
                                      width: 140,
                                      padding: const EdgeInsets.all(5),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0,
                                            left: 0.0,
                                            right: 0.0,
                                            bottom: 0.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 0),
                                              child: Text(
                                                recomend.title!,
                                                style: Styles.headerStyles(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            MasonryGridView.count(
                                              crossAxisCount: 2,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              mainAxisSpacing: 16,
                                              crossAxisSpacing: 18,
                                              itemCount:
                                                  recomend.products?.length,
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
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        color: Colors.white),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    10.0),
                                                          ),
                                                          child: Image.network(
                                                              product.photo!),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 2,
                                                                  vertical: 5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      product
                                                                          .title!,
                                                                      maxLines:
                                                                          2,
                                                                      style: const TextStyle(
                                                                          overflow: TextOverflow
                                                                              .fade,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              16,
                                                                          color: Color.fromRGBO(
                                                                              74,
                                                                              74,
                                                                              74,
                                                                              1)),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 4,
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        2.0),
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      controller.convertToIdr(
                                                                          product
                                                                              .price,
                                                                          2),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color: Color.fromRGBO(
                                                                              133,
                                                                              133,
                                                                              133,
                                                                              1)),
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Text(
                                                                      controller.convertToIdr(
                                                                          product
                                                                              .priceRetail,
                                                                          2),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          color: Colors
                                                                              .red,
                                                                          decoration:
                                                                              TextDecoration.lineThrough),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else if (recomend.title == 'Pakaian' ||
                                recomend.title == 'Tas') {
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 0),
                                          child: Text(
                                            recomend.title!,
                                            style: Styles.headerStyles(),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              180, // Atur tinggi untuk menampilkan beberapa produk dalam satu kategori
                                          child: ListView.builder(
                                            physics:
                                                const ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                recomend.products?.length,
                                            itemBuilder: (context, index) {
                                              var product =
                                                  recomend.products![index];
                                              return GestureDetector(
                                                onTap: () async {
                                                  var productDetails =
                                                      await productDetail
                                                          .fetchProductDetails(
                                                              product.id!);
                                                  Get.toNamed('product-detail',
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 5.0,
                                                                left: 8.0,
                                                                right: 8.0,
                                                                bottom: 0.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                child: Image
                                                                    .network(
                                                                  product
                                                                      .photo!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 140,
                                                                  height: 90,
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
                                                                product.title!,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8.0,
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
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }),
                    ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                    //   child: Text(
                    //     'Makanan khas daerah',
                    //     style: Styles.headerStyles(),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10.0),
                    //   child: SizedBox(
                    //     height: MediaQuery.of(context).size.height * .3 - 45,
                    //     width: double.infinity,
                    //     child: ListView.builder(
                    //         physics: const ClampingScrollPhysics(),
                    //         shrinkWrap: true,
                    //         scrollDirection: Axis.horizontal,
                    //         itemCount: controller.recomend.length,
                    //         itemBuilder: (context, index) {
                    //           var recomend = controller.recomend[index];

                    //           return GestureDetector(
                    //             onTap: () {
                    //               // Get.to(() => DetailKontentLokalView(),
                    //               //     arguments: kontenData[index]);
                    //             },
                    //             child: Padding(
                    //               padding: const EdgeInsets.only(left: 2.0),
                    //               child: Card(
                    //                 child: Container(
                    //                   width: 140,
                    //                   padding: const EdgeInsets.all(5),
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.only(
                    //                         top: 5.0,
                    //                         left: 8.0,
                    //                         right: 8.0,
                    //                         bottom: 0.0),
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         SizedBox(
                    //                           child: ClipRRect(
                    //                             borderRadius:
                    //                                 BorderRadius.circular(4),
                    //                             child: Image.network(
                    //                               recomend.photo.first,
                    //                               fit: BoxFit.cover,
                    //                               width: 140,
                    //                               height: 90,
                    //                             ),
                    //                           ),
                    //                         ),
                    //                         const SizedBox(
                    //                           height: 10,
                    //                         ),
                    //                         Padding(
                    //                           padding: const EdgeInsets.symmetric(
                    //                               horizontal: 8.0, vertical: 4.0),
                    //                           child: Text(
                    //                             recomend.title,
                    //                             textAlign: TextAlign.left,
                    //                             maxLines: 2,
                    //                             overflow: TextOverflow.ellipsis,
                    //                             style: Styles.bodyStyle(
                    //                                 weight: FontWeight.w600),
                    //                           ),
                    //                         ),
                    //                         Padding(
                    //                           padding: const EdgeInsets.symmetric(
                    //                               horizontal: 8.0, vertical: 2.0),
                    //                           child: Text(
                    //                             'Rp. 5.000.000',
                    //                             textAlign: TextAlign.left,
                    //                             maxLines: 1,
                    //                             overflow: TextOverflow.ellipsis,
                    //                             style: Styles.bodyStyle(size: 12),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           );
                    //         }),
                    //   ),
                    // ),

                    //////////////////////
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 15.0, horizontal: 10.0),
                    //         child: Align(
                    //           alignment: Alignment.centerLeft,
                    //           child: Text(
                    //             'Rekomendasi lainnya',
                    //             style: Styles.headerStyles(),
                    //           ),
                    //         ),
                    //       ),
                    //       GridView.builder(
                    //           padding: EdgeInsets.zero,
                    //           shrinkWrap: true,
                    //           physics: const NeverScrollableScrollPhysics(),
                    //           gridDelegate:
                    //               const SliverGridDelegateWithFixedCrossAxisCount(
                    //                   crossAxisCount: 2,
                    //                   crossAxisSpacing: 1,
                    //                   mainAxisSpacing: 2),
                    //           itemCount: controller.recomend2.length,
                    //           itemBuilder: (BuildContext ctx, index) {
                    //             var recomend = controller.recomend[index];
                    //             final originalPrice = NumberFormat.decimalPattern()
                    //                 .format(int.parse(recomend.price));
                    //             final discountedPrice = NumberFormat.decimalPattern()
                    //                 .format(int.parse(recomend.priceRetail));

                    //             return GestureDetector(
                    //               onTap: () {
                    //                 // Get.to(() => DetailKontentLokalView(),
                    //                 //     arguments: kontenData[index]);
                    //               },
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(4.0),
                    //                 child: Card(
                    //                   child: Container(
                    //                     margin: const EdgeInsets.all(2),
                    //                     padding: const EdgeInsets.all(5),
                    //                     child: Padding(
                    //                       padding: const EdgeInsets.only(
                    //                           left: 8.0, right: 8.0, bottom: 4.0),
                    //                       child: Column(
                    //                         crossAxisAlignment: CrossAxisAlignment.start,
                    //                         children: [
                    //                           Align(
                    //                             alignment: Alignment.center,
                    //                             child: AspectRatio(
                    //                               aspectRatio: 16 / 9,
                    //                               child: ClipRRect(
                    //                                 borderRadius:
                    //                                     BorderRadius.circular(4),
                    //                                 child: Image.network(
                    //                                   recomend.photo.first,
                    //                                   fit: BoxFit.cover,
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           Padding(
                    //                             padding: const EdgeInsets.symmetric(
                    //                                 horizontal: 8.0, vertical: 8.0),
                    //                             child: Text(
                    //                               recomend.title,
                    //                               textAlign: TextAlign.left,
                    //                               maxLines: 3,
                    //                               overflow: TextOverflow.ellipsis,
                    //                               style: Styles.bodyStyle(
                    //                                   weight: FontWeight.w600),
                    //                             ),
                    //                           ),
                    //                           Padding(
                    //                               padding: const EdgeInsets.symmetric(
                    //                                   horizontal: 8.0, vertical: 2.0),
                    //                               child: RichText(
                    //                                 softWrap: true,
                    //                                 text: TextSpan(
                    //                                   text: 'Rp.$originalPrice',
                    //                                   style: const TextStyle(
                    //                                     fontSize: 13,
                    //                                     color: Colors.black,
                    //                                   ),
                    //                                   children: [
                    //                                     WidgetSpan(
                    //                                       child: Container(
                    //                                         width:
                    //                                             8, // Adjust the width as needed
                    //                                       ),
                    //                                     ),
                    //                                     TextSpan(
                    //                                       text: '$discountedPrice',
                    //                                       style: const TextStyle(
                    //                                         fontSize: 12,
                    //                                         color: Colors.red,
                    //                                         decoration: TextDecoration
                    //                                             .lineThrough,
                    //                                       ),
                    //                                     ),
                    //                                   ],
                    //                                 ),
                    //                               )),
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
