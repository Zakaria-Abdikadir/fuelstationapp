// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fuel Station App';

  @override
  String get appName => 'Fuel Station';

  @override
  String get appTagline => 'Your Digital Fuel Solution';

  @override
  String get navHome => 'Home';

  @override
  String get navFuel => 'Fuel';

  @override
  String get navPayment => 'Payment';

  @override
  String get navDashboard => 'Dashboard';

  @override
  String get navManageStations => 'Manage Stations';

  @override
  String get navManagePrices => 'Manage Prices';

  @override
  String get navReports => 'Reports';

  @override
  String get navSettings => 'Settings';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonClose => 'Close';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDone => 'Done';

  @override
  String get commonRefresh => 'Refresh';

  @override
  String get commonSelect => 'Select';

  @override
  String get commonLogout => 'Logout';

  @override
  String get commonClear => 'Clear';

  @override
  String get commonPrint => 'Print';

  @override
  String get commonViewReceipt => 'View Receipt';

  @override
  String get commonName => 'Name';

  @override
  String get commonEmail => 'Email';

  @override
  String get commonContinue => 'Continue';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSectionGeneral => 'General';

  @override
  String get settingsSectionData => 'Data';

  @override
  String get settingsSectionAbout => 'About';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsNotificationsSubtitle => 'Enable or disable notifications';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsThemeTitle => 'Theme';

  @override
  String get settingsBackupTitle => 'Backup Data';

  @override
  String get settingsBackupSubtitle => 'Backup your data to cloud';

  @override
  String get settingsRestoreTitle => 'Restore Data';

  @override
  String get settingsRestoreSubtitle => 'Restore data from backup';

  @override
  String get settingsClearCacheTitle => 'Clear Cache';

  @override
  String get settingsClearCacheSubtitle =>
      'Clear app cache and temporary files';

  @override
  String get settingsAppVersionTitle => 'App Version';

  @override
  String get settingsTermsTitle => 'Terms & Conditions';

  @override
  String get settingsTermsSubtitle => 'Read our terms and conditions';

  @override
  String get settingsPrivacyTitle => 'Privacy Policy';

  @override
  String get settingsPrivacySubtitle => 'Read our privacy policy';

  @override
  String get settingsLanguageDialogTitle => 'Select Language';

  @override
  String get settingsThemeDialogTitle => 'Select Theme';

  @override
  String get settingsProfileEditTitle => 'Edit Profile';

  @override
  String get settingsProfileFillAllFields => 'Please fill all fields';

  @override
  String get settingsProfileUpdated => 'Profile updated successfully';

  @override
  String get settingsProfilePhotoUpdated => 'Profile photo updated';

  @override
  String get settingsProfilePhotoError => 'Couldn\'t update profile photo';

  @override
  String get settingsChangePhoto => 'Change photo';

  @override
  String settingsLanguageChanged(String language) {
    return 'Language changed to $language. Setting saved successfully.';
  }

  @override
  String settingsThemeChanged(String theme) {
    return 'Theme changed to $theme';
  }

  @override
  String get settingsLogoutDialogTitle => 'Logout';

  @override
  String get settingsLogoutDialogMessage => 'Are you sure you want to logout?';

  @override
  String get settingsLogoutSuccess => 'Logged out successfully';

  @override
  String get settingsClearCacheDialogTitle => 'Clear Cache';

  @override
  String get settingsClearCacheDialogMessage =>
      'Are you sure you want to clear all cache?';

  @override
  String get settingsClearCacheSuccess => 'Cache cleared successfully';

  @override
  String settingsBackupSuccess(String path) {
    return 'Backup saved to $path';
  }

  @override
  String settingsBackupError(String error) {
    return 'Backup failed: $error';
  }

  @override
  String get settingsRestoreSuccess => 'Data restored successfully.';

  @override
  String settingsRestoreError(String error) {
    return 'Restore failed: $error';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSwahili => 'Swahili';

  @override
  String get languageFrench => 'French';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get termsAndConditionsTitle => 'Terms & Conditions';

  @override
  String termsAndConditionsBody(int year) {
    return '1. Acceptance of Terms\nBy using this Fuel Station App, you agree to be bound by these Terms and Conditions.\n\n2. Use of Service\nThe app is provided for fuel purchase and management purposes only.\n\n3. User Responsibilities\n- Users must provide accurate information\n- Users are responsible for maintaining account security\n- Users must comply with all applicable laws\n\n4. Limitation of Liability\nThe app provider is not liable for any damages arising from the use of this service.\n\n5. Modifications\nWe reserve the right to modify these terms at any time.\n\nLast updated: $year';
  }

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String privacyPolicyBody(int year) {
    return 'Privacy Policy\n\n1. Information We Collect\n- Personal information (name, email)\n- Location data for finding nearby stations\n- Purchase history and preferences\n\n2. How We Use Your Information\n- To provide and improve our services\n- To process transactions\n- To send important notifications\n\n3. Data Security\nWe implement appropriate security measures to protect your personal information.\n\n4. Data Sharing\nWe do not sell your personal information. We may share data only for service provision.\n\n5. Your Rights\n- Access your personal data\n- Request data deletion\n- Update your information\n\n6. Contact Us\nFor privacy concerns, contact us at privacy@fuelstation.com\n\nLast updated: $year';
  }

  @override
  String get homeTitle => 'Find Fuel Stations';

  @override
  String get homeSearchHint => 'Search stations or locations...';

  @override
  String get homeNearbyStations => 'Nearby Stations';

  @override
  String homeStationsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stations found',
      one: '$count station found',
      zero: 'No stations found',
    );
    return '$_temp0';
  }

  @override
  String get homeNoStationsFound => 'No stations found nearby';

  @override
  String get homeRefresh => 'Refresh';

  @override
  String get homeErrorLocationServicesDisabled =>
      'Location services are disabled. Please enable them.';

  @override
  String get homeErrorLocationDenied => 'Location permissions are denied.';

  @override
  String get homeErrorLocationDeniedForever =>
      'Location permissions are permanently denied.';

  @override
  String homeErrorGettingLocation(String error) {
    return 'Error getting location: $error';
  }

  @override
  String homeErrorLoadingStations(String error) {
    return 'Error loading stations: $error';
  }

  @override
  String get homeNoStationsFoundAction => 'Refresh';

  @override
  String stationDistanceAway(String distance) {
    return '$distance km away';
  }

  @override
  String get stationClosedLabel => 'Closed';

  @override
  String get stationSelectButton => 'Select';

  @override
  String get fuelTypePetrol => 'Petrol';

  @override
  String get fuelTypeDiesel => 'Diesel';

  @override
  String get fuelSelectFuelType => 'Select Fuel Type';

  @override
  String get fuelEnterQuantity => 'Enter Quantity';

  @override
  String get fuelChoiceAmount => 'Amount (KES)';

  @override
  String get fuelChoiceLiters => 'Liters (L)';

  @override
  String get fuelInputAmountLabel => 'Amount (KES)';

  @override
  String get fuelInputLitersLabel => 'Liters (L)';

  @override
  String get fuelInputAmountHint => 'Enter amount';

  @override
  String get fuelInputLitersHint => 'Enter liters';

  @override
  String get fuelPricePerLiterLabel => 'Price per Liter:';

  @override
  String get fuelLitersLabel => 'Liters:';

  @override
  String get fuelAmountLabel => 'Amount:';

  @override
  String get fuelTotalLabel => 'Total:';

  @override
  String get fuelInProgressTitle => 'Fueling in Progress...';

  @override
  String get fuelStopButton => 'Stop Fueling';

  @override
  String get fuelStartButton => 'Start Fueling';

  @override
  String get fuelErrorEnterAmountOrLiters => 'Please enter amount or liters';

  @override
  String fuelPumpStatus(String status) {
    return 'Pump: $status';
  }

  @override
  String get pumpStatusIdle => 'Idle';

  @override
  String get pumpStatusBusy => 'Busy';

  @override
  String get pumpStatusInUse => 'In Use';

  @override
  String get paymentTitle => 'Payment';

  @override
  String get paymentSummaryTitle => 'Transaction Summary';

  @override
  String get paymentSummaryStation => 'Station';

  @override
  String get paymentSummaryFuelType => 'Fuel Type';

  @override
  String get paymentSummaryQuantity => 'Quantity';

  @override
  String get paymentSummaryPricePerLiter => 'Price per Liter';

  @override
  String get paymentSummaryTotalLabel => 'Total Amount:';

  @override
  String get paymentMethodTitle => 'Select Payment Method';

  @override
  String get paymentMethodMpesa => 'M-Pesa';

  @override
  String get paymentMethodCard => 'Card';

  @override
  String get paymentMethodCash => 'Cash';

  @override
  String get paymentButtonPayNow => 'Pay Now';

  @override
  String get paymentProcessing => 'Processing...';

  @override
  String paymentError(String error) {
    return 'Payment failed: $error';
  }

  @override
  String get paymentSuccessAppBarTitle => 'Payment Successful';

  @override
  String get paymentSuccessTitle => 'Payment Completed Successfully!';

  @override
  String get paymentSuccessButtonViewReceipt => 'View Receipt';

  @override
  String get paymentSuccessButtonDone => 'Done';

  @override
  String get paymentReceiptTitle => 'Receipt';

  @override
  String get paymentReceiptTransactionId => 'Transaction ID';

  @override
  String get paymentReceiptDate => 'Date';

  @override
  String get paymentReceiptFuelType => 'Fuel Type';

  @override
  String get paymentReceiptQuantity => 'Quantity';

  @override
  String get paymentReceiptPricePerLiter => 'Price per Liter';

  @override
  String get paymentReceiptTotalAmount => 'Total Amount';

  @override
  String get paymentReceiptPaymentMethod => 'Payment Method';

  @override
  String get paymentReceiptSuccessMessage => 'Payment Successful';

  @override
  String get paymentReceiptSuccessTagline => 'Payment Successful';

  @override
  String get paymentReceiptPrinted => 'Receipt printed successfully';

  @override
  String get mainPlaceholderFuelTitle => 'Fuel';

  @override
  String get mainPlaceholderFuelMessage => 'Please select a station from Home';

  @override
  String get mainPlaceholderPaymentTitle => 'Payment';

  @override
  String get mainPlaceholderPaymentMessage =>
      'Complete a fueling session to proceed';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get dashboardPeriodToday => 'Today';

  @override
  String get dashboardPeriodWeek => 'This Week';

  @override
  String get dashboardPeriodMonth => 'This Month';

  @override
  String get dashboardStatTotalSales => 'Total Sales';

  @override
  String get dashboardStatFuelDispensed => 'Fuel Dispensed';

  @override
  String get dashboardStatReceipts => 'Receipts';

  @override
  String get dashboardStatTransactions => 'Transactions';

  @override
  String get dashboardSalesPerformanceTitle => 'Sales Performance';

  @override
  String get dashboardSalesPerformanceEmpty => 'No sales data available';

  @override
  String get dashboardRecentTransactionsTitle => 'Recent Transactions';

  @override
  String get dashboardRecentTransactionsEmpty => 'No recent transactions';

  @override
  String get dashboardQuickActionsTitle => 'Quick Actions';

  @override
  String get dashboardQuickActionManageStations => 'Manage Stations';

  @override
  String get dashboardQuickActionUpdatePrices => 'Update Prices';

  @override
  String get receiptPaymentSuccessfulBanner => 'Payment Successful';
}
