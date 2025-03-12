class Unit {
  final int id;
  final String name;
  final String shortName;
  final int conversionFactor;

  Unit({
    required this.id,
    required this.name,
    required this.shortName,
    required this.conversionFactor,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'],
      conversionFactor: json['conversion_factor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'short_name': shortName,
      'conversion_factor': conversionFactor,
    };
  }
}
