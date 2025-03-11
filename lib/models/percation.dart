

class Percation {
  final String address;
  final String city;
  final String street;
  final double? latitude;
  final double? longitude;

  Percation({
    required this.address,
    required this.city,
    required this.street,
    this.latitude,
    this.longitude,
  });

  factory Percation.fromJson(Map<String, dynamic> json) {
    return Percation(
      address: json['address'],
      city: json['city'],
      street: json['street'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
    );
  }
}
