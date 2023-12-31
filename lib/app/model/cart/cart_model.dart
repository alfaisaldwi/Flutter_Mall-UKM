class Cart {
  int id;
  String userId;
  String productId;
  String unitVariant;
  int qty;
  String createdAt;
  String updatedAt;
  String photo;
  double price;
  double priceRetail;
  String title;
  double weight;

  Cart({
    required this.id,
    required this.userId,
    required this.productId,
    required this.unitVariant,
    required this.qty,
    required this.createdAt,
    required this.updatedAt,
    required this.photo,
    required this.price,
    required this.priceRetail,
    required this.title,
    required this.weight,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['user_id'],
      productId: json['product_id'],
      unitVariant: json['unit_variant'],
      qty: int.parse(json['qty']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      photo: json['photo'],
      price: double.parse(json['price']),
      priceRetail: double.parse(json['price_retail']),
      title: json['title'],
      weight: double.parse(json['weight']),
    );
  }
}
