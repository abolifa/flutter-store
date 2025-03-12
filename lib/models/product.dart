import 'package:app/models/brand.dart';
import 'package:app/models/unit.dart';

class Product {
  final int id;
  final String name;
  final String? description;
  final String stockType;
  final bool active;
  final bool returnable;
  final int brandId;
  final Brand brand;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductVariant> variants;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.stockType,
    required this.active,
    required this.returnable,
    required this.brandId,
    required this.brand,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.variants,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      stockType: json['stock_type'],
      active: json['active'] == 1,
      returnable: json['returnable'] == 1,
      brandId: json['brand_id'],
      brand: Brand.fromJson(json['brand']),
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      variants: (json['variants'] != null)
          ? List<ProductVariant>.from(
              json['variants'].map(
                (variant) => ProductVariant.fromJson(variant),
              ),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stock_type': stockType,
      'active': active,
      'returnable': returnable,
      'brand_id': brandId,
      'brand': brand.toJson(),
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'variants': variants.map((variant) => variant.toJson()).toList(),
    };
  }

  Product copyWith({required List<ProductVariant> variants}) {
    return Product(
      id: id,
      name: name,
      description: description,
      stockType: stockType,
      active: active,
      returnable: returnable,
      brandId: brandId,
      brand: brand,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
      variants: variants,
    );
  }
}

class ProductVariant {
  final int id;
  final int productId;
  final int unitId;
  final Unit unit;
  final double measurement;
  final String? color;
  final double price;
  final double discount;
  final int quantity;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductVariant({
    required this.id,
    required this.productId,
    required this.unitId,
    required this.unit,
    required this.measurement,
    this.color,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'],
      productId: json['product_id'],
      unitId: json['unit_id'],
      unit: Unit.fromJson(json['unit']),
      measurement: double.parse(json['measurement']),
      // Ensure conversion
      color: json['color'],
      price: double.parse(json['price']),
      // Ensure conversion
      discount: double.parse(json['discount']),
      // Ensure conversion
      quantity: json['quantity'] ?? 0,
      // Handle potential null values
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'unit_id': unitId,
      'measurement': measurement,
      'color': color,
      'price': price,
      'discount': discount,
      'quantity': quantity,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
