import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/station.dart';
import '../models/price_history.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';

class ManagePricesScreen extends StatefulWidget {
  const ManagePricesScreen({super.key});

  @override
  State<ManagePricesScreen> createState() => _ManagePricesScreenState();
}

class _ManagePricesScreenState extends State<ManagePricesScreen> {
  List<Station> _stations = [];
  Station? _selectedStation;
  bool _isLoading = true;
  List<PriceHistory> _priceHistory = [];
  final _authService = AuthService.instance;

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
          _loadPriceHistory();
        }
      } else {
        _stations = allStations;
        if (_stations.isNotEmpty) {
          _selectedStation = _stations.first;
          _loadPriceHistory();
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

  Future<void> _loadPriceHistory() async {
    if (_selectedStation == null) return;

    try {
      final history = await DatabaseHelper.instance
          .getPriceHistoryByStationId(_selectedStation!.id!);
      setState(() {
        _priceHistory = history;
      });
    } catch (e) {
      debugPrint('Error loading price history: $e');
    }
  }

  Future<void> _updatePrice(String fuelType, double newPrice) async {
    if (_selectedStation == null) return;

    try {
      // Update station price
      final updatedStation = _selectedStation!.copyWith(
        petrolPrice: fuelType == 'Petrol' ? newPrice : _selectedStation!.petrolPrice,
        dieselPrice: fuelType == 'Diesel' ? newPrice : _selectedStation!.dieselPrice,
      );
      await DatabaseHelper.instance.updateStation(updatedStation);

      // Save to price history
      await DatabaseHelper.instance.insertPriceHistory(
        PriceHistory(
          stationId: _selectedStation!.id!,
          fuelType: fuelType,
          pricePerLiter: newPrice,
          updatedAt: DateTime.now(),
          updatedBy: _authService.currentUser?.email,
        ),
      );

      // Update fuel table if exists
      final fuels = await DatabaseHelper.instance
          .getFuelByStationId(_selectedStation!.id!);
      for (var fuel in fuels) {
        if (fuel.fuelType == fuelType) {
          await DatabaseHelper.instance.updateFuel(
            fuel.copyWith(
              pricePerLiter: newPrice,
              lastUpdated: DateTime.now(),
            ),
          );
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Price updated successfully')),
        );
        _loadStations();
        _loadPriceHistory();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating price: $e')),
        );
      }
    }
  }

  Future<void> _showUpdatePriceDialog(String fuelType) async {
    if (_selectedStation == null) return;

    final l10n = AppLocalizations.of(context)!;
    final currentPrice = fuelType == 'Petrol'
        ? _selectedStation!.petrolPrice
        : _selectedStation!.dieselPrice;
    final priceController = TextEditingController(
      text: currentPrice.toStringAsFixed(2),
    );

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(fuelType == 'Petrol'
            ? l10n.managePricesUpdatePetrol
            : l10n.managePricesUpdateDiesel),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${l10n.managePricesNewPrice}:'),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price (KES)',
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
              final price = double.tryParse(priceController.text);
              if (price != null && price > 0) {
                Navigator.pop(context);
                _updatePrice(fuelType, price);
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

  Future<void> _showBulkUpdateDialog() async {
    if (_stations.isEmpty) return;

    final l10n = AppLocalizations.of(context)!;
    final selectedStations = <Station>[];
    final petrolPriceController = TextEditingController();
    final dieselPriceController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.managePricesBulkUpdate),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${l10n.managePricesSelectStations}:'),
                const SizedBox(height: 8),
                ..._stations.map((station) => CheckboxListTile(
                      title: Text(station.name),
                      value: selectedStations.contains(station),
                      onChanged: (value) {
                        setDialogState(() {
                          if (value == true) {
                            selectedStations.add(station);
                          } else {
                            selectedStations.remove(station);
                          }
                        });
                      },
                    )),
                const SizedBox(height: 16),
                TextField(
                  controller: petrolPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '${l10n.fuelTypePetrol} Price (KES)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: dieselPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '${l10n.fuelTypeDiesel} Price (KES)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.commonCancel),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectedStations.isEmpty) return;
                final petrolPrice = double.tryParse(petrolPriceController.text);
                final dieselPrice = double.tryParse(dieselPriceController.text);
                
                if (petrolPrice != null && petrolPrice > 0) {
                  for (var station in selectedStations) {
                    await _updatePrice('Petrol', petrolPrice);
                  }
                }
                if (dieselPrice != null && dieselPrice > 0) {
                  for (var station in selectedStations) {
                    await _updatePrice('Diesel', dieselPrice);
                  }
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: Text(l10n.commonSave),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.managePricesTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_stations.length > 1)
            IconButton(
              icon: const Icon(Icons.update),
              onPressed: _showBulkUpdateDialog,
              tooltip: l10n.managePricesBulkUpdate,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _stations.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_gas_station_outlined,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No stations available',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ],
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
                            _loadPriceHistory();
                          },
                        ),
                      ),
                    // Price update cards
                    if (_selectedStation != null) ...[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Card(
                                elevation: 2,
                                child: InkWell(
                                  onTap: () => _showUpdatePriceDialog('Petrol'),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Text(
                                          l10n.fuelTypePetrol,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'KES ${_selectedStation!.petrolPrice.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Tap to update',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Card(
                                elevation: 2,
                                child: InkWell(
                                  onTap: () => _showUpdatePriceDialog('Diesel'),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Text(
                                          l10n.fuelTypeDiesel,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'KES ${_selectedStation!.dieselPrice.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: AppColors.secondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Tap to update',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Price history
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.managePricesPriceHistory,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: _loadPriceHistory,
                              icon: const Icon(Icons.refresh, size: 18),
                              label: Text(l10n.commonRefresh),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: _priceHistory.isEmpty
                            ? Center(
                                child: Text(
                                  l10n.managePricesHistoryEmpty,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                itemCount: _priceHistory.length,
                                itemBuilder: (context, index) {
                                  final history = _priceHistory[index];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: history.fuelType == 'Petrol'
                                            ? AppColors.primary
                                            : AppColors.secondary,
                                        child: Text(
                                          history.fuelType[0],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        '${history.fuelType}: KES ${history.pricePerLiter.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat('MMM dd, yyyy HH:mm')
                                                .format(history.updatedAt),
                                          ),
                                          if (history.updatedBy != null)
                                            Text(
                                              'Updated by: ${history.updatedBy}',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ],
                ),
    );
  }
}
