import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';

class ReportsAnalyticsScreen extends StatefulWidget {
  const ReportsAnalyticsScreen({super.key});

  @override
  State<ReportsAnalyticsScreen> createState() => _ReportsAnalyticsScreenState();
}

class _ReportsAnalyticsScreenState extends State<ReportsAnalyticsScreen> {
  String _selectedPeriod = 'Week';
  Map<String, dynamic> _stats = {};
  List<Map<String, dynamic>> _salesData = [];
  bool _isLoading = true;
  final _authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() {
      _isLoading = true;
    });

    try {
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
          startDate = endDate.subtract(const Duration(days: 7));
      }

      final currentUser = _authService.currentUser;
      List<Map<String, dynamic>> receipts = [];

      if (currentUser?.stationId != null) {
        final stationReceipts = await DatabaseHelper.instance
            .getReceiptsByStationId(currentUser!.stationId!);
        receipts = stationReceipts.map((r) => r.toMap()).toList();
      } else {
        final allReceipts = await DatabaseHelper.instance.getAllReceipts();
        receipts = allReceipts.map((r) => r.toMap()).toList();
      }

      double totalSales = 0;
      double totalFuel = 0;
      int totalReceipts = 0;

      for (var receipt in receipts) {
        final date = DateTime.parse(receipt['transactionDate'] as String);
        if (date.isAfter(startDate) && date.isBefore(endDate.add(const Duration(days: 1)))) {
          totalSales += receipt['totalAmount'] as double;
          totalFuel += receipt['quantity'] as double;
          totalReceipts++;
        }
      }

      final salesData = await DatabaseHelper.instance.getSalesByDate(
        startDate: startDate,
        endDate: endDate,
      );

      setState(() {
        _stats = {
          'totalSales': totalSales,
          'totalFuel': totalFuel,
          'totalReceipts': totalReceipts,
        };
        _salesData = salesData;
        _isLoading = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading reports: $e')),
        );
      }
    }
  }

  Future<void> _exportReport(String format) async {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Export to $format functionality coming soon'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reportsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
              _loadReports();
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Today', child: Text(l10n.dashboardPeriodToday)),
              PopupMenuItem(value: 'Week', child: Text(l10n.dashboardPeriodWeek)),
              PopupMenuItem(value: 'Month', child: Text(l10n.dashboardPeriodMonth)),
            ],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_selectedPeriod),
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
                  // Export buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _exportReport('PDF'),
                          icon: const Icon(Icons.picture_as_pdf),
                          label: Text(l10n.reportsExportPDF),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _exportReport('Excel'),
                          icon: const Icon(Icons.table_chart),
                          label: Text(l10n.reportsExportExcel),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.success,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Sales Report
                  _buildReportCard(
                    l10n.reportsSalesReport,
                    [
                      _buildStatItem('Total Sales', 'KES ${(_stats['totalSales'] ?? 0.0).toStringAsFixed(2)}'),
                      _buildStatItem('Fuel Sold', '${(_stats['totalFuel'] ?? 0.0).toStringAsFixed(1)} L'),
                      _buildStatItem('Total Receipts', '${_stats['totalReceipts'] ?? 0}'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Fuel Consumption
                  _buildReportCard(
                    l10n.reportsFuelConsumption,
                    [
                      _buildStatItem('Total Fuel', '${(_stats['totalFuel'] ?? 0.0).toStringAsFixed(1)} L'),
                      _buildStatItem('Average per Receipt', '${_stats['totalReceipts'] != null && _stats['totalReceipts'] > 0 ? ((_stats['totalFuel'] ?? 0.0) / _stats['totalReceipts']).toStringAsFixed(2) : '0.00'} L'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Revenue Trends
                  _buildReportCard(
                    l10n.reportsRevenueTrends,
                    _salesData.isEmpty
                        ? [Text('No data available')]
                        : _salesData.take(7).map((data) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    DateFormat('MMM dd').format(DateTime.parse(data['date'] as String)),
                                  ),
                                  Text(
                                    'KES ${(data['sales'] as double? ?? 0.0).toStringAsFixed(2)}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildReportCard(String title, List<Widget> children) {
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
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

