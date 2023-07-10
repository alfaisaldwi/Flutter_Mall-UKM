class ProductDetail {
  int id;
  String categoryId;
  String title;
  String price;
  String priceRetail;
  String qty;
  String weight;
  String unit;
  String category;
  List<String> unitVariant;
  String description;
  List<String> photo;
  DateTime createdAt;
  DateTime updatedAt;
  int discount;
  String status;

  ProductDetail({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.priceRetail,
    required this.qty,
    required this.weight,
    required this.unit,
    required this.category,
    required this.unitVariant,
    required this.description,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.discount,
    required this.status,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      categoryId: json['category_id'],
      title: json['title'],
      price: json['price'],
      priceRetail: json['price_retail'],
      qty: json['qty'],
      weight: json['weight'],
      unit: json['unit'],
      category: json['category'],
      unitVariant: List<String>.from(json['unit_variant']),
      description: json['description'],
      photo: List<String>.from(json['photo']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      discount: json['discount'],
      status: json['status'],
    );
  }
}
