import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../navigation/bottom_navbar.dart';
import '../utils/app_colors.dart';
import 'home_screen.dart';
import 'fuel_screen.dart';
import '../models/station.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  Station? _selectedStation;

  void _navigateToPayment(Station station, String fuelType, double quantity, double totalAmount) {
    setState(() {
      _currentIndex = 2; // Navigate to Payment screen
    });
    // Payment screen will be handled separately via Navigator.push for now
    // This maintains the flow while keeping navigation working
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Build screens list
    List<Widget> screens = [
      HomeScreen(
        onStationSelected: (station) {
          setState(() {
            _selectedStation = station;
            _currentIndex = 1; // Navigate to Fuel screen
          });
        },
      ),
      _selectedStation != null
          ? FuelScreenWrapper(
              station: _selectedStation!,
              onNavigateToPayment: _navigateToPayment,
            )
          : _buildPlaceholderScreen(
              icon: Icons.local_gas_station,
              title: l10n.mainPlaceholderFuelTitle,
              message: l10n.mainPlaceholderFuelMessage,
            ),
      _buildPlaceholderScreen(
        icon: Icons.payment,
        title: l10n.mainPlaceholderPaymentTitle,
        message: l10n.mainPlaceholderPaymentMessage,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
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
