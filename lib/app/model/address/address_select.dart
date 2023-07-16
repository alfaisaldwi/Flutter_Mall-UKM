class AddressSelect {
  final int id;
  final String userId;
  final String username;
  final String phone;
  final String address;
  final String destinationId;
  final String addressDetail;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddressSelect({
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

  factory AddressSelect.fromJson(Map<String, dynamic> json) {
    return AddressSelect(
      id: json['id'],
      userId: json['user_id'],
      username: json['username'],
      phone: json['phone'],
      address: json['address'],
      destinationId: json['destination_id'],
      addressDetail: json['address_detail'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
