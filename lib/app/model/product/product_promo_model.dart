class ProductPromo {
  final int id;
  final String title;
  final String price;
  final String priceRetail;
  final String qty;
  final String weight;
  final int promo;
  final String unit;
  final List<String> unitVariant;
  final String description;
  final String photo;

  ProductPromo({
    required this.id,
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
  });

  factory ProductPromo.fromJson(Map<String, dynamic> json) {
    return ProductPromo(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      priceRetail: json['price_retail'],
      qty: json['qty'],
      weight: json['weight'],
      promo: json['promo'],
      unit: json['unit'],
      unitVariant: List<String>.from(json['unit_variant']),
      description: json['description'],
      photo: json['photo'][0], // Assuming only one photo for simplicity
    );
  }
}
