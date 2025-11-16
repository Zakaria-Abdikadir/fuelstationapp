class PaymentMethod {
  final int? id;
  final int stationId;
  final String methodName; // 'M-Pesa', 'Card', 'Cash', 'Bank Transfer', etc.
  final bool isEnabled;
  final String? accountDetails; // Account number, phone number, etc.
  final DateTime? createdAt;

  PaymentMethod({
    this.id,
    required this.stationId,
    required this.methodName,
    this.isEnabled = true,
    this.accountDetails,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationId': stationId,
      'methodName': methodName,
      'isEnabled': isEnabled ? 1 : 0,
      'accountDetails': accountDetails,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as int?,
      stationId: map['stationId'] as int,
      methodName: map['methodName'] as String,
      isEnabled: (map['isEnabled'] as int) == 1,
      accountDetails: map['accountDetails'] as String?,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
    );
  }

  PaymentMethod copyWith({
    int? id,
    int? stationId,
    String? methodName,
    bool? isEnabled,
    String? accountDetails,
    DateTime? createdAt,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      methodName: methodName ?? this.methodName,
      isEnabled: isEnabled ?? this.isEnabled,
      accountDetails: accountDetails ?? this.accountDetails,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

