import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/station.dart';
import '../utils/app_colors.dart';
import 'payment_screen.dart';

class FuelScreen extends StatefulWidget {
  final Station station;

  const FuelScreen({super.key, required this.station});

  @override
  State<FuelScreen> createState() => _FuelScreenState();
}

class _FuelScreenState extends State<FuelScreen> {
  String _selectedFuelType = 'Petrol';
  String _inputMode = 'Amount'; // 'Amount' or 'Liters'
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _litersController = TextEditingController();
  bool _isFueling = false;
  double _fuelDispensed = 0.0;
  String _pumpStatus = 'Idle'; // 'Idle', 'Busy', 'In Use'

  double get _currentPrice {
    return _selectedFuelType == 'Petrol'
        ? widget.station.petrolPrice
        : widget.station.dieselPrice;
  }

  double get _calculatedTotal {
    if (_inputMode == 'Amount' && _amountController.text.trim().isNotEmpty) {
      final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
      return amount;
    } else if (_inputMode == 'Liters' && _litersController.text.trim().isNotEmpty) {
      final liters = double.tryParse(_litersController.text.trim()) ?? 0.0;
      return liters * _currentPrice;
    }
    return 0.0;
  }

  double get _calculatedLiters {
    if (_inputMode == 'Amount' && _amountController.text.trim().isNotEmpty) {
      final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
      if (_currentPrice > 0) {
        return amount / _currentPrice;
      }
      return 0.0;
    } else if (_inputMode == 'Liters' && _litersController.text.trim().isNotEmpty) {
      return double.tryParse(_litersController.text.trim()) ?? 0.0;
    }
    return 0.0;
  }

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onInputChanged);
    _litersController.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    setState(() {});
  }

  void _startFueling() {
    if ((_inputMode == 'Amount' && _amountController.text.trim().isEmpty) ||
        (_inputMode == 'Liters' && _litersController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.fuelErrorEnterAmountOrLiters),
        ),
      );
      return;
    }

    setState(() {
      _isFueling = true;
      _pumpStatus = 'In Use';
      _fuelDispensed = 0.0;
    });

    // Simulate fueling process
    _simulateFueling();
  }

  void _simulateFueling() {
    final targetLiters = _calculatedLiters;
    const interval = 0.1; // Update every 0.1 seconds
    const litersPerSecond = 0.5; // 0.5 liters per second

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _fuelDispensed += litersPerSecond * interval;
          if (_fuelDispensed >= targetLiters) {
            _fuelDispensed = targetLiters;
            _isFueling = false;
            _pumpStatus = 'Idle';
            _navigateToPayment();
          } else {
            _simulateFueling();
          }
        });
      }
    });
  }

  void _stopFueling() {
    setState(() {
      _isFueling = false;
      _pumpStatus = 'Idle';
    });
  }

  void _navigateToPayment() {
    final totalAmount = _calculatedTotal;
    final liters = _fuelDispensed;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          station: widget.station,
          fuelType: _selectedFuelType,
          quantity: liters,
          totalAmount: totalAmount,
        ),
      ),
    );
  }

  Color _getPumpStatusColor() {
    switch (_pumpStatus) {
      case 'Idle':
        return AppColors.success;
      case 'Busy':
        return AppColors.warning;
      case 'In Use':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _litersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.station.name),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Station Info Card
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
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.station.address,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildPumpStatus(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Fuel Type Selection
            Text(
              l10n.fuelSelectFuelType,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildFuelTypeButton(
                    type: 'Petrol',
                    label: l10n.fuelTypePetrol,
                    price: widget.station.petrolPrice,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildFuelTypeButton(
                    type: 'Diesel',
                    label: l10n.fuelTypeDiesel,
                    price: widget.station.dieselPrice,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Input Mode Selection
            Text(
              l10n.fuelEnterQuantity,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: Text(l10n.fuelChoiceAmount),
                    selected: _inputMode == 'Amount',
                    onSelected: (selected) {
                      setState(() {
                        _inputMode = 'Amount';
                        _litersController.clear();
                      });
                    },
                    selectedColor: AppColors.primaryLight,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ChoiceChip(
                    label: Text(l10n.fuelChoiceLiters),
                    selected: _inputMode == 'Liters',
                    onSelected: (selected) {
                      setState(() {
                        _inputMode = 'Liters';
                        _amountController.clear();
                      });
                    },
                    selectedColor: AppColors.primaryLight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Input Field
            TextField(
              key: ValueKey(_inputMode),
              controller: _inputMode == 'Amount' ? _amountController : _litersController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: _inputMode == 'Amount'
                    ? l10n.fuelInputAmountLabel
                    : l10n.fuelInputLitersLabel,
                hintText: _inputMode == 'Amount'
                    ? l10n.fuelInputAmountHint
                    : l10n.fuelInputLitersHint,
                prefixIcon: Icon(
                  _inputMode == 'Amount' ? Icons.attach_money : Icons.water_drop,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // Price Display Card
            Card(
              color: AppColors.primaryLight.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.fuelPricePerLiterLabel,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'KES ${_currentPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    if (_inputMode == 'Amount' && _amountController.text.trim().isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.fuelLitersLabel,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            '${_calculatedLiters.toStringAsFixed(2)} L',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    if (_inputMode == 'Liters' && _litersController.text.trim().isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.fuelAmountLabel,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            'KES ${_calculatedTotal.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.fuelTotalLabel,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'KES ${_calculatedTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_isFueling) ...[
              const SizedBox(height: 24),
              Card(
                color: AppColors.error.withValues(alpha: 0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        l10n.fuelInProgressTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: _calculatedLiters > 0
                            ? _fuelDispensed / _calculatedLiters
                            : 0,
                        backgroundColor: AppColors.background,
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.error),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '${_fuelDispensed.toStringAsFixed(2)} L / ${_calculatedLiters.toStringAsFixed(2)} L',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _stopFueling,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(l10n.fuelStopButton),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            // Start Fueling Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isFueling ? null : _startFueling,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.fuelStartButton,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation is handled by MainNavigationScreen
      // Only show if not in main navigation context
      bottomNavigationBar: null,
    );
  }

  Widget _buildFuelTypeButton({
    required String type,
    required String label,
    required double price,
  }) {
    final isSelected = _selectedFuelType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFuelType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? (type == 'Petrol' ? AppColors.petrol : AppColors.diesel)
                  .withValues(alpha: 0.2)
              : Colors.grey[200],
          border: Border.all(
            color: isSelected
                ? (type == 'Petrol' ? AppColors.petrol : AppColors.diesel)
                : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? (type == 'Petrol' ? AppColors.petrol : AppColors.diesel)
                    : AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'KES ${price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                color: isSelected
                    ? (type == 'Petrol' ? AppColors.petrol : AppColors.diesel)
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPumpStatus() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: _getPumpStatusColor(),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.fuelPumpStatus(_pumpStatusLabel(l10n)),
          style: TextStyle(
            fontSize: 12,
            color: _getPumpStatusColor(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _pumpStatusLabel(AppLocalizations l10n) {
    switch (_pumpStatus) {
      case 'Busy':
        return l10n.pumpStatusBusy;
      case 'In Use':
        return l10n.pumpStatusInUse;
      case 'Idle':
      default:
        return l10n.pumpStatusIdle;
    }
  }
}

