import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/style/styles.dart';

import '../controllers/recommend_page_controller.dart';

class RecommendPageView extends GetView<RecommendPageController> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 80),
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
                SizedBox(
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
                            padding: const EdgeInsets.only(left: 10.0),
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 4.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
