import 'package:app/models/customer.dart';

class Address {
  final int id;
  final int customerId;

  final Customer customer;
  final String address;
  final String city;
  final String phone;
  final String street;
  final String landmark;
  final double? latitude;
  final double? longitude;
  final bool defaultAddress;

  Address({
    required this.id,
    required this.customerId,
    required this.customer,
    required this.address,
    required this.city,
    required this.phone,
    required this.street,
    required this.landmark,
    this.latitude,
    this.longitude,
    required this.defaultAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      customerId: json['customer_id'],
      customer: Customer.fromJson(json['customer']),
      address: json['address'],
      city: json['city'],
      phone: json['phone'],
      street: json['street'],
      landmark: json['landmark'],
      latitude: json['latitude'] != null
          ? double.tryParse(json['latitude'].toString())
          : null,
      longitude: json['longitude'] != null
          ? double.tryParse(json['longitude'].toString())
          : null,
      defaultAddress: json['default'] == 1, // Convert int to bool
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customer_id': customerId,
        'customer': customer.toJson(),
        'address': address,
        'city': city,
        'phone': phone,
        'street': street,
        'landmark': landmark,
        'latitude': latitude,
        'longitude': longitude,
        'default': defaultAddress,
      };

  // copyWith()
  Address copyWith({
    int? id,
    int? customerId,
    Customer? customer,
    String? address,
    String? city,
    String? phone,
    String? street,
    String? landmark,
    double? latitude,
    double? longitude,
    bool? defaultAddress,
  }) {
    return Address(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customer: customer ?? this.customer,
      address: address ?? this.address,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      street: street ?? this.street,
      landmark: landmark ?? this.landmark,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      defaultAddress: defaultAddress ?? this.defaultAddress,
    );
  }
}
