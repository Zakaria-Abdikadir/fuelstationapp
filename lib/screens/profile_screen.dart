import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../l10n/app_localizations.dart';
import '../utils/app_colors.dart';
import '../utils/settings_service.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final SettingsService _settingsService = SettingsService.instance;
  final AuthService _authService = AuthService.instance;
  String _userName = 'Admin User';
  String _userEmail = 'admin@fuelstation.com';
  String? _avatarPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    await _settingsService.loadSettings();
    final currentUser = _authService.currentUser;
    setState(() {
      _userName = currentUser?.fullName ?? _settingsService.userName;
      _userEmail = currentUser?.email ?? _settingsService.userEmail;
      _avatarPath = _settingsService.userAvatarPath;
      _isLoading = false;
    });
  }

  void _editProfile() {
    final l10n = AppLocalizations.of(context)!;
    final stateContext = context;
    final scaffoldMessenger = ScaffoldMessenger.of(stateContext);
    final nameController = TextEditingController(text: _userName);
    final emailController = TextEditingController(text: _userEmail);
    String? stagedAvatarPath = _avatarPath;
    String? newAvatarPath;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> pickNewAvatar() async {
              try {
                final picker = ImagePicker();
                final picked = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 85,
                );
                if (picked == null) return;

                final savedPath = await _savePickedImage(picked);
                if (savedPath == null) {
                  if (newAvatarPath != null) {
                    await _deleteAvatarFile(newAvatarPath);
                    newAvatarPath = null;
                  }
                  if (stateContext.mounted) {
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text(l10n.settingsProfilePhotoError),
                      ),
                    );
                  }
                  return;
                }

                if (newAvatarPath != null && newAvatarPath != savedPath) {
                  await _deleteAvatarFile(newAvatarPath);
                }

                newAvatarPath = savedPath;
                setDialogState(() {
                  stagedAvatarPath = savedPath;
                });
              } catch (_) {
                if (newAvatarPath != null) {
                  await _deleteAvatarFile(newAvatarPath);
                  newAvatarPath = null;
                }
                if (stateContext.mounted) {
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text(l10n.settingsProfilePhotoError),
                    ),
                  );
                }
              }
            }

            return AlertDialog(
              title: Text(l10n.settingsProfileEditTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: pickNewAvatar,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.primary,
                        backgroundImage: stagedAvatarPath != null
                            ? FileImage(File(stagedAvatarPath!))
                            : null,
                        child: stagedAvatarPath == null
                            ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: pickNewAvatar,
                      icon: const Icon(Icons.photo_camera),
                      label: Text(l10n.settingsChangePhoto),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: l10n.commonName,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: l10n.commonEmail,
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(dialogContext);
                    if (newAvatarPath != null &&
                        newAvatarPath != _avatarPath) {
                      await _deleteAvatarFile(newAvatarPath);
                    }
                  },
                  child: Text(l10n.commonCancel),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final trimmedName = nameController.text.trim();
                    final trimmedEmail = emailController.text.trim();
                    if (trimmedName.isEmpty || trimmedEmail.isEmpty) {
                      if (!stateContext.mounted) return;
                      scaffoldMessenger.showSnackBar(
                        SnackBar(
                          content: Text(l10n.settingsProfileFillAllFields),
                        ),
                      );
                      if (newAvatarPath != null &&
                          newAvatarPath != _avatarPath) {
                        await _deleteAvatarFile(newAvatarPath);
                        newAvatarPath = null;
                      }
                      return;
                    }

                    String? avatarToPersist = _avatarPath;
                    if (newAvatarPath != null) {
                      await _settingsService.updateUserAvatar(newAvatarPath);
                      if (_avatarPath != null &&
                          _avatarPath != newAvatarPath) {
                        await _deleteAvatarFile(_avatarPath);
                      }
                      avatarToPersist = newAvatarPath;
                    } else {
                      await _settingsService.updateUserAvatar(_avatarPath);
                    }

                    await _settingsService.updateUserProfile(
                      trimmedName,
                      trimmedEmail,
                    );

                    // Update auth service profile
                    await _authService.updateProfile(
                      fullName: trimmedName,
                      email: trimmedEmail,
                    );

                    if (!mounted) return;
                    setState(() {
                      _userName = trimmedName;
                      _userEmail = trimmedEmail;
                      _avatarPath = avatarToPersist;
                    });

                    if (!dialogContext.mounted) return;
                    Navigator.pop(dialogContext);
                    if (!stateContext.mounted) return;
                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          newAvatarPath != null
                              ? l10n.settingsProfilePhotoUpdated
                              : l10n.settingsProfileUpdated,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(l10n.commonSave),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<String?> _savePickedImage(XFile picked) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName =
          'profile_${DateTime.now().millisecondsSinceEpoch}${p.extension(picked.path)}';
      final destinationPath = p.join(appDir.path, fileName);
      await picked.saveTo(destinationPath);
      return destinationPath;
    } catch (_) {
      return null;
    }
  }

  Future<void> _deleteAvatarFile(String? path) async {
    if (path == null) return;
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.settingsProfileTitle),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsProfileTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 32),
          // Profile Header
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _editProfile,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primary,
                    backgroundImage: _avatarPath != null
                        ? FileImage(File(_avatarPath!))
                        : null,
                    child: _avatarPath == null
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _userEmail,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _editProfile,
                  icon: const Icon(Icons.edit),
                  label: Text(l10n.settingsProfileEditButton),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Profile Info Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsProfileInfo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow(l10n.commonName, _userName),
                  const Divider(),
                  _buildInfoRow(l10n.commonEmail, _userEmail),
                  if (_authService.currentUser != null) ...[
                    const Divider(),
                    _buildInfoRow(
                      l10n.settingsProfilePhone,
                      _authService.currentUser!.phone,
                    ),
                    const Divider(),
                    _buildInfoRow(
                      l10n.settingsProfileRole,
                      _getRoleDisplayName(_authService.currentUser!.role),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Logout Section
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Actions',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _handleLogout,
                      icon: const Icon(Icons.logout),
                      label: Text(l10n.settingsLogoutButton),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.stationOwner:
        return 'Station Owner';
      case UserRole.customer:
        return 'Customer';
    }
  }

  Future<void> _handleLogout() async {
    final l10n = AppLocalizations.of(context)!;
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsLogoutTitle),
        content: Text(l10n.settingsLogoutMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.commonCancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.settingsLogoutButton),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      await _authService.logout();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }
}

