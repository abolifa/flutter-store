class Category {
  final int id;
  final int? parentId;
  final String name;
  final String? description;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category? parent;
  final List<Category>? children;

  Category({
    required this.id,
    this.parentId,
    required this.name,
    this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.parent,
    this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      parentId: json['parent_id'],
      name: json['name'],
      description: json['description'] ?? '',
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      parent: json['parent'] != null ? Category.fromJson(json['parent']) : null,
      children: json['children'] != null
          ? (json['children'] as List)
              .map((child) => Category.fromJson(child))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'name': name,
      'description': description,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'parent': parent?.toJson(),
      'children': children?.map((child) => child.toJson()).toList(),
    };
  }
}
