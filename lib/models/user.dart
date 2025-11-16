enum UserRole {
  stationOwner,
  customer,
}

extension UserRoleExtension on UserRole {
  String get value {
    switch (this) {
      case UserRole.stationOwner:
        return 'station_owner';
      case UserRole.customer:
        return 'customer';
    }
  }

  String get displayName {
    switch (this) {
      case UserRole.stationOwner:
        return 'Station Owner';
      case UserRole.customer:
        return 'Customer';
    }
  }

  static UserRole fromString(String value) {
    switch (value) {
      case 'station_owner':
        return UserRole.stationOwner;
      case 'customer':
        return UserRole.customer;
      default:
        return UserRole.customer;
    }
  }
}

class User {
  final int? id;
  final String email;
  final String password; // In production, this should be hashed
  final String fullName;
  final String phone;
  final UserRole role;
  final int? stationId; // For station owners, links to their station
  final DateTime? createdAt;
  final DateTime? lastLogin;

  User({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    required this.role,
    this.stationId,
    this.createdAt,
    this.lastLogin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'fullName': fullName,
      'phone': phone,
      'role': role.value,
      'stationId': stationId,
      'createdAt': createdAt?.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      email: map['email'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      phone: map['phone'] as String,
      role: UserRoleExtension.fromString(map['role'] as String),
      stationId: map['stationId'] as int?,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'] as String)
          : null,
      lastLogin: map['lastLogin'] != null
          ? DateTime.parse(map['lastLogin'] as String)
          : null,
    );
  }

  User copyWith({
    int? id,
    String? email,
    String? password,
    String? fullName,
    String? phone,
    UserRole? role,
    int? stationId,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      stationId: stationId ?? this.stationId,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
    );
  }

  // Remove password from JSON for security
  Map<String, dynamic> toMapWithoutPassword() {
    final map = toMap();
    map.remove('password');
    return map;
  }
}

