import 'package:flutter/material.dart';
import 'package:mall_ukm/app/component/search_view.dart';
import 'package:mall_ukm/app/style/styles.dart';
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

class SearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 34,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Styles.colorPrimary()),
      ),
      child: TextField(
        enabled: false,
        textAlign: TextAlign.justify,
        decoration: InputDecoration(
          fillColor: Colors.white,
          border:
              InputBorder.none, // Hapus border pada input decoration TextField
          hintText: 'Cari Produk',
          hintStyle: TextStyle(fontSize: 15, color: Styles.colorPrimary()),
          prefixIcon: Icon(
            Icons.search_outlined,
            color: Styles.colorPrimary(),
            size: 16,
          ),
        ),
      ),
    );
  }
}
