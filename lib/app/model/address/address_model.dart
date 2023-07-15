class Address {
  String username;
  String phone;
  String address;
  int destinationId;
  String addressDetail;
  String status;

  Address({
    required this.username,
    required this.phone,
    required this.address,
    required this.destinationId,
    required this.addressDetail,
    required this.status,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      username: json['username'],
      phone: json['phone'],
      address: json['address'],
      destinationId: json['destination_id'],
      addressDetail: json['address_detail'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'phone': phone,
      'address': address,
      'destination_id': destinationId,
      'address_detail': addressDetail,
      'status': status,
    };
  }
}
