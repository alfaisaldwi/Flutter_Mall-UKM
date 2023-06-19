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
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomCarouselSlider(
                      items: controller.itemList,
                      height: 180,
                      subHeight: 0,
                      width: MediaQuery.of(context).size.width * .9,
                      autoplay: true,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  'Produk hari ini',
                  style: Styles.headerStyles(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .3 - 30,
                  width: MediaQuery.of(context).size.width * .9,
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
                          child: Card(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      "https://scontent.fbdo8-1.fna.fbcdn.net/v/t39.30808-6/241471008_415928503283085_261101322942725413_n.png?_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeFCSGxrdskCW7kZOKXhmlB4SVIeRwFHkhtJUh5HAUeSG7Jzaz9y89DHKXMUTiOAXler-aGRfYtTZ3uRl_F9XYqr&_nc_ohc=67wM9UY9CaIAX9iwslF&_nc_zt=23&_nc_ht=scontent.fbdo8-1.fna&oh=00_AfCYpA451sbMesPMujQUyHY9pjzBBFtoqLJnR6o96z_Nbg&oe=6494BE32",
                                      width: 100,
                                      height: 140,
                                      fit: BoxFit.fill,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      'Dataa Produk',
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const Text(
                                      'Rp. 500.000',
                                      textAlign: TextAlign.left,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
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
