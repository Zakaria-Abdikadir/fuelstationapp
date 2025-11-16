class Employee {
  final int? id;
  final int stationId;
  final String fullName;
  final String email;
  final String phone;
  final String role; // 'Manager', 'Attendant', 'Cashier', etc.
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? lastLogin;

  Employee({
    this.id,
    required this.stationId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    this.isActive = true,
    this.createdAt,
    this.lastLogin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationId': stationId,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'isActive': isActive ? 1 : 0,
      'createdAt': createdAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int?,
      stationId: map['stationId'] as int,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      role: map['role'] as String,
      isActive: (map['isActive'] as int) == 1,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      lastLogin: map['lastLogin'] != null
          ? DateTime.parse(map['lastLogin'] as String)
          : null,
    );
  }

  Employee copyWith({
    int? id,
    int? stationId,
    String? fullName,
    String? email,
    String? phone,
    String? role,
    bool? isActive,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return Employee(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }
}

