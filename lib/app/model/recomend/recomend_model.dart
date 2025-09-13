class Recomend {
  int? id;
  String? title;
  String? photo;
  List<ProductRecomend>? products;

  Recomend({this.id, this.title, this.photo, this.products});

  factory Recomend.fromJson(Map<String, dynamic> json) {
    var productList = json['products'] as List;
    List<ProductRecomend> products =
        productList.map((e) => ProductRecomend.fromJson(e)).toList();

    return Recomend(
      id: json['id'],
      title: json['title'],
      photo: json['photo'],
      products: products,
    );
  }
}

class ProductRecomend {
  int? id;
  int? categoryId;
  String? title;
  String? price;
  String? priceRetail;
  int? qty;
  String? weight;
  int? promo;
  String? unit;
  String? unitVariant;
  String? description;
  String? photo;

  ProductRecomend({
    this.id,
    this.categoryId,
    this.title,
    this.price,
    this.priceRetail,
    this.qty,
    this.weight,
    this.promo,
    this.unit,
    this.unitVariant,
    this.description,
    this.photo,
  });

  factory ProductRecomend.fromJson(Map<String, dynamic> json) {
    return ProductRecomend(
      id: json['id'],
      categoryId: int.parse(json['category_id'].toString()),
      title: json['title'],
      price: json['price'],
      priceRetail: json['price_retail'],
      qty: json['qty'],
      weight: json['weight'],
      promo: json['promo'],
      unit: json['unit'],
      unitVariant: json['unit_variant'],
      description: json['description'],
      photo: json['photo'],
    );
  }
}
