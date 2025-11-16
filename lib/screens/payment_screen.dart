import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import '../db/db_helper.dart';
import '../l10n/app_localizations.dart';
import '../models/receipt.dart';
import '../models/station.dart';
import '../navigation/bottom_navbar.dart';
import '../services/auth_service.dart';
import '../utils/app_colors.dart';
import 'main_navigation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final Station station;
  final String fuelType;
  final double quantity;
  final double totalAmount;

  const PaymentScreen({
    super.key,
    required this.station,
    required this.fuelType,
    required this.quantity,
    required this.totalAmount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'M-Pesa';
  bool _isProcessing = false;
  bool _isPaymentComplete = false;
  Receipt? _generatedReceipt;
  int _currentIndex = 2;

  final List<String> _paymentMethods = ['M-Pesa', 'Card', 'Cash'];

  void _processPayment() async {
    if (_isProcessing) return;

    if (!mounted) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      // Simulate payment processing (reduced from 2 to 1.5 seconds for better UX)
      await Future.delayed(const Duration(milliseconds: 1500));

      // Generate receipt
      final transactionId = _generateTransactionId();
      final currentUser = AuthService.instance.currentUser;
      final receipt = Receipt(
        stationId: widget.station.id ?? 0,
        stationName: widget.station.name,
        fuelType: widget.fuelType,
        quantity: widget.quantity,
        pricePerLiter: widget.fuelType == 'Petrol'
            ? widget.station.petrolPrice
            : widget.station.dieselPrice,
        totalAmount: widget.totalAmount,
        paymentMethod: _selectedPaymentMethod,
        transactionId: transactionId,
        transactionDate: DateTime.now(),
        customerName: currentUser?.fullName,
        customerPhone: currentUser?.phone,
        customerId: currentUser?.id,
      );

      // Save receipt to database with timeout
      try {
        await DatabaseHelper.instance.insertReceipt(receipt).timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            debugPrint('Receipt save timeout');
            throw Exception('Database save timeout');
          },
        );
      } catch (e) {
        debugPrint('Error saving receipt: $e');
        // Continue even if saving fails - receipt is still generated
      }

      if (mounted) {
        setState(() {
          _isProcessing = false;
          _isPaymentComplete = true;
          _generatedReceipt = receipt;
        });
      }
    } catch (e) {
      debugPrint('Error processing payment: $e');
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.paymentError(e.toString())),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  String _generateTransactionId() {
    final now = DateTime.now();
    final dateStr = DateFormat('yyyyMMdd').format(now);
    final timeStr = DateFormat('HHmmss').format(now);
    final random = (now.millisecondsSinceEpoch % 1000).toString().padLeft(3, '0');
    return 'TXN$dateStr$timeStr$random';
  }

  Future<void> _downloadReceipt() async {
    if (_generatedReceipt == null) return;

    try {
      final l10n = AppLocalizations.of(context)!;
      
      // Show loading indicator
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: 16),
                Text('Generating receipt...'),
              ],
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // Generate PDF
      final pdf = await _generateReceiptPDF(_generatedReceipt!);
      
      // Get directory for saving
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
        // Try to get Downloads directory
        final downloadsPath = '/storage/emulated/0/Download';
        if (await Directory(downloadsPath).exists()) {
          directory = Directory(downloadsPath);
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      // Create filename with timestamp
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final fileName = 'Receipt_${_generatedReceipt!.transactionId}_$timestamp.pdf';
      final filePath = '${directory.path}/$fileName';

      // Save PDF file
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      if (mounted) {
        // Share the file (allows user to save/share)
        await Share.shareXFiles(
          [XFile(filePath)],
          text: 'Fuel Station Receipt',
          subject: 'Receipt - ${_generatedReceipt!.transactionId}',
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Receipt saved and ready to download'),
            backgroundColor: AppColors.success,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error downloading receipt: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading receipt: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<pw.Document> _generateReceiptPDF(Receipt receipt) async {
    final pdf = pw.Document();
    final dateFormat = DateFormat('MMM dd, yyyy HH:mm');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'FUEL STATION RECEIPT',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              
              // Station Info
              pw.Text(
                receipt.stationName,
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              
              // Transaction Details
              _buildPDFRow('Transaction ID:', receipt.transactionId),
              _buildPDFRow('Date:', dateFormat.format(receipt.transactionDate)),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              
              // Fuel Details
              _buildPDFRow('Fuel Type:', receipt.fuelType),
              _buildPDFRow('Quantity:', '${receipt.quantity.toStringAsFixed(2)} L'),
              _buildPDFRow('Price per Liter:', 'KES ${receipt.pricePerLiter.toStringAsFixed(2)}'),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              
              // Payment Details
              _buildPDFRow('Payment Method:', receipt.paymentMethod),
              pw.SizedBox(height: 10),
              
              // Total
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Total Amount:',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    'KES ${receipt.totalAmount.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              
              // Customer Info (if available)
              if (receipt.customerName != null || receipt.customerPhone != null) ...[
                pw.Text(
                  'Customer Information:',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 5),
                if (receipt.customerName != null)
                  _buildPDFRow('Name:', receipt.customerName!),
                if (receipt.customerPhone != null)
                  _buildPDFRow('Phone:', receipt.customerPhone!),
                pw.SizedBox(height: 20),
              ],
              
              // Footer
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Text(
                'Thank you for your purchase!',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontStyle: pw.FontStyle.italic,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }

  pw.Widget _buildPDFRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 120,
            child: pw.Text(
              label,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
          ),
          pw.Expanded(
            child: pw.Text(value),
          ),
        ],
      ),
    );
  }

  void _viewReceipt() {
    if (_generatedReceipt == null) return;

    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.paymentReceiptTitle),
        content: SingleChildScrollView(
          child: _buildReceiptContent(_generatedReceipt!),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              // Navigate back to MainNavigationScreen
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                (route) => false,
              );
            },
            child: Text(l10n.commonDone),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog first
              _downloadReceipt();
            },
            child: Text(l10n.commonPrint),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptContent(Receipt receipt) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Column(
            children: [
              const Icon(Icons.local_gas_station, size: 48, color: AppColors.primary),
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
        _buildReceiptRow(l10n.paymentReceiptTransactionId, receipt.transactionId),
        _buildReceiptRow(
          l10n.paymentReceiptDate,
          DateFormat('yyyy-MM-dd HH:mm').format(receipt.transactionDate),
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
          _paymentMethodLabel(l10n, receipt.paymentMethod),
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: AppColors.success),
                const SizedBox(width: 8),
                Text(
                  l10n.paymentReceiptSuccessMessage,
                  style: const TextStyle(
                    color: AppColors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_isPaymentComplete && _generatedReceipt != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.paymentSuccessAppBarTitle),
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(
                Icons.check_circle,
                size: 80,
                color: AppColors.success,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.paymentSuccessTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildReceiptContent(_generatedReceipt!),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _viewReceipt,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(l10n.paymentSuccessButtonViewReceipt),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate back to MainNavigationScreen
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(l10n.paymentSuccessButtonDone),
                    ),
                  ),
                ],
              ),
            ],
          ),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.paymentTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Summary
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
                      l10n.paymentSummaryTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    _buildSummaryRow(l10n.paymentSummaryStation, widget.station.name),
                    _buildSummaryRow(
                      l10n.paymentSummaryFuelType,
                      _localizedFuelType(l10n, widget.fuelType),
                    ),
                    _buildSummaryRow(
                      l10n.paymentSummaryQuantity,
                      '${widget.quantity.toStringAsFixed(2)} L',
                    ),
                    _buildSummaryRow(
                      l10n.paymentSummaryPricePerLiter,
                      widget.quantity > 0
                          ? 'KES ${(widget.totalAmount / widget.quantity).toStringAsFixed(2)}'
                          : 'KES ${widget.fuelType == 'Petrol' ? widget.station.petrolPrice : widget.station.dieselPrice}',
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.paymentSummaryTotalLabel,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'KES ${widget.totalAmount.toStringAsFixed(2)}',
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
            const SizedBox(height: 24),
            // Payment Method Selection
            Text(
              l10n.paymentMethodTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ..._paymentMethods.map((method) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildPaymentMethodCard(method),
                )),
            const SizedBox(height: 24),
            // Pay Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        l10n.paymentButtonPayNow,
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

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(String method) {
    final isSelected = _selectedPaymentMethod == method;
    final l10n = AppLocalizations.of(context)!;
    final label = _paymentMethodLabel(l10n, method);
    IconData icon;
    Color color;

    switch (method) {
      case 'M-Pesa':
        icon = Icons.phone_android;
        color = AppColors.success;
        break;
      case 'Card':
        icon = Icons.credit_card;
        color = AppColors.primary;
        break;
      case 'Cash':
        icon = Icons.money;
        color = AppColors.secondary;
        break;
      default:
        icon = Icons.payment;
        color = AppColors.textSecondary;
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.white,
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? color : AppColors.textSecondary),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? color : AppColors.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: color),
          ],
        ),
      ),
    );
  }

  String _paymentMethodLabel(AppLocalizations l10n, String method) {
    switch (method) {
      case 'Card':
        return l10n.paymentMethodCard;
      case 'Cash':
        return l10n.paymentMethodCash;
      case 'M-Pesa':
      default:
        return l10n.paymentMethodMpesa;
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

