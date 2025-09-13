class Product {
  int id;
  int? categoryId;
  String title;
  String price;
  String priceRetail;
  int qty;
  String unit;
  List<String>? unitVariant;
  String description;
  List<String> photo;
  DateTime createdAt;
  DateTime updatedAt;

  Product({
    required this.id,
    this.categoryId,
    required this.title,
    required this.price,
    required this.priceRetail,
    required this.qty,
    required this.unit,
    this.unitVariant,
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
      unitVariant: (json['unit_variant'] as List<dynamic>?)?.cast<String>(),
      description: json['description'],
      photo: (json['photo'] as List<dynamic>).cast<String>(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
