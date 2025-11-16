class Promotion {
  final int? id;
  final int stationId;
  final String title;
  final String description;
  final String fuelType; // 'Petrol', 'Diesel', or 'All'
  final double discountPercent; // 0-100
  final double? discountAmount; // Fixed discount amount
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final DateTime? createdAt;

  Promotion({
    this.id,
    required this.stationId,
    required this.title,
    required this.description,
    required this.fuelType,
    this.discountPercent = 0.0,
    this.discountAmount,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationId': stationId,
      'title': title,
      'description': description,
      'fuelType': fuelType,
      'discountPercent': discountPercent,
      'discountAmount': discountAmount,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory Promotion.fromMap(Map<String, dynamic> map) {
    return Promotion(
      id: map['id'] as int?,
      stationId: map['stationId'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      fuelType: map['fuelType'] as String,
      discountPercent: map['discountPercent'] as double? ?? 0.0,
      discountAmount: map['discountAmount'] as double?,
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: DateTime.parse(map['endDate'] as String),
      isActive: (map['isActive'] as int) == 1,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
    );
  }

  Promotion copyWith({
    int? id,
    int? stationId,
    String? title,
    String? description,
    String? fuelType,
    double? discountPercent,
    double? discountAmount,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Promotion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      title: title ?? this.title,
      description: description ?? this.description,
      fuelType: fuelType ?? this.fuelType,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

