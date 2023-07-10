import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mall_ukm/app/model/cart/cartItem_model.dart';
import 'package:mall_ukm/app/model/product/product_detail_model.dart';
import 'package:mall_ukm/app/model/product/product_model.dart';
import 'package:mall_ukm/app/modules/cart/controllers/cart_controller.dart';
import 'package:mall_ukm/app/modules/cart/views/cart_view.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:search_page/search_page.dart';
import 'package:intl/intl.dart';
import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    var ctrlCart = CartController();
    var productDetails = Get.arguments as List<ProductDetail>;
    var product = productDetails.first;
    final numberFormat =
        NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    final originalPrice = product.price;
    final discountedPrice = product.priceRetail;
    List<String> imageUrls = [];
    imageUrls = product.photo;
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
                    CartItem cartItem = CartItem(
                        product_id: product.id,
                        qty: int.parse(product.qty),
                        unit_variant: product.unitVariant.first);

                    await ctrlCart.addToCart(cartItem);
                    Get.toNamed(('/cart'));
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
                      height: 300,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Image.network(
                              product.photo.first,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: RichText(
                            text: TextSpan(
                              text: originalPrice,
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
                                  text: discountedPrice,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
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
                              'Kategori ${product.category}',
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
                              'Berat Satuan : ${product.weight}',
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
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (context, index) {
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
                                                  "https://paulkingart.com/wp-content/uploads/2019/07/Kurt-Cobain-1993_PWK.jpg",
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
                                                'Dataa Produk Art Kurt D. Cobain ',
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
                            }),
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
}
