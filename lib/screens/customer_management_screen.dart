import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/user.dart';
import '../models/receipt.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';

class CustomerManagementScreen extends StatefulWidget {
  const CustomerManagementScreen({super.key});

  @override
  State<CustomerManagementScreen> createState() => _CustomerManagementScreenState();
}

class _CustomerManagementScreenState extends State<CustomerManagementScreen> {
  List<User> _customers = [];
  List<User> _filteredCustomers = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  final _authService = AuthService.instance;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
    _searchController.addListener(_filterCustomers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCustomers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final currentUser = _authService.currentUser;
      List<User> customers;

      if (currentUser?.stationId != null) {
        customers = await DatabaseHelper.instance
            .getCustomersByStationId(currentUser!.stationId!);
      } else {
        customers = await DatabaseHelper.instance.getAllCustomers();
      }

      setState(() {
        _customers = customers;
        _filteredCustomers = customers;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading customers: $e')),
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

  void _filterCustomers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCustomers = _customers;
      } else {
        _filteredCustomers = _customers
            .where((customer) =>
                customer.fullName.toLowerCase().contains(query) ||
                customer.email.toLowerCase().contains(query) ||
                customer.phone.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  Future<Map<String, dynamic>> _getCustomerStats(int customerId) async {
    try {
      final receipts = await DatabaseHelper.instance
          .getReceiptsByCustomerId(customerId);
      
      double totalSpent = 0;
      int totalPurchases = receipts.length;
      
      for (var receipt in receipts) {
        totalSpent += receipt.totalAmount;
      }

      return {
        'totalSpent': totalSpent,
        'totalPurchases': totalPurchases,
      };
    } catch (e) {
      return {'totalSpent': 0.0, 'totalPurchases': 0};
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.customerManagementTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: l10n.customerManagementSearchHint,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _filteredCustomers.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 64,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                l10n.customerManagementNoCustomers,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _filteredCustomers.length,
                          itemBuilder: (context, index) {
                            final customer = _filteredCustomers[index];
                            return FutureBuilder<Map<String, dynamic>>(
                              future: _getCustomerStats(customer.id!),
                              builder: (context, snapshot) {
                                final stats = snapshot.data ?? {
                                  'totalSpent': 0.0,
                                  'totalPurchases': 0,
                                };
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  elevation: 2,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: AppColors.primary,
                                      child: Text(
                                        customer.fullName[0].toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      customer.fullName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(customer.email),
                                        Text(customer.phone),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              '${l10n.customerManagementTotalPurchases}: ${stats['totalPurchases']}',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                            const SizedBox(width: 16),
                                            Text(
                                              '${l10n.customerManagementTotalSpent}: KES ${(stats['totalSpent'] as double).toStringAsFixed(2)}',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
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
    );
  }
}

