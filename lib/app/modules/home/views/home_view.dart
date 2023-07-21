import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/modules/product_detail/views/product_detail_view.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:search_page/search_page.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
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
                      builder: (product) => ListTile(
                        title: Text(product.title),
                        subtitle: Text(product.price),
                        trailing: Text('${product.qty} '),
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
                        Center(
                          child: Obx(() => CarouselSlider(
                                options: CarouselOptions(
                                    autoPlay: true,
                                    viewportFraction: 1,
                                    aspectRatio: 16 / 9),
                                items: controller.carouselList.map((carousel) {
                                  return Container(
                                    child: Image.network(
                                      carousel.photo,
                                      fit: BoxFit.fill,
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
                          height: MediaQuery.of(context).size.height * .1 + 20,
                          width: MediaQuery.of(context).size.width * .9,
                          child: Obx(() => ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.category.length,
                              itemBuilder: (context, index) {
                                var category = controller.category[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => ProductDetailView(),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0, bottom: 4.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 80,
                                            width: 50,
                                            child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Image.network(
                                                    category.photo,
                                                    width: 28,
                                                    height: 30,
                                                    color:
                                                        Colors.deepOrange[600],
                                                    fit: BoxFit.fill,
                                                    alignment: Alignment.center,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      category.title,
                                                      textAlign:
                                                          TextAlign.center,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Styles.bodyStyle(
                                                          size: 10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
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
                      return Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 200,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Data tidak ditemukan',
                              style: Styles.bodyStyle(),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 4,
                        ),
                        itemCount: controller.products.length,
                        itemBuilder: (BuildContext ctx, index) {
                          var product = controller.products[index];
                          final originalPrice = NumberFormat.decimalPattern()
                              .format(int.parse(product.price));
                          final discountedPrice = NumberFormat.decimalPattern()
                              .format(int.parse(product.priceRetail));

                          return GestureDetector(
                            onTap: () async {
                              var productDetails = await controller
                                  .fetchProductDetails(product.id);
                              Get.toNamed('product-detail',
                                  arguments: [productDetails]);
                            },
                            child: Card(
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                padding: const EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, bottom: 4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: AspectRatio(
                                          aspectRatio: 4 / 3,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Image.network(
                                              product.photo.first,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 6.0),
                                        child: Text(
                                          product.title,
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.bodyStyle(
                                              weight: FontWeight.w600),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8,
                                              top: 2.0,
                                              bottom: 2),
                                          child: RichText(
                                            softWrap: true,
                                            text: TextSpan(
                                              text: 'Rp.$originalPrice',
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                              children: [
                                                WidgetSpan(
                                                  child: Container(
                                                    width: 8,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: discountedPrice,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
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
                        },
                      );
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
