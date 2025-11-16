class Receipt {
  final int? id;
  final int stationId;
  final String stationName;
  final String fuelType;
  final double quantity; // in liters
  final double pricePerLiter;
  final double totalAmount;
  final String paymentMethod; // 'M-Pesa', 'Card', 'Cash'
  final String transactionId;
  final DateTime transactionDate;
  final String? customerName;
  final String? customerPhone;
  final int? customerId;

  Receipt({
    this.id,
    required this.stationId,
    required this.stationName,
    required this.fuelType,
    required this.quantity,
    required this.pricePerLiter,
    required this.totalAmount,
    required this.paymentMethod,
    required this.transactionId,
    required this.transactionDate,
    this.customerName,
    this.customerPhone,
    this.customerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationId': stationId,
      'stationName': stationName,
      'fuelType': fuelType,
      'quantity': quantity,
      'pricePerLiter': pricePerLiter,
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'transactionDate': transactionDate.toIso8601String(),
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerId': customerId,
    };
  }

  factory Receipt.fromMap(Map<String, dynamic> map) {
    return Receipt(
      id: map['id'] as int?,
      stationId: map['stationId'] as int,
      stationName: map['stationName'] as String,
      fuelType: map['fuelType'] as String,
      quantity: map['quantity'] as double,
      pricePerLiter: map['pricePerLiter'] as double,
      totalAmount: map['totalAmount'] as double,
      paymentMethod: map['paymentMethod'] as String,
      transactionId: map['transactionId'] as String,
      transactionDate: DateTime.parse(map['transactionDate'] as String),
      customerName: map['customerName'] as String?,
      customerPhone: map['customerPhone'] as String?,
      customerId: map['customerId'] as int?,
    );
  }

  Receipt copyWith({
    int? id,
    int? stationId,
    String? stationName,
    String? fuelType,
    double? quantity,
    double? pricePerLiter,
    double? totalAmount,
    String? paymentMethod,
    String? transactionId,
    DateTime? transactionDate,
    String? customerName,
    String? customerPhone,
    int? customerId,
  }) {
    return Receipt(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      stationName: stationName ?? this.stationName,
      fuelType: fuelType ?? this.fuelType,
      quantity: quantity ?? this.quantity,
      pricePerLiter: pricePerLiter ?? this.pricePerLiter,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
      transactionDate: transactionDate ?? this.transactionDate,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerId: customerId ?? this.customerId,
    );
  }
}

