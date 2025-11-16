import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/payment_method.dart';
import '../models/station.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  List<Station> _stations = [];
  Station? _selectedStation;
  List<PaymentMethod> _paymentMethods = [];
  bool _isLoading = true;
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
          _loadPaymentMethods();
        }
      } else {
        _stations = allStations;
        if (_stations.isNotEmpty) {
          _selectedStation = _stations.first;
          _loadPaymentMethods();
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

  Future<void> _loadPaymentMethods() async {
    if (_selectedStation == null) return;

    try {
      final methods = await DatabaseHelper.instance
          .getPaymentMethodsByStationId(_selectedStation!.id!);
      setState(() {
        _paymentMethods = methods;
      });
    } catch (e) {
      debugPrint('Error loading payment methods: $e');
    }
  }

  Future<void> _addPaymentMethod() async {
    if (_selectedStation == null) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodFormScreen(
          stationId: _selectedStation!.id!,
        ),
      ),
    );

    if (result == true) {
      _loadPaymentMethods();
    }
  }

  Future<void> _editPaymentMethod(PaymentMethod method) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethodFormScreen(
          paymentMethod: method,
          stationId: method.stationId,
        ),
      ),
    );

    if (result == true) {
      _loadPaymentMethods();
    }
  }

  Future<void> _deletePaymentMethod(PaymentMethod method) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.paymentMethodsDeleteTitle),
        content: Text(l10n.paymentMethodsDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await DatabaseHelper.instance.deletePaymentMethod(method.id!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment method deleted successfully')),
          );
          _loadPaymentMethods();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting payment method: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.paymentMethodsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _selectedStation != null ? _addPaymentMethod : null,
            tooltip: l10n.paymentMethodsAddMethod,
          ),
        ],
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
                            _loadPaymentMethods();
                          },
                        ),
                      ),
                    Expanded(
                      child: _paymentMethods.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.payment_outlined,
                                    size: 64,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n.paymentMethodsNoMethods,
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: _addPaymentMethod,
                                    icon: const Icon(Icons.add),
                                    label: Text(l10n.paymentMethodsAddMethod),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _paymentMethods.length,
                              itemBuilder: (context, index) {
                                final method = _paymentMethods[index];
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  elevation: 2,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: method.isEnabled
                                          ? AppColors.success
                                          : AppColors.textSecondary,
                                      child: const Icon(
                                        Icons.payment,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(
                                      method.methodName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          method.isEnabled ? 'Enabled' : 'Disabled',
                                          style: TextStyle(
                                            color: method.isEnabled
                                                ? AppColors.success
                                                : AppColors.textSecondary,
                                          ),
                                        ),
                                        if (method.accountDetails != null)
                                          Text(
                                            method.accountDetails!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                      ],
                                    ),
                                    trailing: PopupMenuButton<String>(
                                      onSelected: (value) {
                                        if (value == 'edit') {
                                          _editPaymentMethod(method);
                                        } else if (value == 'delete') {
                                          _deletePaymentMethod(method);
                                        }
                                      },
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          value: 'edit',
                                          child: Row(
                                            children: [
                                              const Icon(Icons.edit, size: 20),
                                              const SizedBox(width: 8),
                                              Text(l10n.commonEdit),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: Row(
                                            children: [
                                              const Icon(Icons.delete,
                                                  size: 20,
                                                  color: AppColors.error),
                                              const SizedBox(width: 8),
                                              Text(
                                                l10n.commonDelete,
                                                style: const TextStyle(
                                                    color: AppColors.error),
                                              ),
                                            ],
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
                ),
      floatingActionButton: _selectedStation != null
          ? FloatingActionButton(
              onPressed: _addPaymentMethod,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}

// Payment Method Form Screen
class PaymentMethodFormScreen extends StatefulWidget {
  final PaymentMethod? paymentMethod;
  final int stationId;

  const PaymentMethodFormScreen({
    super.key,
    this.paymentMethod,
    required this.stationId,
  });

  @override
  State<PaymentMethodFormScreen> createState() => _PaymentMethodFormScreenState();
}

class _PaymentMethodFormScreenState extends State<PaymentMethodFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _methodNameController = TextEditingController();
  final _accountDetailsController = TextEditingController();
  bool _isEnabled = true;

  @override
  void initState() {
    super.initState();
    if (widget.paymentMethod != null) {
      _methodNameController.text = widget.paymentMethod!.methodName;
      _accountDetailsController.text = widget.paymentMethod!.accountDetails ?? '';
      _isEnabled = widget.paymentMethod!.isEnabled;
    }
  }

  @override
  void dispose() {
    _methodNameController.dispose();
    _accountDetailsController.dispose();
    super.dispose();
  }

  Future<void> _savePaymentMethod() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final paymentMethod = PaymentMethod(
        id: widget.paymentMethod?.id,
        stationId: widget.stationId,
        methodName: _methodNameController.text.trim(),
        isEnabled: _isEnabled,
        accountDetails: _accountDetailsController.text.trim().isEmpty
            ? null
            : _accountDetailsController.text.trim(),
        createdAt: widget.paymentMethod?.createdAt ?? DateTime.now(),
      );

      if (widget.paymentMethod == null) {
        await DatabaseHelper.instance.insertPaymentMethod(paymentMethod);
      } else {
        await DatabaseHelper.instance.updatePaymentMethod(paymentMethod);
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.paymentMethod == null
                ? 'Payment method added successfully'
                : 'Payment method updated successfully'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving payment method: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paymentMethod == null
            ? l10n.paymentMethodsAddMethod
            : l10n.paymentMethodsEditMethod),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _methodNameController,
                decoration: InputDecoration(
                  labelText: l10n.paymentMethodsMethodName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Method name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _accountDetailsController,
                decoration: InputDecoration(
                  labelText: l10n.paymentMethodsAccountDetails,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text(l10n.paymentMethodsEnabled),
                value: _isEnabled,
                onChanged: (value) {
                  setState(() {
                    _isEnabled = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _savePaymentMethod,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(l10n.commonSave),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

