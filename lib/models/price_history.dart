class PriceHistory {
  final int? id;
  final int stationId;
  final String fuelType; // 'Petrol' or 'Diesel'
  final double pricePerLiter;
  final DateTime updatedAt;
  final String? updatedBy; // User email or system

  PriceHistory({
    this.id,
    required this.stationId,
    required this.fuelType,
    required this.pricePerLiter,
    required this.updatedAt,
    this.updatedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationId': stationId,
      'fuelType': fuelType,
      'pricePerLiter': pricePerLiter,
      'updatedAt': updatedAt.toIso8601String(),
      'updatedBy': updatedBy,
    };
  }

  factory PriceHistory.fromMap(Map<String, dynamic> map) {
    return PriceHistory(
      id: map['id'] as int?,
      stationId: map['stationId'] as int,
      fuelType: map['fuelType'] as String,
      pricePerLiter: map['pricePerLiter'] as double,
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      updatedBy: map['updatedBy'] as String?,
    );
  }
}

