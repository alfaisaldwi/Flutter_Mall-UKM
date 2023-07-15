class CarouselIndex {
  final int id;
  final String photo;
  final DateTime createdAt;
  final DateTime updatedAt;

  CarouselIndex({
    required this.id,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarouselIndex.fromJson(Map<String, dynamic> json) {
    return CarouselIndex(
      id: json['id'],
      photo: json['photo'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
