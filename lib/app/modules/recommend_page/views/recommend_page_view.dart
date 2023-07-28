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
                                          itemCount: recomend.products?.length,
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
                                                padding: const EdgeInsets.only(
                                                    left: 2.0),
                                                child: Card(
                                                  child: Container(
                                                    width: 140,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                              child:
                                                                  Image.network(
                                                                product.photo!,
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
                                                            padding:
                                                                const EdgeInsets
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
                                                            padding:
                                                                const EdgeInsets
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
                                                                  fontSize: 12),
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
                          }),
                    ),
                  
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
