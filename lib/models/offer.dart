import 'package:app/models/brand.dart';
import 'package:app/models/category.dart';

class Offer {
  final int id;
  final String type;
  final int? categoryId;
  final int? brandId;
  final Category? category;
  final Brand? brand;
  final double discount;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String position;

  Offer({
    required this.id,
    required this.type,
    this.categoryId,
    required this.position,
    this.brandId,
    this.category,
    this.brand,
    required this.discount,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      type: json['type'],
      categoryId: json['category_id'],
      brandId: json['brand_id'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      discount: (json['discount'] is int) // Check if it's an int
          ? (json['discount'] as int).toDouble() // Convert int to double
          : double.tryParse(json['discount'].toString()) ?? 0.0,
      // Handle String and null
      image: json['image'],
      position: json['position'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'category_id': categoryId,
      'brand_id': brandId,
      'position': position,
      'category': category?.toJson(),
      'brand': brand?.toJson(),
      'discount': discount,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
