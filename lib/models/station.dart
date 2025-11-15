class Station {
  final int? id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final double petrolPrice;
  final double dieselPrice;
  final bool isActive;
  final DateTime? createdAt;

  Station({
    this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.petrolPrice,
    required this.dieselPrice,
    this.isActive = true,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'petrolPrice': petrolPrice,
      'dieselPrice': dieselPrice,
      'isActive': isActive ? 1 : 0,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      id: map['id'] as int?,
      name: map['name'] as String,
      address: map['address'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      petrolPrice: map['petrolPrice'] as double,
      dieselPrice: map['dieselPrice'] as double,
      isActive: (map['isActive'] as int) == 1,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
    );
  }

  Station copyWith({
    int? id,
    String? name,
    String? address,
    double? latitude,
    double? longitude,
    double? petrolPrice,
    double? dieselPrice,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Station(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      petrolPrice: petrolPrice ?? this.petrolPrice,
      dieselPrice: dieselPrice ?? this.dieselPrice,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

