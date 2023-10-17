import 'package:flutter/material.dart';
import 'package:mall_ukm/app/component/search_view.dart';
import 'package:search_page/search_page.dart';

class SearchWidget {
  static showCustomSearch(BuildContext context, List<dynamic> products) {
    showSearch(
      context: context,
      delegate: SearchPage(
        barTheme: ThemeData.light(useMaterial3: true),
        onQueryUpdate: print,
        items: products,
        searchLabel: 'Cari..',
        suggestion: const Center(
          child: Text('Cari produk yang kamu kebutuhan'),
        ),
        failure: const Center(
          child: Text('Produk yang kamu cari tidak ada :('),
        ),
        filter: (product) {
          return [
            product.title,
          ];
        },
        builder: (product) => SearchView(
          products: product,
        ),
      ),
    );
  }
}