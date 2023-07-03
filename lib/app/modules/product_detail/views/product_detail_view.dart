import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mall_ukm/app/style/styles.dart';
import 'package:search_page/search_page.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
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
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
                size: 32,
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
                  onTap: () {
                    //add chart
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
                              'https://www.pilar.id/wp-content/uploads/2023/02/A3DF586A-4C1B-446B-9478-4BE82EA6EC14-768x512.jpeg',
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
                        child: Text(
                          'Rp150.000',
                          style: Styles.headerStyles(
                              weight: FontWeight.w500, size: 18),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, top: 8.0, bottom: 14.0),
                        child: Text(
                          'Data Produk Art Kurt Cobain ',
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
                              'Kategori',
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
                              'Stok : ',
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
                              'Berat Satuan : ',
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
                          'IY PAINTING BY NUMBER - SAKURA CASTLE Canvas Size: 50 cm x 40 cm NO FRAME ( PRICE IDR 115K ) 1 lembar canvas berkode warna dan berpola 1 set cat sesuai kode pada canvas 3 pcs kuas lukis FRAMED ( PRICE IDR 165K ) 1 Canvas terpasang inner frame kayu,  berkode warna dan berpola 1 set cat sesuai kode pada canvas 3 pcs kuas lukis * silakan chat ke seller untuk detail n info produk lainnya * tersedia gambar lain, stock banyak Siapa bilang melukis itu susah? Coba DIY PAINT BY NUMBER dijual sudah lengkap dgn tools, hanya tinggal oles saja siapapun bisa menghasilkan lukisan seperti pelukis profesional... Painting By Numbers adalah produk yang sangat seru untuk semua umur, ideal digunakan untuk anak-anak maupun orang dewasa, pemula juga pasti bisa..',
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
