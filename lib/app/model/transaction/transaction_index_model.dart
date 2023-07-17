class Transaction {
  final int id;
  final String userId;
  final String addressId;
  final String orderId;
  final String courier;
  final String costCourier;
  final String? receiptNumber;
  final String total;
  final String paymentUrl;
  final String status;
  final String createdAt;
  final String updatedAt;
  final List<DetailTransaction> detailTransactions;

  Transaction({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.orderId,
    required this.courier,
    required this.costCourier,
    required this.receiptNumber,
    required this.total,
    required this.paymentUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.detailTransactions,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    List<dynamic> detailTransactionsJson = json['detail_transaction'];

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
      detailTransactions: List<DetailTransaction>.from(detailTransactionsJson.map((json) => DetailTransaction.fromJson(json))),
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
    );
  }
}
