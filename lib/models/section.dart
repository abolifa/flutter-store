class Section {
  final int id;
  final String title;
  final String shortDescription;
  final List<String>? categories; // Change to List<String>
  final List<dynamic>? products;
  final String productType;
  final DateTime createdAt;
  final DateTime updatedAt;

  Section({
    required this.id,
    required this.title,
    required this.shortDescription,
    this.categories,
    this.products,
    required this.productType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'],
      title: json['title'],
      shortDescription: json['short_description'],
      categories: json['categories'] != null
          ? List<String>.from(json['categories'])
          : null,
      products: json['products'] != null
          ? List<dynamic>.from(json['products'])
          : null,
      productType: json['product_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'short_description': shortDescription,
      'categories': categories,
      // No need to map since it's already List<String>
      'products': products,
      'product_type': productType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
