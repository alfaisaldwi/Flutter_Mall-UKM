class RecommendProductDetail {
  final int id;
  final int categoryId;
  final String title;
  final String price;
  final String priceRetail;
  final int qty;
  final String weight;
  final int? promo;
  final String unit;
  final List<String> unitVariant;
  final String description;
  final List<String> photo;
  final String createdAt;
  final String updatedAt;

  RecommendProductDetail({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.priceRetail,
    required this.qty,
    required this.weight,
    required this.promo,
    required this.unit,
    required this.unitVariant,
    required this.description,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecommendProductDetail.fromJson(Map<String, dynamic> json) {
    return RecommendProductDetail(
      id: json['id'],
      categoryId: json['category_id'],
      title: json['title'],
      price: json['price'],
      priceRetail: json['price_retail'],
      qty: json['qty'],
      weight: json['weight'],
      promo: json['promo'],
      unit: json['unit'],
      unitVariant: List<String>.from(json['unit_variant']),
      description: json['description'],
      photo: List<String>.from(json['photo']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
