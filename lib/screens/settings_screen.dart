import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../utils/settings_service.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import '../db/db_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = SettingsService.instance;
  final AuthService _authService = AuthService.instance;
  bool _notificationsEnabled = true;
  String _languageCode = 'en';
  String _themeMode = 'Light';
  String _userName = 'Admin User';
  String _userEmail = 'admin@fuelstation.com';
  String? _avatarPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    await _settingsService.loadSettings();
    final currentUser = _authService.currentUser;
    setState(() {
      _notificationsEnabled = _settingsService.notificationsEnabled;
      _languageCode = _settingsService.languageCode;
      _themeMode = _settingsService.themeMode;
      _userName = currentUser?.fullName ?? _settingsService.userName;
      _userEmail = currentUser?.email ?? _settingsService.userEmail;
      _avatarPath = _settingsService.userAvatarPath;
      _isLoading = false;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() {
      _notificationsEnabled = value;
    });
    await _settingsService.setNotificationsEnabled(value);
  }

  Future<void> _backupData() async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final file = await DatabaseHelper.instance.backupToFile();
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.settingsBackupSuccess(file.path)),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.settingsBackupError(e.toString())),
        ),
      );
    }
  }

  Future<void> _restoreData() async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await DatabaseHelper.instance.restoreFromFile();
      await _loadSettings();
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.settingsRestoreSuccess),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.settingsRestoreError(e.toString())),
        ),
      );
    }
  }

  Future<void> _selectLanguage() async {
    final l10n = AppLocalizations.of(context)!;
    final languages = [
      ('en', l10n.languageEnglish),
      ('sw', l10n.languageSwahili),
      ('fr', l10n.languageFrench),
      ('es', l10n.languageSpanish),
    ];

    final selectedLanguageCode = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsLanguageDialogTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) {
            final isSelected = _languageCode == lang.$1;
            return ListTile(
              onTap: () => Navigator.pop(context, lang.$1),
              leading: Icon(
                Icons.language,
                color: isSelected ? AppColors.primary : null,
              ),
              title: Text(lang.$2),
              trailing:
                  isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel),
          ),
        ],
      ),
    );

    if (selectedLanguageCode != null && selectedLanguageCode != _languageCode) {
      setState(() {
        _languageCode = selectedLanguageCode;
      });
      await _settingsService.setLanguage(selectedLanguageCode);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.settingsLanguageChanged(
                _languageLabel(l10n, selectedLanguageCode),
              ),
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }

  Future<void> _selectTheme() async {
    final l10n = AppLocalizations.of(context)!;
    final themes = [
      ('Light', l10n.themeLight),
      ('Dark', l10n.themeDark),
      ('System', l10n.themeSystem),
    ];

    final selectedTheme = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsThemeDialogTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: themes.map((theme) {
            final isSelected = _themeMode == theme.$1;
            final icon = switch (theme.$1) {
              'Dark' => Icons.dark_mode,
              'System' => Icons.settings_suggest,
              _ => Icons.light_mode,
            };
            return ListTile(
              onTap: () => Navigator.pop(context, theme.$1),
              leading: Icon(
                icon,
                color: isSelected ? AppColors.primary : null,
              ),
              title: Text(theme.$2),
              trailing:
                  isSelected ? const Icon(Icons.check, color: AppColors.primary) : null,
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel),
          ),
        ],
      ),
    );

    if (selectedTheme != null && selectedTheme != _themeMode) {
      setState(() {
        _themeMode = selectedTheme;
      });
      await _settingsService.setThemeMode(selectedTheme);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              l10n.settingsThemeChanged(_themeLabel(l10n, selectedTheme)),
            ),
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.success,
          ),
        );
      }
    }
  }


  void _showTermsAndConditions() {
    final currentYear = DateTime.now().year;
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.termsAndConditionsTitle),
        content: SingleChildScrollView(
          child: Text(
            l10n.termsAndConditionsBody(currentYear),
            textAlign: TextAlign.left,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonClose),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    final currentYear = DateTime.now().year;
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.privacyPolicyTitle),
        content: SingleChildScrollView(
          child: Text(
            l10n.privacyPolicyBody(currentYear),
            textAlign: TextAlign.left,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonClose),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.settingsTitle),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          // General Section
          _buildSettingsSection(
            l10n.settingsSectionGeneral,
            [
              _buildNotificationTile(),
              _buildSettingsTile(
                icon: Icons.language,
                title: l10n.settingsLanguageTitle,
                subtitle: _languageLabel(l10n, _languageCode),
                onTap: _selectLanguage,
              ),
              _buildSettingsTile(
                icon: Icons.dark_mode,
                title: l10n.settingsThemeTitle,
                subtitle: _themeLabel(l10n, _themeMode),
                onTap: _selectTheme,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Data section - only for station owners
          if (_authService.currentUser?.role == UserRole.stationOwner)
            _buildSettingsSection(
              l10n.settingsSectionData,
              [
                _buildSettingsTile(
                  icon: Icons.backup,
                  title: l10n.settingsBackupTitle,
                  subtitle: l10n.settingsBackupSubtitle,
                  onTap: _backupData,
                ),
                _buildSettingsTile(
                  icon: Icons.restore,
                  title: l10n.settingsRestoreTitle,
                  subtitle: l10n.settingsRestoreSubtitle,
                  onTap: _restoreData,
                ),
                _buildSettingsTile(
                  icon: Icons.delete_outline,
                  title: l10n.settingsClearCacheTitle,
                  subtitle: l10n.settingsClearCacheSubtitle,
                  onTap: () {
                    _showClearCacheDialog(context);
                  },
                ),
              ],
            ),
          if (_authService.currentUser?.role == UserRole.stationOwner)
            const SizedBox(height: 16),
          const SizedBox(height: 16),
          _buildSettingsSection(
            l10n.settingsSectionAbout,
            [
              _buildSettingsTile(
                icon: Icons.info,
                title: l10n.settingsAppVersionTitle,
                subtitle: '1.0.0',
                onTap: null,
              ),
              _buildSettingsTile(
                icon: Icons.description,
                title: l10n.settingsTermsTitle,
                subtitle: l10n.settingsTermsSubtitle,
                onTap: _showTermsAndConditions,
              ),
              _buildSettingsTile(
                icon: Icons.privacy_tip,
                title: l10n.settingsPrivacyTitle,
                subtitle: l10n.settingsPrivacySubtitle,
                onTap: _showPrivacyPolicy,
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right, color: AppColors.textSecondary)
          : null,
      onTap: onTap,
    );
  }

  void _showClearCacheDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsClearCacheDialogTitle),
        content: Text(l10n.settingsClearCacheDialogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(l10n.settingsClearCacheSuccess),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.commonClear),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTile() {
    final l10n = AppLocalizations.of(context)!;
    return ListTile(
      leading: const Icon(Icons.notifications, color: AppColors.primary),
      title: Text(l10n.settingsNotificationsTitle),
      subtitle: Text(l10n.settingsNotificationsSubtitle),
      trailing: Switch(
        value: _notificationsEnabled,
        onChanged: _toggleNotifications,
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => AppColors.primary,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primary.withValues(alpha: 0.4)
              : null,
        ),
      ),
    );
  }

  String _languageLabel(AppLocalizations l10n, String code) {
    switch (code) {
      case 'sw':
        return l10n.languageSwahili;
      case 'fr':
        return l10n.languageFrench;
      case 'es':
        return l10n.languageSpanish;
      case 'en':
      default:
        return l10n.languageEnglish;
    }
  }

  String _themeLabel(AppLocalizations l10n, String theme) {
    switch (theme) {
      case 'Dark':
        return l10n.themeDark;
      case 'System':
        return l10n.themeSystem;
      case 'Light':
      default:
        return l10n.themeLight;
    }
  }

}

