import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mall_ukm/app/modules/category/views/category_view.dart';
import 'package:mall_ukm/app/modules/home/views/search_view.dart';
import 'package:mall_ukm/app/modules/product_detail/views/product_detail_view.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:search_page/search_page.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    String? token = GetStorage().read('token');
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
                      items: controller.products,
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
                          contentPadding: EdgeInsets.fromLTRB(8, 0, 0, 4),
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
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: 22,
                ),
              ),
              onPressed: () {},
            ),
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.reFetch();
        },
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Obx(() => CarouselSlider(
                                options: CarouselOptions(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    autoPlay: true,
                                    viewportFraction: 0.97,
                                    aspectRatio: 16 / 9),
                                items: controller.carouselList.map((carousel) {
                                  return Container(
                                    child: CachedNetworkImage(
                                      imageUrl: carousel.photo,
                                      imageBuilder: (context, imageProvider) =>
                                          Image(
                                        image: imageProvider,
                                        fit: BoxFit.fitWidth,
                                        width: 600,
                                        alignment: Alignment.center,
                                      ),
                                      placeholder: (context, url) => Center(
                                          child: Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              child: Container(
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ))),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.image_not_supported_rounded,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kategori',
                              style: Styles.headerStyles(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .1 + 3,
                          width: MediaQuery.of(context).size.width * .9,
                          child: Obx(() => ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.category.length,
                              itemBuilder: (context, index) {
                                var category = controller.category[index];

                                return GestureDetector(
                                  onTap: () async {
                                    var categoryDetail = await controller
                                        .categotyDetail(category.id);
                                    print(category.id);

                                    Get.toNamed('category', arguments: [
                                      categoryDetail,
                                      category.title
                                    ]);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, bottom: 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              height: 80,
                                              width: 60,
                                              child: Column(
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: category.photo,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Image(
                                                      image: imageProvider,
                                                      width: 45,
                                                      height: 45,
                                                      color: Colors
                                                          .deepOrange[400],
                                                      fit: BoxFit.fill,
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          LoadingAnimationWidget
                                                              .flickr(
                                                        rightDotColor: Colors
                                                            .grey.shade200,
                                                        leftDotColor:
                                                            const Color(
                                                                0xfffd0079),
                                                        size: 25,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons
                                                          .image_not_supported_rounded,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        category.title,
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Styles.bodyStyle(
                                                            size: 13),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () {
                      if (controller.productsPromo.isEmpty) {
                        return SizedBox();
                      } else {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 2.0, left: 10.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Text(
                                      'Promo Kemerdekaan',
                                      style: Styles.headerStyles(size: 16),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Image.asset(
                                      'assets/images/flag.png',
                                      height: 40,
                                      width: 40,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 180,
                              child: ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.productsPromo.length,
                                itemBuilder: (context, index) {
                                  var product = controller.productsPromo[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      await Fluttertoast.showToast(
                                        msg:
                                            'Mohon tunggu sedang mencari lokasimu',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.grey[800],
                                        textColor: Colors.white,
                                        fontSize: 14.0,
                                      );
                                      await controller.postCurrentLocation();

                                      var productDetails = await controller
                                          .fetchProductDetails(product.id);
                                      Get.toNamed('product-detail-promo',
                                          arguments: [productDetails]);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Card(
                                        child: Container(
                                          width: 140,
                                          padding: const EdgeInsets.all(5),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5.0,
                                                left: 8.0,
                                                right: 8.0,
                                                bottom: 0.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  child: CachedNetworkImage(
                                                    imageUrl: product.photo,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      child: Image(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                        width: 140,
                                                        height: 90,
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Center(
                                                      child:
                                                          LoadingAnimationWidget
                                                              .flickr(
                                                        rightDotColor:
                                                            Colors.black,
                                                        leftDotColor:
                                                            const Color(
                                                                0xfffd0079),
                                                        size: 25,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons
                                                          .image_not_supported_rounded,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0),
                                                  child: Text(
                                                    product.title,
                                                    textAlign: TextAlign.left,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2.0),
                                                  child: Text(
                                                    ' ${controller.convertToIdr(int.parse(product.promo), 0)}',
                                                    textAlign: TextAlign.left,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                        );
                      }
                    },
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Produk yang mungkin anda cari',
                        style: Styles.headerStyles(),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (controller.products.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 20,
                            children: List.generate(6, (index) {
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ));
                            })),
                      );
                    } else {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12),
                          child: MasonryGridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 20,
                              itemCount: controller.products.length,
                              itemBuilder: (context, index) {
                                var product = controller.products[index];

                                return GestureDetector(
                                  onTap: () async {
                                    var productDetails = await controller
                                        .fetchProductDetails(product.id);
                                    Get.toNamed('product-detail',
                                        arguments: [productDetails]);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: product.photo.first,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10.0),
                                              topRight: Radius.circular(10.0),
                                            ),
                                            child: Image(
                                              image: imageProvider,
                                            ),
                                          ),
                                          placeholder: (context, url) => Center(
                                              child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor:
                                                Colors.grey.shade100,
                                            child: Container(
                                              width: 200,
                                              height: 100,
                                              color: Colors.deepOrange[400],
                                            ),
                                          )),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.image_not_supported_rounded,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2, vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      product.title,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          overflow:
                                                              TextOverflow.fade,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                          color: Color.fromRGBO(
                                                              74, 74, 74, 1)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      controller.convertToIdr(
                                                          double.parse(
                                                              product.price),
                                                          0),
                                                      style: const TextStyle(
                                                          fontSize: 14,
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
                                                          double.parse(product
                                                              .priceRetail),
                                                          0),
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.red,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
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
                              }));
                    }
                  }),
                  SizedBox(
                    height: 90,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
