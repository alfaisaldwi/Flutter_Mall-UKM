import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryShow {
  final int? id;
  final String? title;
  final String? photo;
  final String? createdAt;
  final String? updatedAt;
  final List<CategoryProductDetail>? products;

  CategoryShow({
    this.id,
    this.title,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory CategoryShow.fromJson(Map<String, dynamic> json) {
    var productsData = json['data']['products'] as List;
    List<CategoryProductDetail> products = productsData
        .map((product) => CategoryProductDetail.fromJson(product))
        .toList();

    return CategoryShow(
      id: json['id'],
      title: json['title'],
      photo: json['photo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      products: products,
    );
  }
}

class CategoryProductDetail {
  final int id;
  final int categoryId;
  final String title;
  final String price;
  final String priceRetail;
  final int qty;
  final String weight;
  final String unit;
  final String unitVariant;
  final String description;
  final String photo;
  final String createdAt;
  final String updatedAt;

  CategoryProductDetail({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.priceRetail,
    required this.qty,
    required this.weight,
    required this.unit,
    required this.unitVariant,
    required this.description,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryProductDetail.fromJson(Map<String, dynamic> json) {
    return CategoryProductDetail(
      id: json['id'],
      categoryId: int.parse(json['category_id'].toString()),
      title: json['title'],
      price: json['price'],
      priceRetail: json['price_retail'],
      qty: json['qty'],
      weight: json['weight'],
      unit: json['unit'],
      unitVariant: json['unit_variant'],
      description: json['description'],
      photo: json['photo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
