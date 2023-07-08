class CartItem {
  final int productId;
  final int qty;
  final String unitVariant;
  final int total;

  CartItem({
    required this.productId,
    required this.qty,
    required this.unitVariant,
    required this.total,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'qty': qty,
      'unit_variant': unitVariant,
      'total': total,
    };
  }
}
