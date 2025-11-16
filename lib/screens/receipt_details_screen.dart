import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';
import '../l10n/app_localizations.dart';
import '../models/receipt.dart';
import '../utils/app_colors.dart';

class ReceiptDetailsScreen extends StatefulWidget {
  final Receipt receipt;

  const ReceiptDetailsScreen({super.key, required this.receipt});

  @override
  State<ReceiptDetailsScreen> createState() => _ReceiptDetailsScreenState();
}

class _ReceiptDetailsScreenState extends State<ReceiptDetailsScreen> {
  Future<void> _downloadReceipt() async {
    try {
      final l10n = AppLocalizations.of(context)!;
      
      // Show loading indicator
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
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
            duration: Duration(seconds: 2),
          ),
        );
      }

      // Generate PDF
      final pdf = await _generateReceiptPDF(widget.receipt);
      
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
      final fileName = 'Receipt_${widget.receipt.transactionId}_$timestamp.pdf';
      final filePath = '${directory.path}/$fileName';

      // Save PDF file
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      if (mounted) {
        // Share the file (allows user to save/share)
        await Share.shareXFiles(
          [XFile(filePath)],
          text: 'Fuel Station Receipt',
          subject: 'Receipt - ${widget.receipt.transactionId}',
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.receiptDetailsTitle),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _downloadReceipt,
            tooltip: 'Print/Download Receipt',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Receipt Header
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      size: 64,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n.paymentReceiptSuccessMessage,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.receipt.transactionId,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Receipt Details
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
                      'Transaction Details',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      l10n.receiptDetailsTransactionId,
                      widget.receipt.transactionId,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      l10n.receiptDetailsDate,
                      DateFormat('MMM dd, yyyy HH:mm')
                          .format(widget.receipt.transactionDate),
                    ),
                    const Divider(),
                    _buildDetailRow(
                      l10n.receiptDetailsStation,
                      widget.receipt.stationName,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      l10n.receiptDetailsFuelType,
                      widget.receipt.fuelType,
                    ),
                    const Divider(),
                    _buildDetailRow(
                      l10n.receiptDetailsQuantity,
                      '${widget.receipt.quantity.toStringAsFixed(2)} L',
                    ),
                    const Divider(),
                    _buildDetailRow(
                      l10n.receiptDetailsPricePerLiter,
                      'KES ${widget.receipt.pricePerLiter.toStringAsFixed(2)}',
                    ),
                    const Divider(),
                    _buildDetailRow(
                      l10n.receiptDetailsPaymentMethod,
                      widget.receipt.paymentMethod,
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.receiptDetailsTotalAmount,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'KES ${widget.receipt.totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(
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
            if (widget.receipt.customerName != null || widget.receipt.customerPhone != null) ...[
              const SizedBox(height: 16),
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
                        l10n.receiptDetailsCustomer,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (widget.receipt.customerName != null)
                        _buildDetailRow('Name', widget.receipt.customerName!),
                      if (widget.receipt.customerName != null && widget.receipt.customerPhone != null)
                        const Divider(),
                      if (widget.receipt.customerPhone != null)
                        _buildDetailRow('Phone', widget.receipt.customerPhone!),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

