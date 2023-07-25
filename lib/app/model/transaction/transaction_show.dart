class TransactionShow {
  final int? id;
  final String? userId;
  final String? addressId;
  final String? orderId;
  final String? courier;
  final String? costCourier;
  final String? receiptNumber;
  final String? total;
  final String? paymentUrl;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? userUsernameSender;
  final String? addressUsername;
  final String? addressPhone;
  final String? addressInAddress;
  final String? addressAddressDetail;
  final List<DetailTransaction>? detailTransaction;

  TransactionShow({
    this.id,
    this.userId,
    this.addressId,
    this.orderId,
    this.courier,
    this.costCourier,
    this.receiptNumber,
    this.total,
    this.paymentUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.userUsernameSender,
    this.addressUsername,
    this.addressPhone,
    this.addressInAddress,
    this.addressAddressDetail,
    this.detailTransaction,
  });

  factory TransactionShow.fromJson(Map<String, dynamic> json) {
    var detailTransactions = json['data']['detail_transaction'] as List;
    List<DetailTransaction> transactions = detailTransactions
        .map((detailJson) => DetailTransaction.fromJson(detailJson))
        .toList();

    return TransactionShow(
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
      userUsernameSender: json['user_username_sender'],
      addressUsername: json['address_username'],
      addressPhone: json['address_phone'],
      addressInAddress: json['address_in_address'],
      addressAddressDetail: json['address_address_detail'],
      detailTransaction: transactions,
    );
  }
}

class DetailTransaction {
  final int id;
  final String transactionId;
  final String productId;
  final String qty;
  final String price;
  final String variant;
  final String subtotal;
  final String createdAt;
  final String updatedAt;
  final String productPhoto;
  final String productName;

  DetailTransaction({
    required this.id,
    required this.transactionId,
    required this.productId,
    required this.qty,
    required this.price,
    required this.variant,
    required this.subtotal,
    required this.createdAt,
    required this.updatedAt,
    required this.productPhoto,
    required this.productName,
  });

  factory DetailTransaction.fromJson(Map<String, dynamic> json) {
    return DetailTransaction(
      id: json['id'],
      transactionId: json['transaction_id'],
      productId: json['product_id'],
      qty: json['qty'],
      price: json['price'],
      variant: json['variant'],
      subtotal: json['subtotal'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      productPhoto: json['product_photo'],
      productName: json['product_name'],
    );
  }
}
