import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/modules/cart/views/cart_view.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:search_page/search_page.dart';

import '../controllers/recommend_page_controller.dart';

class RecommendPageView extends GetView<RecommendPageController> {
  @override
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
                onTap: () => (Get.to(() => CartView())),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              onPressed: () {},
            ),
          ]),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    'Paling banyak diminati',
                    style: Styles.headerStyles(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .3 - 45,
                    width: double.infinity,
                    child: ListView.builder(
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2.0),
                                          child: Text(
                                            'Rp. 5.000.000',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Styles.bodyStyle(size: 12),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    'Makanan khas daerah',
                    style: Styles.headerStyles(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .3 - 45,
                    width: double.infinity,
                    child: ListView.builder(
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 2.0),
                                          child: Text(
                                            'Rp. 5.000.000',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Styles.bodyStyle(size: 12),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Rekomendasi lainnya',
                      style: Styles.headerStyles(),
                    ),
                  ),
                ),
                GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 2),
                    itemCount: controller.recomend2.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var recomend = controller.recomend[index];
                      final originalPrice = NumberFormat.decimalPattern()
                          .format(int.parse(recomend.price));
                      final discountedPrice = NumberFormat.decimalPattern()
                          .format(int.parse(recomend.priceRetail));

                      return GestureDetector(
                        onTap: () {
                          // Get.to(() => DetailKontentLokalView(),
                          //     arguments: kontenData[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Card(
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              padding: const EdgeInsets.all(5),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.network(
                                            recomend.photo.first,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      child: Text(
                                        recomend.title,
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.bodyStyle(
                                            weight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2.0),
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
                                                  width:
                                                      8, // Adjust the width as needed
                                                ),
                                              ),
                                              TextSpan(
                                                text: '$discountedPrice',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
