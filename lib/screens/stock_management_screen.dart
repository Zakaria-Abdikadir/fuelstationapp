import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/fuel.dart';
import '../models/station.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';

class StockManagementScreen extends StatefulWidget {
  const StockManagementScreen({super.key});

  @override
  State<StockManagementScreen> createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  List<Station> _stations = [];
  Station? _selectedStation;
  List<Fuel> _fuelStock = [];
  bool _isLoading = true;
  final _authService = AuthService.instance;
  final double _lowStockThreshold = 1000.0; // liters

  @override
  void initState() {
    super.initState();
    _loadStations();
  }

  Future<void> _loadStations() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final currentUser = _authService.currentUser;
      final allStations = await DatabaseHelper.instance.getAllStations();
      
      if (currentUser?.stationId != null) {
        _stations = allStations
            .where((s) => s.id == currentUser!.stationId)
            .toList();
        if (_stations.isNotEmpty) {
          _selectedStation = _stations.first;
          _loadStock();
        }
      } else {
        _stations = allStations;
        if (_stations.isNotEmpty) {
          _selectedStation = _stations.first;
          _loadStock();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading stations: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadStock() async {
    if (_selectedStation == null) return;

    try {
      final fuel = await DatabaseHelper.instance
          .getFuelByStationId(_selectedStation!.id!);
      setState(() {
        _fuelStock = fuel;
      });
    } catch (e) {
      debugPrint('Error loading stock: $e');
    }
  }

  Future<void> _updateStock(Fuel fuel, double newStock) async {
    try {
      await DatabaseHelper.instance.updateFuel(
        fuel.copyWith(
          stockInLiters: newStock,
          lastUpdated: DateTime.now(),
        ),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Stock updated successfully')),
        );
        _loadStock();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating stock: $e')),
        );
      }
    }
  }

  Future<void> _showUpdateStockDialog(Fuel fuel) async {
    final l10n = AppLocalizations.of(context)!;
    final stockController = TextEditingController(
      text: fuel.stockInLiters.toStringAsFixed(2),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${l10n.stockManagementUpdateStock} - ${fuel.fuelType}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${l10n.stockManagementCurrentStock}: ${fuel.stockInLiters.toStringAsFixed(2)} L'),
            const SizedBox(height: 16),
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'New Stock (Liters)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.commonCancel),
          ),
          ElevatedButton(
            onPressed: () {
              final stock = double.tryParse(stockController.text);
              if (stock != null && stock >= 0) {
                Navigator.pop(context);
                _updateStock(fuel, stock);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.commonSave),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final lowStockItems = _fuelStock
        .where((f) => f.stockInLiters < _lowStockThreshold)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.stockManagementTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _stations.isEmpty
              ? Center(
                  child: Text(
                    'No stations available',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                )
              : Column(
                  children: [
                    // Station selector
                    if (_stations.length > 1)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: DropdownButtonFormField<Station>(
                          value: _selectedStation,
                          decoration: InputDecoration(
                            labelText: 'Select Station',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: _stations.map((station) {
                            return DropdownMenuItem(
                              value: station,
                              child: Text(station.name),
                            );
                          }).toList(),
                          onChanged: (station) {
                            setState(() {
                              _selectedStation = station;
                            });
                            _loadStock();
                          },
                        ),
                      ),
                    // Low stock alerts
                    if (lowStockItems.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.error.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.error),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.warning, color: AppColors.error),
                                const SizedBox(width: 8),
                                Text(
                                  l10n.stockManagementLowStock,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.error,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ...lowStockItems.map((fuel) => Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    '${fuel.fuelType}: ${fuel.stockInLiters.toStringAsFixed(2)} L (Below ${_lowStockThreshold}L)',
                                  ),
                                )),
                          ],
                        ),
                      ),
                    // Stock list
                    Expanded(
                      child: _fuelStock.isEmpty
                          ? Center(
                              child: Text(
                                'No fuel stock data available',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _fuelStock.length,
                              itemBuilder: (context, index) {
                                final fuel = _fuelStock[index];
                                final isLowStock = fuel.stockInLiters < _lowStockThreshold;
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  elevation: 2,
                                  color: isLowStock
                                      ? AppColors.error.withValues(alpha: 0.05)
                                      : null,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: isLowStock
                                          ? AppColors.error
                                          : AppColors.success,
                                      child: Text(
                                        fuel.fuelType[0],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      fuel.fuelType,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Stock: ${fuel.stockInLiters.toStringAsFixed(2)} L',
                                        ),
                                        if (isLowStock)
                                          Text(
                                            'Low Stock Alert!',
                                            style: TextStyle(
                                              color: AppColors.error,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        if (fuel.lastUpdated != null)
                                          Text(
                                            'Updated: ${fuel.lastUpdated!.toString().substring(0, 16)}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () => _showUpdateStockDialog(fuel),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}

