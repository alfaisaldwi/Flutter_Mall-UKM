class Transaction {
  final int id;
  final String userId;
  final String addressId;
  final String orderId;
  String? courier;
  String? costCourier;
  String? receiptNumber;
  final String total;
  final String paymentUrl;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String productName;
  final String productQty;
  final String productVariant;
  final String productPhoto;

  Transaction({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.orderId,
    this.courier,
    this.costCourier,
    this.receiptNumber,
    required this.total,
    required this.paymentUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.productName,
    required this.productQty,
    required this.productVariant,
    required this.productPhoto,
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
