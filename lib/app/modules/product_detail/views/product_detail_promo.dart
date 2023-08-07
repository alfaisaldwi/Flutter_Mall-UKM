import 'package:carousel_slider/carousel_slider.dart';
import 'package:cart_stepper/cart_stepper.dart';
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
import 'package:mall_ukm/app/modules/home/controllers/home_controller.dart';
import 'package:mall_ukm/app/modules/home/views/search_view.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:search_page/search_page.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailPromoView extends GetView<ProductDetailController> {
  var controllerProductDetail = Get.put(ProductDetailController());
  var productDetails = Get.arguments as List<ProductDetail>;
  final CarouselController controllerCaraousel = CarouselController();
  var homeC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var product = productDetails.first;

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            product.title,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: SearchPage(
                    barTheme: ThemeData.light(useMaterial3: true),
                    onQueryUpdate: print,
                    items: homeC.products,
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
              child: Icon(
                Icons.search,
                size: 22,
                color: Colors.black,
              ),
            ),
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
                  color: const Color.fromRGBO(36, 54, 101, 1.0),
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    String? token = GetStorage().read('token');
                    if (token != null) {
                      homeC.storeOffline();

                      // showOrderDialogOffline(context);
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
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Text('Beli Langsung',
                          textAlign: TextAlign.center,
                          style: Styles.bodyStyle(
                              color: Colors.white,
                              weight: FontWeight.w500,
                              size: 13)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return homeC.postCurrentLocation();
        },
        child: SingleChildScrollView(
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
                                text: controllerProductDetail.convertToIdr(
                                    int.parse(product.promo!), 2),
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
                                    text: controllerProductDetail.convertToIdr(
                                        double.parse(product.price), 2),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Berat Satuan : ${product.weight}gram',
                                style: Styles.bodyStyle(
                                    color: Colors.black45, size: 15),
                              ),
                            ),
                          ),
                          if (homeC.radius == null ||
                              homeC.radius == 0 ||
                              homeC.radius == '' ||
                              homeC.radius == 0.0)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Anda berada dalam radius : Tidak dapat menemukan Lokasi',
                                  style: Styles.bodyStyle(
                                      color: Colors.black45, size: 15),
                                ),
                              ),
                            ),
                          if (homeC.radius != null)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Anda berada dalam radius : ${homeC.radius?.toStringAsFixed(0)} Meter dari lokasi Mall UKM dengan Latitude ${homeC.latitude.value.toStringAsFixed(6)} dan Longitude ${homeC.longitude.value.toStringAsFixed(6)}',
                                  style: Styles.bodyStyle(
                                      color: Colors.black45, size: 14),
                                ),
                              ),
                            ),
                          Divider(),
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
                            product.description,
                            style: Styles.bodyStyle(
                              size: 14,
                            ),
                          ),
                        ),
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
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 10, left: 10),
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
                                  onTap: () async {
                                    // homeC.fetchProductDetails(recomend.id);
                                    var productDetails = await homeC
                                        .fetchProductDetails(recomend.id);
                                    Get.offAndToNamed('/product-detail',
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
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  controllerProductDetail
                                                      .convertToIdr(
                                                          double.parse(
                                                              recomend.price),
                                                          2),
                                                  textAlign: TextAlign.left,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Styles.bodyStyle(
                                                      size: 12),
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

void showOrderDialogOffline(BuildContext context) {
  var productDetails = Get.arguments as List<ProductDetail>;
  var product = productDetails.first;
  RxInt selectQuantity = 0.obs;
  var controllerProductDetail = Get.put(ProductDetailController());

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => CartStepperInt(
                      value: controllerProductDetail.counter.value,
                      size: 22,
                      style: CartStepperStyle(
                        foregroundColor: Colors.black87,
                        activeForegroundColor: Colors.black87,
                        activeBackgroundColor: Colors.white,
                        border: Border.all(color: Colors.grey),
                        radius: const Radius.circular(8),
                        elevation: 0,
                        buttonAspectRatio: 1.5,
                      ),
                      didChangeCount: (count) async {
                        if (count <= int.parse(product.qty)) {
                          controllerProductDetail.counter.value = count;
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Melebihi Stok Produk',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        }
                        print(controllerProductDetail.counter.value = count);
                      })),
                  const SizedBox(height: 16),
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
                            if (int.parse(product.qty) >=
                                controllerProductDetail.counter.value) {
                              print(controllerProductDetail
                                  .selectedVariant.value);

                              var total =
                                  controllerProductDetail.counter.value *
                                      int.parse(product.promo!);
                              var totalBefore =
                                  controllerProductDetail.counter.value *
                                      double.parse(product.price);
                              print(product.id);
                              Get.toNamed('/checkout-offline', arguments: [
                                product.id,
                                product,
                                controllerProductDetail.counter.value,
                                product.promo,
                                controllerProductDetail.selectedVariant.value,
                                total,
                                totalBefore,
                              ]);
                              controllerProductDetail.counter.value = 1;
                              controllerProductDetail.selectedVariant.value =
                                  '';
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Melebihi Stok Produk',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey[800],
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                            }
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
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => CartStepperInt(
                      value: controllerProductDetail.counter.value,
                      size: 22,
                      style: CartStepperStyle(
                        foregroundColor: Colors.black87,
                        activeForegroundColor: Colors.black87,
                        activeBackgroundColor: Colors.white,
                        border: Border.all(color: Colors.grey),
                        radius: const Radius.circular(8),
                        elevation: 0,
                        buttonAspectRatio: 1.5,
                      ),
                      didChangeCount: (count) async {
                        // if (count > controllerProductDetail.counter.value) {
                        if (count <= int.parse(product.qty)) {
                          controllerProductDetail.counter.value = count;
                        } else {
                          Fluttertoast.showToast(
                            msg: 'Melebihi Stok Produk',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                        }
                        print(controllerProductDetail.counter.value = count);
                      })),
                  const SizedBox(height: 16),
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
                            if (int.parse(product.qty) >=
                                controllerProductDetail.counter.value) {
                              CartItem cartItem = CartItem(
                                  product_id: product.id,
                                  qty: controllerProductDetail.counter.value,
                                  unit_variant: controllerProductDetail
                                      .selectedVariant.value);
                              print(controllerProductDetail
                                  .selectedVariant.value);
                              // GetfetchCart();
                              await ctrlCart.addToCart(cartItem);
                              controllerProductDetail.counter.value = 1;
                              controllerProductDetail.selectedVariant.value =
                                  '';
                              Get.toNamed(
                                ('/cart'),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Melebihi Stok Produk',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey[800],
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                            }
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
