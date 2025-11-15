import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends ChangeNotifier {
  static final SettingsService instance = SettingsService._init();
  SettingsService._init();

  // Keys for SharedPreferences
  static const String _keyNotifications = 'notifications_enabled';
  static const String _keyLanguage = 'language';
  static const String _keyTheme = 'theme_mode';
  static const String _keyUserName = 'user_name';
  static const String _keyUserEmail = 'user_email';
  static const String _keyUserAvatar = 'user_avatar';

  // Default values
  bool _notificationsEnabled = true;
  String _languageCode = 'en';
  String _themeMode = 'Light';
  String _userName = 'Admin User';
  String _userEmail = 'admin@fuelstation.com';
  String? _userAvatarPath;

  // Getters
  bool get notificationsEnabled => _notificationsEnabled;
  String get languageCode => _languageCode;
  String get themeMode => _themeMode;
  String get userName => _userName;
  String get userEmail => _userEmail;
  String? get userAvatarPath => _userAvatarPath;

  ThemeMode get themeModeEnum {
    switch (_themeMode) {
      case 'Dark':
        return ThemeMode.dark;
      case 'System':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }

  String get languageDisplayName {
    return _languageCodeNameMap[_languageCode] ?? 'English';
  }

  Locale get locale => Locale(_languageCode);

  static const Map<String, String> _languageNameCodeMap = {
    'English': 'en',
    'Swahili': 'sw',
    'French': 'fr',
    'Spanish': 'es',
  };

  static const Map<String, String> _languageCodeNameMap = {
    'en': 'English',
    'sw': 'Swahili',
    'fr': 'French',
    'es': 'Spanish',
  };

  static const Set<String> _supportedLanguageCodes = {'en', 'sw', 'fr', 'es'};

  // Load settings from SharedPreferences
  Future<void> loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _notificationsEnabled = prefs.getBool(_keyNotifications) ?? true;
      final storedLanguage = prefs.getString(_keyLanguage);
      if (storedLanguage != null) {
        if (_supportedLanguageCodes.contains(storedLanguage)) {
          _languageCode = storedLanguage;
        } else {
          _languageCode = _languageNameCodeMap[storedLanguage] ?? 'en';
        }
      } else {
        _languageCode = 'en';
      }
      _themeMode = prefs.getString(_keyTheme) ?? 'Light';
      _userName = prefs.getString(_keyUserName) ?? 'Admin User';
      _userEmail = prefs.getString(_keyUserEmail) ?? 'admin@fuelstation.com';
      _userAvatarPath = prefs.getString(_keyUserAvatar);
    } catch (e) {
      debugPrint('Error loading settings: $e');
    }
  }

  // Save notifications setting
  Future<void> setNotificationsEnabled(bool enabled) async {
    try {
      _notificationsEnabled = enabled;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyNotifications, enabled);
    } catch (e) {
      debugPrint('Error saving notifications setting: $e');
    }
  }

  // Save language setting
  Future<void> setLanguage(String languageCode) async {
    try {
      _languageCode = _supportedLanguageCodes.contains(languageCode)
          ? languageCode
          : _languageNameCodeMap[languageCode] ?? 'en';
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyLanguage, _languageCode);
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving language setting: $e');
    }
  }

  // Save theme mode setting
  Future<void> setThemeMode(String themeMode) async {
    try {
      _themeMode = themeMode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyTheme, themeMode);
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving theme setting: $e');
    }
  }

  // Save user profile
  Future<void> updateUserProfile(String name, String email) async {
    try {
      _userName = name;
      _userEmail = email;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyUserName, name);
      await prefs.setString(_keyUserEmail, email);
    } catch (e) {
      debugPrint('Error saving user profile: $e');
    }
  }

  Future<void> updateUserAvatar(String? imagePath) async {
    try {
      _userAvatarPath = imagePath;
      final prefs = await SharedPreferences.getInstance();
      if (imagePath == null) {
        await prefs.remove(_keyUserAvatar);
      } else {
        await prefs.setString(_keyUserAvatar, imagePath);
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving user avatar: $e');
    }
  }

  // Clear all settings (for logout)
  Future<void> clearAllSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      // Reset to defaults
      _notificationsEnabled = true;
      _languageCode = 'en';
      _themeMode = 'Light';
      _userName = 'Admin User';
      _userEmail = 'admin@fuelstation.com';
      _userAvatarPath = null;
    } catch (e) {
      debugPrint('Error clearing settings: $e');
    }
  }
}

