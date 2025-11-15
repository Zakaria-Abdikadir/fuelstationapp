class Fuel {
  final int? id;
  final int stationId;
  final String fuelType; // 'Petrol' or 'Diesel'
  final double pricePerLiter;
  final double stockInLiters;
  final DateTime? lastUpdated;

  Fuel({
    this.id,
    required this.stationId,
    required this.fuelType,
    required this.pricePerLiter,
    required this.stockInLiters,
    this.lastUpdated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationId': stationId,
      'fuelType': fuelType,
      'pricePerLiter': pricePerLiter,
      'stockInLiters': stockInLiters,
      'lastUpdated': lastUpdated?.toIso8601String(),
    };
  }

  factory Fuel.fromMap(Map<String, dynamic> map) {
    return Fuel(
      id: map['id'] as int?,
      stationId: map['stationId'] as int,
      fuelType: map['fuelType'] as String,
      pricePerLiter: map['pricePerLiter'] as double,
      stockInLiters: map['stockInLiters'] as double,
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.parse(map['lastUpdated'] as String)
          : null,
    );
  }

  Fuel copyWith({
    int? id,
    int? stationId,
    String? fuelType,
    double? pricePerLiter,
    double? stockInLiters,
    DateTime? lastUpdated,
  }) {
    return Fuel(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      fuelType: fuelType ?? this.fuelType,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      stockInLiters: stockInLiters ?? this.stockInLiters,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

