import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mall_ukm/app/model/product/product_model.dart';
import 'package:mall_ukm/app/modules/home/controllers/home_controller.dart';
import 'package:mall_ukm/app/style/styles.dart';

class SearchView extends StatelessWidget {
  Product products;

  SearchView({required this.products});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(products.photo.first),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(products.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Stok:  ${products.qty}'),
                  Text('${controller.convertToIdr(double.parse(products.price), 2)}'),
                ],
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () async {
                var productDetails =
                    await controller.fetchProductDetails(products.id);
                Get.toNamed('product-detail', arguments: [productDetails]);
              },
            ),
          ],
        ),
      ),
    );
  }
}


