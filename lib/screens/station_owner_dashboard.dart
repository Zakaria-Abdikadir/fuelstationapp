import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/receipt.dart';
import '../models/station.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import 'manage_stations_screen.dart';
import 'manage_prices_screen.dart';
import 'receipt_details_screen.dart';

class StationOwnerDashboard extends StatefulWidget {
  const StationOwnerDashboard({super.key});

  @override
  State<StationOwnerDashboard> createState() => _StationOwnerDashboardState();
}

class _StationOwnerDashboardState extends State<StationOwnerDashboard> {
  String _selectedPeriod = 'Today';
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _salesData = [];
  List<Receipt> _recentReceipts = [];
  List<Station> _myStations = [];
  bool _isLoading = true;
  final _authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoading = true;
    });

    DateTime startDate;
    final endDate = DateTime.now();

    switch (_selectedPeriod) {
      case 'Today':
        startDate = DateTime(endDate.year, endDate.month, endDate.day);
        break;
      case 'Week':
        startDate = endDate.subtract(const Duration(days: 7));
        break;
      case 'Month':
        startDate = DateTime(endDate.year, endDate.month, 1);
        break;
      default:
        startDate = DateTime(endDate.year, endDate.month, endDate.day);
    }

    // Get stats for owner's stations only
    final currentUser = _authService.currentUser;
    List<Receipt> allReceipts = [];
    
    if (currentUser?.stationId != null) {
      // Get receipts for owner's station
      allReceipts = await DatabaseHelper.instance
          .getReceiptsByStationId(currentUser!.stationId!);
    } else {
      // Get all receipts if no station assigned
      allReceipts = await DatabaseHelper.instance.getAllReceipts();
    }

    // Calculate stats from receipts
    double totalSales = 0;
    double totalFuel = 0;
    for (var receipt in allReceipts) {
      if (receipt.transactionDate.isAfter(startDate) &&
          receipt.transactionDate.isBefore(endDate.add(const Duration(days: 1)))) {
        totalSales += receipt.totalAmount;
        totalFuel += receipt.quantity;
      }
    }

    // Get sales by date
    final salesData = await DatabaseHelper.instance.getSalesByDate(
      startDate: startDate,
      endDate: endDate,
    );

    // Get owner's stations
    final allStations = await DatabaseHelper.instance.getAllStations();
    if (currentUser?.stationId != null) {
      _myStations = allStations
          .where((s) => s.id == currentUser!.stationId)
          .toList();
    } else {
      _myStations = allStations;
    }

    setState(() {
      _stats = {
        'totalSales': totalSales,
        'totalFuel': totalFuel,
        'totalReceipts': allReceipts.length,
      };
      _salesData = salesData;
      _recentReceipts = allReceipts.take(10).toList();
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardTitleStationOwner),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
              _loadDashboardData();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 'Today', child: Text(l10n.dashboardPeriodToday)),
              PopupMenuItem(
                  value: 'Week', child: Text(l10n.dashboardPeriodWeek)),
              PopupMenuItem(
                  value: 'Month', child: Text(l10n.dashboardPeriodMonth)),
            ],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_periodLabel(_selectedPeriod, l10n)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Card
                  if (_authService.currentUser != null)
                    Card(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Icon(Icons.business,
                                size: 48, color: AppColors.primary),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.dashboardWelcome(
                                        _authService.currentUser!.fullName),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (_myStations.isNotEmpty)
                                    Text(
                                      _myStations.first.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  // Overview Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          l10n.dashboardStatTotalSales,
                          'KES ${(_stats['totalSales'] ?? 0.0).toStringAsFixed(2)}',
                          Icons.attach_money,
                          AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          l10n.dashboardStatFuelDispensed,
                          '${(_stats['totalFuel'] ?? 0.0).toStringAsFixed(1)} L',
                          Icons.local_gas_station,
                          AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          l10n.dashboardStatReceipts,
                          '${_stats['totalReceipts'] ?? 0}',
                          Icons.receipt,
                          AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          l10n.dashboardStatStations,
                          '${_myStations.length}',
                          Icons.local_gas_station,
                          AppColors.info,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Quick Actions
                  Text(
                    l10n.dashboardQuickActionsTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildActionButton(
                          l10n.dashboardQuickActionManageStations,
                          Icons.local_gas_station,
                          AppColors.primary,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ManageStationsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildActionButton(
                          l10n.dashboardQuickActionUpdatePrices,
                          Icons.attach_money,
                          AppColors.secondary,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ManagePricesScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Sales Chart
                  Card(
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
                            l10n.dashboardSalesPerformanceTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 200,
                            child: _salesData.isEmpty
                                ? Center(
                                    child: Text(
                                        l10n.dashboardSalesPerformanceEmpty))
                                : BarChart(
                                    BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      maxY: _salesData.isEmpty
                                          ? 100
                                          : (_salesData
                                                  .map((e) =>
                                                      (e['sales'] as double? ??
                                                          0.0))
                                                  .reduce((a, b) =>
                                                      a > b ? a : b) *
                                              1.2),
                                      barGroups: _salesData
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final data = entry.value;
                                        return BarChartGroupData(
                                          x: index,
                                          barRods: [
                                            BarChartRodData(
                                              toY: (data['sales'] as double? ??
                                                  0.0),
                                              color: AppColors.primary,
                                              width: 16,
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(4)),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                      titlesData: FlTitlesData(
                                        leftTitles: const AxisTitles(
                                            sideTitles: SideTitles(
                                                showTitles: false)),
                                        rightTitles: const AxisTitles(
                                            sideTitles: SideTitles(
                                                showTitles: false)),
                                        topTitles: const AxisTitles(
                                            sideTitles: SideTitles(
                                                showTitles: false)),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              if (value.toInt() <
                                                  _salesData.length) {
                                                final dateStr = _salesData[
                                                    value.toInt()]['date']
                                                    as String?;
                                                if (dateStr != null) {
                                                  try {
                                                    final date =
                                                        DateTime.parse(dateStr);
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .only(top: 8),
                                                      child: Text(
                                                        DateFormat('MM/dd')
                                                            .format(date),
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    return const Text('');
                                                  }
                                                }
                                              }
                                              return const Text('');
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Recent Transactions
                  Text(
                    l10n.dashboardRecentTransactionsTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _recentReceipts.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(
                                child: Text(l10n.dashboardRecentTransactionsEmpty)),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _recentReceipts.length,
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            itemBuilder: (context, index) {
                              final receipt = _recentReceipts[index];
                              return ListTile(
                                leading: const Icon(Icons.receipt,
                                    color: AppColors.primary),
                                title: Text(receipt.stationName),
                                subtitle: Text(
                                  '${_localizedFuelType(l10n, receipt.fuelType)} - ${receipt.quantity.toStringAsFixed(2)} L',
                                ),
                                trailing: Text(
                                  'KES ${receipt.totalAmount.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReceiptDetailsScreen(
                                        receipt: receipt,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 32),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.trending_up, color: color, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _periodLabel(String period, AppLocalizations l10n) {
    switch (period) {
      case 'Week':
        return l10n.dashboardPeriodWeek;
      case 'Month':
        return l10n.dashboardPeriodMonth;
      case 'Today':
      default:
        return l10n.dashboardPeriodToday;
    }
  }

  String _localizedFuelType(AppLocalizations l10n, String fuelType) {
    switch (fuelType) {
      case 'Diesel':
        return l10n.fuelTypeDiesel;
      case 'Petrol':
      default:
        return l10n.fuelTypePetrol;
    }
  }
}

