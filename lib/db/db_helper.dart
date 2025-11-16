import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/fuel.dart';
import '../models/receipt.dart';
import '../models/station.dart';
import '../models/user.dart';
import '../models/price_history.dart';
import '../models/employee.dart';
import '../models/station_hours.dart';
import '../models/promotion.dart';
import '../models/payment_method.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static const String _dbName = 'fuel_station.db';
  static const String _backupFileName = 'fuel_station_backup.json';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);

      return await openDatabase(
        path,
        version: 3, // Incremented for new features
        onCreate: _createDB,
        onUpgrade: _onUpgrade,
      );
    } catch (e) {
      debugPrint('Error initializing database: $e');
      rethrow;
    }
  }

  Future<void> _createDB(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        fullName TEXT NOT NULL,
        phone TEXT NOT NULL,
        role TEXT NOT NULL,
        stationId INTEGER,
        createdAt TEXT,
        lastLogin TEXT,
        FOREIGN KEY (stationId) REFERENCES stations (id)
      )
    ''');

    // Stations table
    await db.execute('''
      CREATE TABLE stations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL,
        petrolPrice REAL NOT NULL,
        dieselPrice REAL NOT NULL,
        isActive INTEGER NOT NULL DEFAULT 1,
        createdAt TEXT
      )
    ''');

    // Fuel table
    await db.execute('''
      CREATE TABLE fuel (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stationId INTEGER NOT NULL,
        fuelType TEXT NOT NULL,
        pricePerLiter REAL NOT NULL,
        stockInLiters REAL NOT NULL,
        lastUpdated TEXT,
        FOREIGN KEY (stationId) REFERENCES stations (id)
      )
    ''');

    // Receipts table
    await db.execute('''
      CREATE TABLE receipts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stationId INTEGER NOT NULL,
        stationName TEXT NOT NULL,
        fuelType TEXT NOT NULL,
        quantity REAL NOT NULL,
        pricePerLiter REAL NOT NULL,
        totalAmount REAL NOT NULL,
        paymentMethod TEXT NOT NULL,
        transactionId TEXT NOT NULL UNIQUE,
        transactionDate TEXT NOT NULL,
        customerName TEXT,
        customerPhone TEXT,
        customerId INTEGER,
        FOREIGN KEY (stationId) REFERENCES stations (id),
        FOREIGN KEY (customerId) REFERENCES users (id)
      )
    ''');

    // Price history table
    await db.execute('''
      CREATE TABLE price_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stationId INTEGER NOT NULL,
        fuelType TEXT NOT NULL,
        pricePerLiter REAL NOT NULL,
        updatedAt TEXT NOT NULL,
        updatedBy TEXT,
        FOREIGN KEY (stationId) REFERENCES stations (id)
      )
    ''');

    // Employees table
    await db.execute('''
      CREATE TABLE employees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stationId INTEGER NOT NULL,
        fullName TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL,
        role TEXT NOT NULL,
        isActive INTEGER NOT NULL DEFAULT 1,
        createdAt TEXT,
        lastLogin TEXT,
        FOREIGN KEY (stationId) REFERENCES stations (id)
      )
    ''');

    // Station hours table
    await db.execute('''
      CREATE TABLE station_hours (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stationId INTEGER NOT NULL,
        dayOfWeek TEXT NOT NULL,
        openTime TEXT,
        closeTime TEXT,
        isOpen24Hours INTEGER NOT NULL DEFAULT 0,
        isClosed INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (stationId) REFERENCES stations (id)
      )
    ''');

    // Promotions table
    await db.execute('''
      CREATE TABLE promotions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stationId INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        fuelType TEXT NOT NULL,
        discountPercent REAL NOT NULL DEFAULT 0,
        discountAmount REAL,
        startDate TEXT NOT NULL,
        endDate TEXT NOT NULL,
        isActive INTEGER NOT NULL DEFAULT 1,
        createdAt TEXT,
        FOREIGN KEY (stationId) REFERENCES stations (id)
      )
    ''');

    // Payment methods table
    await db.execute('''
      CREATE TABLE payment_methods (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stationId INTEGER NOT NULL,
        methodName TEXT NOT NULL,
        isEnabled INTEGER NOT NULL DEFAULT 1,
        accountDetails TEXT,
        createdAt TEXT,
        FOREIGN KEY (stationId) REFERENCES stations (id)
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add users table
      await db.execute('''
        CREATE TABLE IF NOT EXISTS users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL,
          fullName TEXT NOT NULL,
          phone TEXT NOT NULL,
          role TEXT NOT NULL,
          stationId INTEGER,
          createdAt TEXT,
          lastLogin TEXT,
          FOREIGN KEY (stationId) REFERENCES stations (id)
        )
      ''');

      // Add customerId to receipts if it doesn't exist
      try {
        await db.execute('''
          ALTER TABLE receipts ADD COLUMN customerId INTEGER
        ''');
      } catch (e) {
        // Column might already exist
        debugPrint('Column customerId might already exist: $e');
      }
    }
    
    if (oldVersion < 3) {
      // Add new tables for version 3
      await db.execute('''
        CREATE TABLE IF NOT EXISTS price_history (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          stationId INTEGER NOT NULL,
          fuelType TEXT NOT NULL,
          pricePerLiter REAL NOT NULL,
          updatedAt TEXT NOT NULL,
          updatedBy TEXT,
          FOREIGN KEY (stationId) REFERENCES stations (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS employees (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          stationId INTEGER NOT NULL,
          fullName TEXT NOT NULL,
          email TEXT NOT NULL,
          phone TEXT NOT NULL,
          role TEXT NOT NULL,
          isActive INTEGER NOT NULL DEFAULT 1,
          createdAt TEXT,
          lastLogin TEXT,
          FOREIGN KEY (stationId) REFERENCES stations (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS station_hours (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          stationId INTEGER NOT NULL,
          dayOfWeek TEXT NOT NULL,
          openTime TEXT,
          closeTime TEXT,
          isOpen24Hours INTEGER NOT NULL DEFAULT 0,
          isClosed INTEGER NOT NULL DEFAULT 0,
          FOREIGN KEY (stationId) REFERENCES stations (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS promotions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          stationId INTEGER NOT NULL,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          fuelType TEXT NOT NULL,
          discountPercent REAL NOT NULL DEFAULT 0,
          discountAmount REAL,
          startDate TEXT NOT NULL,
          endDate TEXT NOT NULL,
          isActive INTEGER NOT NULL DEFAULT 1,
          createdAt TEXT,
          FOREIGN KEY (stationId) REFERENCES stations (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS payment_methods (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          stationId INTEGER NOT NULL,
          methodName TEXT NOT NULL,
          isEnabled INTEGER NOT NULL DEFAULT 1,
          accountDetails TEXT,
          createdAt TEXT,
          FOREIGN KEY (stationId) REFERENCES stations (id)
        )
      ''');
    }
  }

  Future<void> _insertSampleData(Database db) async {
    try {
      // Check if data already exists
      final existingStations = await db.query('stations', limit: 1);
      if (existingStations.isNotEmpty) {
        return; // Data already exists, skip insertion
      }

      // Sample stations
      final station1Id = await db.insert('stations', Station(
        name: 'Shell Nairobi West',
        address: 'Nairobi West, Ring Road',
        latitude: -1.2921,
        longitude: 36.8219,
        petrolPrice: 180.50,
        dieselPrice: 170.00,
      ).toMap());

      final station2Id = await db.insert('stations', Station(
        name: 'Total Kasarani',
        address: 'Kasarani Road, Nairobi',
        latitude: -1.2235,
        longitude: 36.8993,
        petrolPrice: 179.00,
        dieselPrice: 169.50,
      ).toMap());

      await db.insert('stations', Station(
        name: 'Kenol Westlands',
        address: 'Westlands Road, Nairobi',
        latitude: -1.2633,
        longitude: 36.8054,
        petrolPrice: 181.00,
        dieselPrice: 171.00,
      ).toMap());

      // Sample users
      await db.insert('users', User(
        email: 'owner@station.com',
        password: 'owner123', // In production, hash passwords
        fullName: 'Station Owner',
        phone: '+254712345678',
        role: UserRole.stationOwner,
        stationId: station1Id,
        createdAt: DateTime.now(),
      ).toMap());

      await db.insert('users', User(
        email: 'customer@example.com',
        password: 'customer123',
        fullName: 'John Customer',
        phone: '+254798765432',
        role: UserRole.customer,
        createdAt: DateTime.now(),
      ).toMap());
    } catch (e) {
      debugPrint('Error inserting sample data: $e');
    }
  }

  Future<String> backupDatabase() async {
    final sourceFile = await _getDatabaseFile();
    if (!await sourceFile.exists()) {
      throw Exception('Database file not found');
    }
    final backupDir = await _getBackupDirectory();
    if (!await backupDir.exists()) {
      await backupDir.create(recursive: true);
    }
    final backupFile = File(join(backupDir.path, _backupFileName));
    await sourceFile.copy(backupFile.path);
    return backupFile.path;
  }

  Future<void> restoreDatabase() async {
    final backupDir = await _getBackupDirectory();
    final backupFile = File(join(backupDir.path, _backupFileName));
    if (!await backupFile.exists()) {
      throw Exception('Backup file not found');
    }

    if (_database != null) {
      await _database!.close();
      _database = null;
    }

    final dbFile = await _getDatabaseFile();
    if (await dbFile.exists()) {
      await dbFile.delete();
    }

    await backupFile.copy(dbFile.path);
    await database;
  }

  Future<File> _getDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    return File(join(dbPath, _dbName));
  }

  Future<Directory> _getBackupDirectory() async {
    final docsDir = await getApplicationDocumentsDirectory();
    return Directory(join(docsDir.path, 'backups'));
  }

  // User CRUD operations
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  Future<User?> getUserById(int id) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<List<Receipt>> getReceiptsByCustomerId(int customerId) async {
    final db = await database;
    final result = await db.query(
      'receipts',
      where: 'customerId = ?',
      whereArgs: [customerId],
      orderBy: 'transactionDate DESC',
    );
    return result.map((map) => Receipt.fromMap(map)).toList();
  }

  // Station CRUD operations
  Future<int> insertStation(Station station) async {
    final db = await database;
    return await db.insert('stations', station.toMap());
  }

  Future<List<Station>> getAllStations() async {
    final db = await database;
    final result = await db.query('stations', orderBy: 'name');
    return result.map((map) => Station.fromMap(map)).toList();
  }

  Future<Station?> getStationById(int id) async {
    final db = await database;
    final result = await db.query(
      'stations',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Station.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateStation(Station station) async {
    final db = await database;
    return await db.update(
      'stations',
      station.toMap(),
      where: 'id = ?',
      whereArgs: [station.id],
    );
  }

  Future<int> deleteStation(int id) async {
    final db = await database;
    return await db.delete(
      'stations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Fuel CRUD operations
  Future<int> insertFuel(Fuel fuel) async {
    final db = await database;
    return await db.insert('fuel', fuel.toMap());
  }

  Future<List<Fuel>> getFuelByStationId(int stationId) async {
    final db = await database;
    final result = await db.query(
      'fuel',
      where: 'stationId = ?',
      whereArgs: [stationId],
    );
    return result.map((map) => Fuel.fromMap(map)).toList();
  }

  Future<int> updateFuel(Fuel fuel) async {
    final db = await database;
    return await db.update(
      'fuel',
      fuel.toMap(),
      where: 'id = ?',
      whereArgs: [fuel.id],
    );
  }

  // Receipt CRUD operations
  Future<int> insertReceipt(Receipt receipt) async {
    final db = await database;
    return await db.insert('receipts', receipt.toMap());
  }

  Future<List<Receipt>> getAllReceipts() async {
    final db = await database;
    final result = await db.query(
      'receipts',
      orderBy: 'transactionDate DESC',
    );
    return result.map((map) => Receipt.fromMap(map)).toList();
  }

  Future<List<Receipt>> getReceiptsByStationId(int stationId) async {
    final db = await database;
    final result = await db.query(
      'receipts',
      where: 'stationId = ?',
      whereArgs: [stationId],
      orderBy: 'transactionDate DESC',
    );
    return result.map((map) => Receipt.fromMap(map)).toList();
  }

  Future<Receipt?> getReceiptById(int id) async {
    final db = await database;
    final result = await db.query(
      'receipts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Receipt.fromMap(result.first);
    }
    return null;
  }

  // Dashboard statistics
  Future<Map<String, dynamic>> getDashboardStats({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await database;
    
    String dateFilter = '';
    List<dynamic> whereArgs = [];
    
    if (startDate != null && endDate != null) {
      dateFilter = 'WHERE transactionDate >= ? AND transactionDate <= ?';
      whereArgs = [
        startDate.toIso8601String(),
        endDate.toIso8601String(),
      ];
    }

    // Total sales
    final salesResult = await db.rawQuery('''
      SELECT SUM(totalAmount) as totalSales, SUM(quantity) as totalFuel
      FROM receipts
      $dateFilter
    ''', whereArgs);

    // Total receipts count
    final receiptsResult = await db.rawQuery('''
      SELECT COUNT(*) as count
      FROM receipts
      $dateFilter
    ''', whereArgs);

    return {
      'totalSales': salesResult.first['totalSales'] as double? ?? 0.0,
      'totalFuel': salesResult.first['totalFuel'] as double? ?? 0.0,
      'totalReceipts': receiptsResult.first['count'] as int? ?? 0,
    };
  }

  Future<List<Map<String, dynamic>>> getSalesByDate({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT 
        DATE(transactionDate) as date,
        SUM(totalAmount) as sales,
        SUM(quantity) as fuel
      FROM receipts
      WHERE transactionDate >= ? AND transactionDate <= ?
      GROUP BY DATE(transactionDate)
      ORDER BY date
    ''', [
      startDate.toIso8601String(),
      endDate.toIso8601String(),
    ]);
  }

  // Price History operations
  Future<int> insertPriceHistory(PriceHistory priceHistory) async {
    final db = await database;
    return await db.insert('price_history', priceHistory.toMap());
  }

  Future<List<PriceHistory>> getPriceHistoryByStationId(int stationId, {String? fuelType}) async {
    final db = await database;
    String where = 'stationId = ?';
    List<dynamic> whereArgs = [stationId];
    
    if (fuelType != null) {
      where += ' AND fuelType = ?';
      whereArgs.add(fuelType);
    }
    
    final result = await db.query(
      'price_history',
      where: where,
      whereArgs: whereArgs,
      orderBy: 'updatedAt DESC',
    );
    return result.map((map) => PriceHistory.fromMap(map)).toList();
  }

  // Employee CRUD operations
  Future<int> insertEmployee(Employee employee) async {
    final db = await database;
    return await db.insert('employees', employee.toMap());
  }

  Future<List<Employee>> getEmployeesByStationId(int stationId) async {
    final db = await database;
    final result = await db.query(
      'employees',
      where: 'stationId = ?',
      whereArgs: [stationId],
      orderBy: 'fullName',
    );
    return result.map((map) => Employee.fromMap(map)).toList();
  }

  Future<Employee?> getEmployeeById(int id) async {
    final db = await database;
    final result = await db.query(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Employee.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateEmployee(Employee employee) async {
    final db = await database;
    return await db.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> deleteEmployee(int id) async {
    final db = await database;
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Station Hours operations
  Future<int> insertStationHours(StationHours hours) async {
    final db = await database;
    return await db.insert('station_hours', hours.toMap());
  }

  Future<List<StationHours>> getStationHoursByStationId(int stationId) async {
    final db = await database;
    final result = await db.query(
      'station_hours',
      where: 'stationId = ?',
      whereArgs: [stationId],
      orderBy: 'dayOfWeek',
    );
    return result.map((map) => StationHours.fromMap(map)).toList();
  }

  Future<int> updateStationHours(StationHours hours) async {
    final db = await database;
    return await db.update(
      'station_hours',
      hours.toMap(),
      where: 'id = ?',
      whereArgs: [hours.id],
    );
  }

  Future<int> deleteStationHours(int id) async {
    final db = await database;
    return await db.delete(
      'station_hours',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Promotion CRUD operations
  Future<int> insertPromotion(Promotion promotion) async {
    final db = await database;
    return await db.insert('promotions', promotion.toMap());
  }

  Future<List<Promotion>> getPromotionsByStationId(int stationId, {bool? activeOnly}) async {
    final db = await database;
    String where = 'stationId = ?';
    List<dynamic> whereArgs = [stationId];
    
    if (activeOnly == true) {
      where += ' AND isActive = 1';
    }
    
    final result = await db.query(
      'promotions',
      where: where,
      whereArgs: whereArgs,
      orderBy: 'startDate DESC',
    );
    return result.map((map) => Promotion.fromMap(map)).toList();
  }

  Future<Promotion?> getPromotionById(int id) async {
    final db = await database;
    final result = await db.query(
      'promotions',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Promotion.fromMap(result.first);
    }
    return null;
  }

  Future<int> updatePromotion(Promotion promotion) async {
    final db = await database;
    return await db.update(
      'promotions',
      promotion.toMap(),
      where: 'id = ?',
      whereArgs: [promotion.id],
    );
  }

  Future<int> deletePromotion(int id) async {
    final db = await database;
    return await db.delete(
      'promotions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Payment Method CRUD operations
  Future<int> insertPaymentMethod(PaymentMethod paymentMethod) async {
    final db = await database;
    return await db.insert('payment_methods', paymentMethod.toMap());
  }

  Future<List<PaymentMethod>> getPaymentMethodsByStationId(int stationId, {bool? enabledOnly}) async {
    final db = await database;
    String where = 'stationId = ?';
    List<dynamic> whereArgs = [stationId];
    
    if (enabledOnly == true) {
      where += ' AND isEnabled = 1';
    }
    
    final result = await db.query(
      'payment_methods',
      where: where,
      whereArgs: whereArgs,
      orderBy: 'methodName',
    );
    return result.map((map) => PaymentMethod.fromMap(map)).toList();
  }

  Future<PaymentMethod?> getPaymentMethodById(int id) async {
    final db = await database;
    final result = await db.query(
      'payment_methods',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return PaymentMethod.fromMap(result.first);
    }
    return null;
  }

  Future<int> updatePaymentMethod(PaymentMethod paymentMethod) async {
    final db = await database;
    return await db.update(
      'payment_methods',
      paymentMethod.toMap(),
      where: 'id = ?',
      whereArgs: [paymentMethod.id],
    );
  }

  Future<int> deletePaymentMethod(int id) async {
    final db = await database;
    return await db.delete(
      'payment_methods',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get all customers (users with customer role)
  Future<List<User>> getAllCustomers() async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'role = ?',
      whereArgs: ['customer'],
      orderBy: 'fullName',
    );
    return result.map((map) => User.fromMap(map)).toList();
  }

  // Get customers by station (customers who made purchases at a station)
  Future<List<User>> getCustomersByStationId(int stationId) async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT DISTINCT u.*
      FROM users u
      INNER JOIN receipts r ON u.id = r.customerId
      WHERE r.stationId = ? AND u.role = 'customer'
      ORDER BY u.fullName
    ''', [stationId]);
    return result.map((map) => User.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  Future<File> backupToFile() async {
    try {
      final data = await _exportAllTables();
      final file = await _getBackupFile();
      await file.writeAsString(jsonEncode(data), flush: true);
      return file;
    } catch (e) {
      debugPrint('Error creating backup: $e');
      rethrow;
    }
  }

  Future<void> restoreFromFile() async {
    try {
      final file = await _getBackupFile();
      if (!await file.exists()) {
        throw Exception('Backup file does not exist.');
      }
      final content = await file.readAsString();
      final Map<String, dynamic> data = jsonDecode(content) as Map<String, dynamic>;
      await _importAllTables(data);
    } catch (e) {
      debugPrint('Error restoring backup: $e');
      rethrow;
    }
  }

  Future<File> _getBackupFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File(join(dir.path, _backupFileName));
  }

  Future<Map<String, dynamic>> _exportAllTables() async {
    final db = await database;
    final stations = await db.query('stations');
    final fuel = await db.query('fuel');
    final receipts = await db.query('receipts');
    return {
      'stations': stations,
      'fuel': fuel,
      'receipts': receipts,
    };
  }

  Future<void> _importAllTables(Map<String, dynamic> payload) async {
    final db = await database;
    final batch = db.batch();

    batch.delete('stations');
    batch.delete('fuel');
    batch.delete('receipts');

    for (final station in (payload['stations'] as List<dynamic>? ?? [])) {
      final map = Map<String, dynamic>.from(station as Map);
      map.remove('id');
      batch.insert('stations', map);
    }

    for (final fuel in (payload['fuel'] as List<dynamic>? ?? [])) {
      final map = Map<String, dynamic>.from(fuel as Map);
      map.remove('id');
      batch.insert('fuel', map);
    }

    for (final receipt in (payload['receipts'] as List<dynamic>? ?? [])) {
      final map = Map<String, dynamic>.from(receipt as Map);
      map.remove('id');
      batch.insert('receipts', map);
    }

    await batch.commit(noResult: true);
  }
}

