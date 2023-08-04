class CheckoutDataOffline {
  int addressId;
  String statusPayment;
  int total;
  List<Map<String, dynamic>> products;

  CheckoutDataOffline({
    required this.addressId,
    required this.statusPayment,
    required this.total,
    required this.products,
  });
  Map<String, dynamic> toJson() {
    return {
      "address_id": addressId,
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
