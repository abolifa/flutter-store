class Customer {
  final int id;
  final String name;
  final String? email;
  final bool active;
  final String? avatar;

  Customer({
    required this.id,
    required this.name,
    this.email,
    required this.active,
    this.avatar,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      email: json['email'] ?? '',
      active: json['active'] == 1,
      avatar: json['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'active': active,
        'avatar': avatar,
      };
}
