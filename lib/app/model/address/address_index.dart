class AddressIndex {
  int id;
  String userId;
  String username;
  String phone;
  String address;
  int destinationId; // Perubahan tipe data
  String addressDetail;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  AddressIndex({
    required this.id,
    required this.userId,
    required this.username,
    required this.phone,
    required this.address,
    required this.destinationId,
    required this.addressDetail,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddressIndex.fromJson(Map<String, dynamic> json) {
    return AddressIndex(
      id: json['id'],
      userId: json['user_id'],
      username: json['username'],
      phone: json['phone'],
      address: json['address'],
      destinationId: int.parse(json['destination_id']), // Parsing ke tipe int
      addressDetail: json['address_detail'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
