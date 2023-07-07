class Category {
  int id;
  String title;
  String createdAt;
  String updatedAt;

  Category({required this.id, required this.title, required this.createdAt, required this.updatedAt});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}