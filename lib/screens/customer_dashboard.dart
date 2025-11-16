import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/receipt.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  List<Receipt> _myReceipts = [];
  Map<String, dynamic> _myStats = {};
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

    final currentUser = _authService.currentUser;
    if (currentUser?.id != null) {
      _myReceipts = await DatabaseHelper.instance
          .getReceiptsByCustomerId(currentUser!.id!);

      // Calculate stats
      double totalSpent = 0;
      double totalFuel = 0;
      for (var receipt in _myReceipts) {
        totalSpent += receipt.totalAmount;
        totalFuel += receipt.quantity;
      }

      setState(() {
        _myStats = {
          'totalSpent': totalSpent,
          'totalFuel': totalFuel,
          'totalPurchases': _myReceipts.length,
        };
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.dashboardTitleCustomer),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadDashboardData,
              child: SingleChildScrollView(
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
                              const Icon(Icons.person,
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
                                    Text(
                                      _authService.currentUser!.email,
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
                    // Stats Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            l10n.dashboardStatTotalSpent,
                            'KES ${(_myStats['totalSpent'] ?? 0.0).toStringAsFixed(2)}',
                            Icons.attach_money,
                            AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            l10n.dashboardStatFuelPurchased,
                            '${(_myStats['totalFuel'] ?? 0.0).toStringAsFixed(1)} L',
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
                            l10n.dashboardStatTotalPurchases,
                            '${_myStats['totalPurchases'] ?? 0}',
                            Icons.shopping_cart,
                            AppColors.success,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatCard(
                            l10n.dashboardStatAveragePurchase,
                            _myStats['totalPurchases'] != null &&
                                    (_myStats['totalPurchases'] as int) > 0
                                ? 'KES ${((_myStats['totalSpent'] as double) / (_myStats['totalPurchases'] as int)).toStringAsFixed(2)}'
                                : 'KES 0.00',
                            Icons.trending_up,
                            AppColors.info,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Purchase History
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.dashboardPurchaseHistory,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_myReceipts.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              // TODO: View all purchases
                            },
                            child: Text(l10n.commonViewAll),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _myReceipts.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(32),
                              child: Center(
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.receipt_long,
                                      size: 64,
                                      color: AppColors.textSecondary,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      l10n.dashboardNoPurchases,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      l10n.dashboardNoPurchasesHint,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _myReceipts.length > 5
                                  ? 5
                                  : _myReceipts.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                final receipt = _myReceipts[index];
                                return ListTile(
                                  leading: const Icon(Icons.receipt,
                                      color: AppColors.primary),
                                  title: Text(receipt.stationName),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${_localizedFuelType(l10n, receipt.fuelType)} - ${receipt.quantity.toStringAsFixed(2)} L',
                                      ),
                                      Text(
                                        DateFormat('MMM dd, yyyy HH:mm')
                                            .format(receipt.transactionDate),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'KES ${receipt.totalAmount.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      Text(
                                        receipt.paymentMethod,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    _showReceiptDetails(receipt, l10n);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
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
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReceiptDetails(Receipt receipt, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.paymentReceiptTitle),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.local_gas_station,
                        size: 48, color: AppColors.primary),
                    const SizedBox(height: 8),
                    Text(
                      receipt.stationName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              _buildReceiptRow(
                  l10n.paymentReceiptTransactionId, receipt.transactionId),
              _buildReceiptRow(
                l10n.paymentReceiptDate,
                DateFormat('yyyy-MM-dd HH:mm')
                    .format(receipt.transactionDate),
              ),
              _buildReceiptRow(
                l10n.paymentReceiptFuelType,
                _localizedFuelType(l10n, receipt.fuelType),
              ),
              _buildReceiptRow(
                l10n.paymentReceiptQuantity,
                '${receipt.quantity.toStringAsFixed(2)} L',
              ),
              _buildReceiptRow(
                l10n.paymentReceiptPricePerLiter,
                'KES ${receipt.pricePerLiter.toStringAsFixed(2)}',
              ),
              const Divider(),
              _buildReceiptRow(
                l10n.paymentReceiptTotalAmount,
                'KES ${receipt.totalAmount.toStringAsFixed(2)}',
                isBold: true,
              ),
              _buildReceiptRow(
                l10n.paymentReceiptPaymentMethod,
                receipt.paymentMethod,
              ),
            ],
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

  Widget _buildReceiptRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isBold ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
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

