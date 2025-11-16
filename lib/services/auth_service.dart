import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../db/db_helper.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  static final AuthService instance = AuthService._init();
  AuthService._init();

  static const String _keyCurrentUserId = 'current_user_id';
  static const String _keyIsLoggedIn = 'is_logged_in';

  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  UserRole? get currentUserRole => _currentUser?.role;

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(_keyIsLoggedIn) ?? false;
      final userId = prefs.getInt(_keyCurrentUserId);

      if (isLoggedIn && userId != null) {
        final user = await DatabaseHelper.instance.getUserById(userId);
        if (user != null) {
          _currentUser = user;
          _isLoggedIn = true;
          notifyListeners();
        } else {
          // User not found, clear session
          await logout();
        }
      }
    } catch (e) {
      debugPrint('Error initializing auth: $e');
      await logout();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final user = await DatabaseHelper.instance.getUserByEmail(email);
      
      if (user == null) {
        return false; // User not found
      }

      // In production, use password hashing (bcrypt, etc.)
      if (user.password != password) {
        return false; // Wrong password
      }

      // Update last login
      final updatedUser = user.copyWith(
        lastLogin: DateTime.now(),
      );
      await DatabaseHelper.instance.updateUser(updatedUser);

      // Save session
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setInt(_keyCurrentUserId, user.id!);

      _currentUser = updatedUser;
      _isLoggedIn = true;
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint('Error during login: $e');
      return false;
    }
  }

  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required UserRole role,
    int? stationId,
  }) async {
    try {
      // Check if user already exists
      final existingUser = await DatabaseHelper.instance.getUserByEmail(email);
      if (existingUser != null) {
        return false; // Email already registered
      }

      // Create new user
      final newUser = User(
        email: email,
        password: password, // In production, hash this
        fullName: fullName,
        phone: phone,
        role: role,
        stationId: stationId,
        createdAt: DateTime.now(),
      );

      final userId = await DatabaseHelper.instance.insertUser(newUser);
      if (userId == 0) {
        return false; // Failed to insert
      }

      // Get the created user with ID
      final createdUser = await DatabaseHelper.instance.getUserById(userId);
      if (createdUser == null) {
        return false;
      }

      // Auto-login after registration
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsLoggedIn, true);
      await prefs.setInt(_keyCurrentUserId, userId);

      _currentUser = createdUser;
      _isLoggedIn = true;
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint('Error during registration: $e');
      return false;
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyIsLoggedIn);
      await prefs.remove(_keyCurrentUserId);

      _currentUser = null;
      _isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
  }

  Future<bool> updateProfile({
    String? fullName,
    String? phone,
    String? email,
  }) async {
    if (_currentUser == null) return false;

    try {
      final updatedUser = _currentUser!.copyWith(
        fullName: fullName ?? _currentUser!.fullName,
        phone: phone ?? _currentUser!.phone,
        email: email ?? _currentUser!.email,
      );

      await DatabaseHelper.instance.updateUser(updatedUser);
      _currentUser = updatedUser;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error updating profile: $e');
      return false;
    }
  }
}

