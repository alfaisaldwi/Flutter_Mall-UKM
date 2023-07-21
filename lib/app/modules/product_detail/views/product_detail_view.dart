import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mall_ukm/app/model/cart/cartItem_model.dart';
import 'package:mall_ukm/app/model/product/product_detail_model.dart';
import 'package:mall_ukm/app/modules/cart/controllers/cart_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:search_page/search_page.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  var controllerProductDetail = Get.put(ProductDetailController());
  var ctrlCart = CartController();
  var productDetails = Get.arguments as List<ProductDetail>;

  @override
  Widget build(BuildContext context) {
    var product = productDetails.first;
    final originalPrice =
        NumberFormat.decimalPattern().format(int.parse(product.price));
    final discountedPrice =
        NumberFormat.decimalPattern().format(int.parse(product.priceRetail));
    final CarouselController controllerCaraousel = CarouselController();

    List people = [
      'Mike',
      'Barron',
      64,
    ];
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            height: 40,
            color: const Color(0xfff7f7f7),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: SearchPage(
                      onQueryUpdate: print,
                      items: people,
                      searchLabel: 'Search people',
                      suggestion: const Center(
                        child: Text('Filter people by name, surname or age'),
                      ),
                      failure: const Center(
                        child: Text('No person found :('),
                      ),
                      filter: (person) => [
                        // person.name,
                        // person.surname,
                        // person.age.toString(),
                      ],
                      sort: (a, b) => a.compareTo(b),
                      builder: (person) => ListTile(
                        title: Text(person.name),
                        subtitle: Text(person.surname),
                        trailing: Text('${person.age} yo'),
                      ),
                    ),
                  );
                },
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
          actions: [
            IconButton(
              icon: GestureDetector(
                onTap: () => (Get.toNamed('/cart')),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              onPressed: () {},
            ),
          ]),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: kToolbarHeight + 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    //WA
                    Get.toNamed('/profile-page');
                  },
                  child: SizedBox(
                    height: kToolbarHeight - 15,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                      child: Text('Chat',
                          textAlign: TextAlign.center,
                          style: Styles.bodyStyle(
                              color: const Color.fromRGBO(36, 54, 101, 1.0),
                              weight: FontWeight.w500,
                              size: 13)),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(36, 54, 101, 1.0),
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: InkWell(
                  onTap: () async {
                    String? token = GetStorage().read('token');
                    if (token != null) {
                      // CartItem cartItem = CartItem(
                      //     product_id: product.id,
                      //     qty: int.parse(product.qty),
                      //     unit_variant: product.unitVariant.first);

                      // await ctrlCart.addToCart(cartItem);
                      showOrderDialog(context);

                      // Get.toNamed(('/cart'));
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
                  child: SizedBox(
                    height: kToolbarHeight - 15,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Center(
                      child: Text(
                        'Tambah Keranjang',
                        style: Styles.bodyStyle(
                            color: Colors.white,
                            weight: FontWeight.w500,
                            size: 13),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 280,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: CarouselSlider(
                          carouselController: controllerCaraousel,
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            aspectRatio: 16 /
                                9, // Sesuaikan dengan rasio aspek gambar Anda
                            viewportFraction: 1,
                            height: double.infinity,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            onPageChanged: controller.onPageChanged,
                          ),
                          items: product.photo.map((url) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: NetworkImage(url),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: const Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Obx(() =>
                            buildIndicator(controller.currentIndex.value)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 15),
                          child: RichText(
                            text: TextSpan(
                              text: 'Rp.$originalPrice',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                              children: [
                                WidgetSpan(
                                  child: Container(
                                    width: 8, // Adjust the width as needed
                                  ),
                                ),
                                TextSpan(
                                  text: 'Rp.$discountedPrice',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 8.0, bottom: 14.0),
                        child: Text(
                          '${product.title}',
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.headerStyles(
                              weight: FontWeight.w400, size: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Detail Produk',
                              style: Styles.headerStyles(
                                  size: 16, weight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Kategori : ${product.category}',
                              style: Styles.bodyStyle(
                                  color: Colors.black54, size: 15),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Stok : ${product.qty}',
                              style: Styles.bodyStyle(
                                  color: Colors.black45, size: 15),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Berat Satuan : ${product.weight}kg',
                              style: Styles.bodyStyle(
                                  color: Colors.black45, size: 15),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Deskripsi Produk',
                          style: Styles.headerStyles(
                              size: 16, weight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          '${product.description}',
                          style: Styles.bodyStyle(
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.blue[50],
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, bottom: 10, left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Rekomendasi untukmu',
                          style: Styles.headerStyles(weight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * .3 - 45,
                        width: double.infinity,
                        child: Obx(() => ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.recomend.length,
                            itemBuilder: (context, index) {
                              var recomend = controller.recomend[index];

                              return GestureDetector(
                                onTap: () {
                                  // Get.to(() => DetailKontentLokalView(),
                                  //     arguments: kontenData[index]);
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
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Image.network(
                                                  recomend.photo.first,
                                                  fit: BoxFit.cover,
                                                  width: 140,
                                                  height: 90,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0),
                                              child: Text(
                                                recomend.title,
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Styles.bodyStyle(
                                                    weight: FontWeight.w600),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 2.0),
                                              child: Text(
                                                'Rp. 5.000.000',
                                                textAlign: TextAlign.left,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    Styles.bodyStyle(size: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
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
  }

  Widget buildIndicator(int currentIndex) {
    var product = productDetails.first;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: product.photo.map((url) {
        int index = product.photo.indexOf(url);
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.blue : Colors.grey,
          ),
        );
      }).toList(),
    );
  }
}

void showOrderDialog(BuildContext context) {
  var productDetails = Get.arguments as List<ProductDetail>;
  var product = productDetails.first;
  RxInt selectQuantity = 0.obs;
  var controllerProductDetail = Get.put(ProductDetailController());
  var ctrlCart = CartController();

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            // Widget konten BottomSheet
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Varian Produk',
                    style: GoogleFonts.roboto(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.unitVariant.map((variant) {
                      return GestureDetector(
                        onTap: () {
                          controllerProductDetail.selectVariant(variant);
                        },
                        child: Obx(() => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: controllerProductDetail
                                            .selectedVariant.value ==
                                        variant
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              child: Obx(() => Text(
                                    variant,
                                    style: TextStyle(
                                      color: controllerProductDetail
                                                  .selectedVariant.value ==
                                              variant
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )),
                            )),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(36, 54, 101, 1.0),
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: InkWell(
                      onTap: () async {
                        String? token = GetStorage().read('token');
                        if (token != null) {
                          if (controllerProductDetail
                              .selectedVariant.value.isNotEmpty) {
                            CartItem cartItem = CartItem(
                                product_id: product.id,
                                qty: 1,
                                unit_variant: controllerProductDetail
                                    .selectedVariant.value);
                            print(
                                controllerProductDetail.selectedVariant.value);
                            await ctrlCart.addToCart(cartItem);

                            Get.toNamed(
                              ('/cart'),
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Silahkan Pilih Varian',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.grey[800],
                              textColor: Colors.white,
                              fontSize: 14.0,
                            );
                          }
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
                      child: SizedBox(
                        height: kToolbarHeight - 15,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Center(
                          child: Text(
                            'Tambah Keranjang',
                            style: Styles.bodyStyle(
                                color: Colors.white,
                                weight: FontWeight.w500,
                                size: 13),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      });
}
