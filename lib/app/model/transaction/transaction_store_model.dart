class TransaksiStore {
  int? code;
  String? message;
  TransaksiData? data;

  TransaksiStore({required this.code,required this.message,required this.data});

  TransaksiStore.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = (json['data'] != null ? TransaksiData.fromJson(json['data']) : null)!;
  }
}

class TransaksiData {
  int? userId;
  int? addressId;
  String? orderId;
  String? courier;
  int? costCourier;
  dynamic? receiptNumber;
  int? total;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? paymentUrl;
  List<Product>? products;

  TransaksiData(
      {this.userId,
      this.addressId,
      this.orderId,
      this.courier,
      this.costCourier,
      this.receiptNumber,
      this.total,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.paymentUrl,
      this.products});

  TransaksiData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    addressId = json['address_id'];
    orderId = json['order_id'];
    courier = json['courier'];
    costCourier = json['cost_courier'];
    receiptNumber = json['receipt_number'];
    total = json['total'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    paymentUrl = json['payment_url'];
    if (json['products'] != null) {
      products = List<Product>.from(json['products'].map((product) => Product.fromJson(product)));
    }
  }
}

class Product {
  int? id;
  int? productId;
  int? price;
  int? quantity;
  String? variant;

  Product({required this.id,required this.productId,required this.price,required this.quantity,required this.variant});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    price = json['price'];
    quantity = json['quantity'];
    variant = json['variant'];
  }
}
