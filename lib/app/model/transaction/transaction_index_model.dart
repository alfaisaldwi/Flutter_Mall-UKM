class Transaction {
  final int id;
   String? userId;
   String? addressId;
   String? orderId;
  String? courier;
  String? costCourier;
  String? receiptNumber;
   String? total;
   String? paymentUrl;
   String? status;
   String? createdAt;
   String? updatedAt;
   String? productName;
   String? productQty;
   String? productVariant;
   String? productPhoto;

  Transaction({
    required this.id,
     this.userId,
     this.addressId,
    required this.orderId,
    this.courier,
    this.costCourier,
    this.receiptNumber,
     this.total,
     this.paymentUrl,
     this.status,
     this.createdAt,
     this.updatedAt,
     this.productName,
     this.productQty,
     this.productVariant,
     this.productPhoto,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      addressId: json['address_id'],
      orderId: json['order_id'],
      courier: json['courier'],
      costCourier: json['cost_courier'],
      receiptNumber: json['receipt_number'],
      total: json['total'],
      paymentUrl: json['payment_url'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      productName: json['product_name'],
      productQty: json['product_qty'],
      productVariant: json['product_variant'],
      productPhoto: json['product_photo'],
    );
  }

  where(bool Function(dynamic transaction) param0) {}
}
