import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/modules/cart/views/cart_view.dart';
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Column(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: CustomCarouselSlider(
                            items: controller.itemList,
                            height: 180,
                            subHeight: 0,
                            width: MediaQuery.of(context).size.width * .9 + 10,
                            autoplay: true,
                          ),
                        ),
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
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (context, index) {
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
                                              Image.network(
                                                "https://cdn.iconscout.com/icon/premium/png-512-thumb/clothes-20-185191.png",
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.fill,
                                                alignment: Alignment.center,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Fashion Wanita',
                                                  textAlign: TextAlign.left,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Styles.bodyStyle2(),
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
                            }),
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
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 2),
                    itemCount: 8,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ProductDetailView(),
                          );
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
                                            "https://www.pilar.id/wp-content/uploads/2023/02/A3DF586A-4C1B-446B-9478-4BE82EA6EC14-768x512.jpeg",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      child: Text(
                                        'Data Produk Kurt D. Cobain',
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
                                      child: Text(
                                        'Rp. 500.000',
                                        textAlign: TextAlign.left,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Styles.bodyStyle(),
                                      ),
                                    ),
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
