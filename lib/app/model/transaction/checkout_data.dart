class CheckoutData {
  int addressId;
  String courier;
  int costCourier;
  String statusPayment;
  int total;
  List<Map<String, dynamic>> products;

  CheckoutData({
    required this.addressId,
    required this.courier,
    required this.costCourier,
    required this.statusPayment,
    required this.total,
    required this.products,
  });
  Map<String, dynamic> toJson() {
    return {
      "address_id": addressId,
      "courier": courier,
      "cost_courier": costCourier,
      "status_payment": statusPayment,
      "total": total,
      "products": products,
    };
  }
}

class Product {
  int id;
  int productId;
  int price;
  int quantity;
  String variant;

  Product({
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.variant,
  });
}
