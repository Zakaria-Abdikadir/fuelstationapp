import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/fuel.dart';
import '../models/receipt.dart';
import '../models/station.dart';

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
        version: 1,
        onCreate: _createDB,
      );
    } catch (e) {
      debugPrint('Error initializing database: $e');
      rethrow;
    }
  }

  Future<void> _createDB(Database db, int version) async {
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
        FOREIGN KEY (stationId) REFERENCES stations (id)
      )
    ''');

    // Insert sample data
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    try {
      // Check if data already exists
      final existingStations = await db.query('stations', limit: 1);
      if (existingStations.isNotEmpty) {
        return; // Data already exists, skip insertion
      }

      // Sample stations
      await db.insert('stations', Station(
        name: 'Shell Nairobi West',
        address: 'Nairobi West, Ring Road',
        latitude: -1.2921,
        longitude: 36.8219,
        petrolPrice: 180.50,
        dieselPrice: 170.00,
      ).toMap());

      await db.insert('stations', Station(
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

