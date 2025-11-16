class StationHours {
  final int? id;
  final int stationId;
  final String dayOfWeek; // 'Monday', 'Tuesday', etc.
  final String? openTime; // Format: 'HH:mm'
  final String? closeTime; // Format: 'HH:mm'
  final bool isOpen24Hours;
  final bool isClosed;

  StationHours({
    this.id,
    required this.stationId,
    required this.dayOfWeek,
    this.openTime,
    this.closeTime,
    this.isOpen24Hours = false,
    this.isClosed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationId': stationId,
      'dayOfWeek': dayOfWeek,
      'openTime': openTime,
      'closeTime': closeTime,
      'isOpen24Hours': isOpen24Hours ? 1 : 0,
      'isClosed': isClosed ? 1 : 0,
    };
  }

  factory StationHours.fromMap(Map<String, dynamic> map) {
    return StationHours(
      id: map['id'] as int?,
      stationId: map['stationId'] as int,
      dayOfWeek: map['dayOfWeek'] as String,
      openTime: map['openTime'] as String?,
      closeTime: map['closeTime'] as String?,
      isOpen24Hours: (map['isOpen24Hours'] as int) == 1,
      isClosed: (map['isClosed'] as int) == 1,
    );
  }

  StationHours copyWith({
    int? id,
    int? stationId,
    String? dayOfWeek,
    String? openTime,
    String? closeTime,
    bool? isOpen24Hours,
    bool? isClosed,
  }) {
    return StationHours(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
      isOpen24Hours: isOpen24Hours ?? this.isOpen24Hours,
      isClosed: isClosed ?? this.isClosed,
    );
  }
}

