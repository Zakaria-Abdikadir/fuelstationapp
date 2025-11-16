import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../navigation/bottom_navbar.dart';
import '../utils/app_colors.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import 'home_screen.dart';
import 'fuel_screen.dart';
import 'station_owner_dashboard.dart';
import 'customer_dashboard.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import 'stations_view_screen.dart';
import '../models/station.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  Station? _selectedStation;
  final _authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
    _authService.addListener(_onAuthChanged);
  }

  @override
  void dispose() {
    _authService.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    if (!_authService.isLoggedIn && mounted) {
      // User logged out, navigate to login
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentUser = _authService.currentUser;
    final isStationOwner = currentUser?.role == UserRole.stationOwner;

    // Build screens based on user role
    List<Widget> screens;
    if (isStationOwner) {
      // Station Owner screens
      screens = [
        const StationOwnerDashboard(),
        const StationsViewScreen(),
        const ProfileScreen(),
      ];
    } else {
      // Customer screens - 4 tabs: Home, Fuel, Dashboard, Profile
      screens = [
        HomeScreen(
          onStationSelected: (station) {
            setState(() {
              _selectedStation = station;
              _currentIndex = 1; // Navigate to Fuel screen
            });
          },
        ),
        _selectedStation != null
            ? FuelScreenWrapper(station: _selectedStation!)
            : _buildPlaceholderScreen(
                icon: Icons.local_gas_station,
                title: l10n.mainPlaceholderFuelTitle,
                message: l10n.mainPlaceholderFuelMessage,
              ),
        const CustomerDashboard(),
        const ProfileScreen(),
      ];
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: _buildBottomNavBar(isStationOwner, l10n),
    );
  }

  Widget _buildBottomNavBar(bool isStationOwner, AppLocalizations l10n) {
    if (isStationOwner) {
      return BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: l10n.navDashboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_gas_station),
            label: l10n.navStations,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ],
      );
    } else {
      return BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      );
    }
  }

  Widget _buildPlaceholderScreen({
    required IconData icon,
    required String title,
    required String message,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Wrapper to hide bottom nav in FuelScreen
class FuelScreenWrapper extends StatelessWidget {
  final Station station;
  final Function(Station, String, double, double)? onNavigateToPayment;

  const FuelScreenWrapper({
    super.key,
    required this.station,
    this.onNavigateToPayment,
  });

  @override
  Widget build(BuildContext context) {
    return FuelScreen(station: station);
  }
}
