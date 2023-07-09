class CartItem {
  int product_id;
  int qty;
  String unit_variant;

  CartItem(
      {required this.product_id,
      required this.qty,
      required this.unit_variant});

  Map<String, dynamic> toJson() {
    return {
      "product_id": product_id,
      "qty": qty,
      "unit_variant": unit_variant,
    };
  }
   factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product_id: json['product_id'],
      qty: json['qty'],
      unit_variant: json['unit_variant']
        );
  }
}
