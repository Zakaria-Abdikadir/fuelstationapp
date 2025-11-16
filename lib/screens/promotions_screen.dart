import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/promotion.dart';
import '../models/station.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends State<PromotionsScreen> {
  List<Station> _stations = [];
  Station? _selectedStation;
  List<Promotion> _promotions = [];
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
          _loadPromotions();
        }
      } else {
        _stations = allStations;
        if (_stations.isNotEmpty) {
          _selectedStation = _stations.first;
          _loadPromotions();
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

  Future<void> _loadPromotions() async {
    if (_selectedStation == null) return;

    try {
      final promotions = await DatabaseHelper.instance
          .getPromotionsByStationId(_selectedStation!.id!);
      setState(() {
        _promotions = promotions;
      });
    } catch (e) {
      debugPrint('Error loading promotions: $e');
    }
  }

  Future<void> _addPromotion() async {
    if (_selectedStation == null) return;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromotionFormScreen(
          stationId: _selectedStation!.id!,
        ),
      ),
    );

    if (result == true) {
      _loadPromotions();
    }
  }

  Future<void> _editPromotion(Promotion promotion) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PromotionFormScreen(
          promotion: promotion,
          stationId: promotion.stationId,
        ),
      ),
    );

    if (result == true) {
      _loadPromotions();
    }
  }

  Future<void> _deletePromotion(Promotion promotion) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.promotionsDeleteTitle),
        content: Text(l10n.promotionsDeleteMessage),
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
        await DatabaseHelper.instance.deletePromotion(promotion.id!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Promotion deleted successfully')),
          );
          _loadPromotions();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error deleting promotion: $e')),
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
        title: Text(l10n.promotionsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _selectedStation != null ? _addPromotion : null,
            tooltip: l10n.promotionsAddPromotion,
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
                            _loadPromotions();
                          },
                        ),
                      ),
                    Expanded(
                      child: _promotions.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_offer_outlined,
                                    size: 64,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n.promotionsNoPromotions,
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: _addPromotion,
                                    icon: const Icon(Icons.add),
                                    label: Text(l10n.promotionsAddPromotion),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _promotions.length,
                              itemBuilder: (context, index) {
                                final promotion = _promotions[index];
                                final isActive = promotion.isActive &&
                                    DateTime.now().isAfter(promotion.startDate) &&
                                    DateTime.now().isBefore(promotion.endDate);
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  elevation: 2,
                                  color: isActive
                                      ? AppColors.success.withValues(alpha: 0.05)
                                      : null,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: isActive
                                          ? AppColors.success
                                          : AppColors.textSecondary,
                                      child: const Icon(
                                        Icons.local_offer,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(
                                      promotion.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(promotion.description),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${promotion.fuelType} - ${promotion.discountPercent.toStringAsFixed(0)}% off',
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat('MMM dd, yyyy').format(promotion.startDate)} - ${DateFormat('MMM dd, yyyy').format(promotion.endDate)}',
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
                                          _editPromotion(promotion);
                                        } else if (value == 'delete') {
                                          _deletePromotion(promotion);
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
              onPressed: _addPromotion,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}

// Promotion Form Screen
class PromotionFormScreen extends StatefulWidget {
  final Promotion? promotion;
  final int stationId;

  const PromotionFormScreen({
    super.key,
    this.promotion,
    required this.stationId,
  });

  @override
  State<PromotionFormScreen> createState() => _PromotionFormScreenState();
}

class _PromotionFormScreenState extends State<PromotionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _discountPercentController = TextEditingController();
  final _discountAmountController = TextEditingController();
  String _fuelType = 'All';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    if (widget.promotion != null) {
      _titleController.text = widget.promotion!.title;
      _descriptionController.text = widget.promotion!.description;
      _discountPercentController.text = widget.promotion!.discountPercent.toString();
      _discountAmountController.text = widget.promotion!.discountAmount?.toString() ?? '';
      _fuelType = widget.promotion!.fuelType;
      _startDate = widget.promotion!.startDate;
      _endDate = widget.promotion!.endDate;
      _isActive = widget.promotion!.isActive;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _discountPercentController.dispose();
    _discountAmountController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _startDate = date;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _endDate = date;
      });
    }
  }

  Future<void> _savePromotion() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final promotion = Promotion(
        id: widget.promotion?.id,
        stationId: widget.stationId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        fuelType: _fuelType,
        discountPercent: double.tryParse(_discountPercentController.text) ?? 0.0,
        discountAmount: _discountAmountController.text.isNotEmpty
            ? double.tryParse(_discountAmountController.text)
            : null,
        startDate: _startDate,
        endDate: _endDate,
        isActive: _isActive,
        createdAt: widget.promotion?.createdAt ?? DateTime.now(),
      );

      if (widget.promotion == null) {
        await DatabaseHelper.instance.insertPromotion(promotion);
      } else {
        await DatabaseHelper.instance.updatePromotion(promotion);
      }

      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.promotion == null
                ? 'Promotion added successfully'
                : 'Promotion updated successfully'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving promotion: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.promotion == null
            ? l10n.promotionsAddPromotion
            : l10n.promotionsEditPromotion),
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
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: l10n.promotionsTitleLabel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: l10n.promotionsDescription,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _fuelType,
                decoration: InputDecoration(
                  labelText: 'Fuel Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: ['All', 'Petrol', 'Diesel'].map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _fuelType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _discountPercentController,
                      decoration: InputDecoration(
                        labelText: l10n.promotionsDiscountPercent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _discountAmountController,
                      decoration: InputDecoration(
                        labelText: l10n.promotionsDiscountAmount,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text(l10n.promotionsStartDate),
                subtitle: Text(DateFormat('MMM dd, yyyy').format(_startDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectStartDate,
              ),
              ListTile(
                title: Text(l10n.promotionsEndDate),
                subtitle: Text(DateFormat('MMM dd, yyyy').format(_endDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectEndDate,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text(l10n.promotionsActive),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _savePromotion,
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

