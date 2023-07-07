class Product {
  int id;
  String categoryId;
  String title;
  String price;
  String priceRetail;
  String qty;
  String unit;
  String unitVariant;
  String description;
  List<String> photo;
  String createdAt;
  String updatedAt;

  Product({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.priceRetail,
    required this.qty,
    required this.unit,
    required this.unitVariant,
    required this.description,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['category_id'],
      title: json['title'],
      price: json['price'],
      priceRetail: json['price_retail'],
      qty: json['qty'],
      unit: json['unit'],
      unitVariant: json['unit_variant'],
      description: json['description'],
      photo: List<String>.from(json['photo']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
