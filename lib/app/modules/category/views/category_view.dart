import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/model/category/category_show.dart';
import 'package:mall_ukm/app/modules/category/views/grid_tile.dart';
import 'package:mall_ukm/app/modules/category/views/shimmergrid.dart';
import 'package:mall_ukm/app/modules/home/controllers/home_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    var homeC = Get.put(HomeController());
    var arguments = Get.arguments;
    var categoryDetail = arguments[0] as CategoryShow;
    var title = arguments[1] as String;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Kategori $title',
          style: Styles.headerStyles(weight: FontWeight.w400, size: 16),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (categoryDetail.products!.isEmpty)
                      Container(
                        height: 600,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Produk dengan kategori ini kosong',
                            style: Styles.headerStyles(weight: FontWeight.w400),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12),
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 6,
                        itemCount: categoryDetail.products?.length,
                        itemBuilder: (context, index) {
                          var category = categoryDetail.products![index];

                          return GestureDetector(
                            onTap: () async {
                              var productDetails = await controller
                                  .fetchProductDetails(category.id);
                              Get.toNamed('product-detail',
                                  arguments: [productDetails]);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 4 / 5,
                                        child: CachedNetworkImage(
                                          imageUrl: category.photo,
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
                                              fit: BoxFit.fitWidth,
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
                                                    category.title,
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
                                                            category.price),
                                                        0),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Color.fromRGBO(
                                                            133, 133, 133, 1)),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    controller.convertToIdr(
                                                        double.parse(category
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
          ],
        ),
      ),
    );
  }
}
