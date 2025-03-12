class SliderModal {
  final int id;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  SliderModal({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SliderModal.fromJson(Map<String, dynamic> json) {
    return SliderModal(
      id: json['id'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
