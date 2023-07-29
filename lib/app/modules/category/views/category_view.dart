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
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                    ),
                                    child: Image.network(category.photo),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                category.title,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    overflow: TextOverflow.fade,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        74, 74, 74, 1)),
                                              ),
                                            ),
                                            // IconButton(
                                            //     onPressed: () {},
                                            //     icon: const Icon(
                                            //       Icons.arrow_forward_outlined,
                                            //       color: Colors.teal,
                                            //     ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                controller.convertToIdr(
                                                    double.parse(
                                                        category.price),
                                                    2),
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
                                                    double.parse(
                                                        category.priceRetail),
                                                    2),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red,
                                                    decoration: TextDecoration
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
