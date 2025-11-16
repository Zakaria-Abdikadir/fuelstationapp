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
  String get navStations => 'Stations';

  @override
  String get navProfile => 'Profile';

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
  String get settingsSectionProfile => 'Profile';

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
  String get settingsProfileTitle => 'Profile';

  @override
  String get settingsProfileSubtitle => 'View and edit your profile';

  @override
  String get settingsProfileEditTitle => 'Edit Profile';

  @override
  String get settingsProfileEditButton => 'Edit Profile';

  @override
  String get settingsProfileInfo => 'Profile Information';

  @override
  String get settingsProfilePhone => 'Phone';

  @override
  String get settingsProfileRole => 'Role';

  @override
  String get settingsProfileGoToSettings => 'Manage app settings';

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
  String get dashboardTitleStationOwner => 'Station Owner Dashboard';

  @override
  String get dashboardTitleCustomer => 'My Dashboard';

  @override
  String dashboardWelcome(String name) {
    return 'Welcome, $name';
  }

  @override
  String get dashboardStatTotalSpent => 'Total Spent';

  @override
  String get dashboardStatFuelPurchased => 'Fuel Purchased';

  @override
  String get dashboardStatTotalPurchases => 'Total Purchases';

  @override
  String get dashboardStatAveragePurchase => 'Avg Purchase';

  @override
  String get dashboardStatStations => 'Stations';

  @override
  String get dashboardPurchaseHistory => 'Purchase History';

  @override
  String get dashboardNoPurchases => 'No purchases yet';

  @override
  String get dashboardNoPurchasesHint =>
      'Start purchasing fuel to see your history here';

  @override
  String get commonViewAll => 'View All';

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to continue';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginEmailHint => 'Enter your email';

  @override
  String get loginEmailRequired => 'Email is required';

  @override
  String get loginEmailInvalid => 'Please enter a valid email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Enter your password';

  @override
  String get loginPasswordRequired => 'Password is required';

  @override
  String get loginPasswordMinLength => 'Password must be at least 6 characters';

  @override
  String get loginButton => 'Sign In';

  @override
  String get loginNoAccount => 'Don\'t have an account?';

  @override
  String get loginRegisterLink => 'Register';

  @override
  String get loginErrorInvalidCredentials => 'Invalid email or password';

  @override
  String get loginDemoAccounts => 'Demo Accounts';

  @override
  String get loginDemoOwner => 'Owner: owner@station.com / owner123';

  @override
  String get loginDemoCustomer =>
      'Customer: customer@example.com / customer123';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerSelectRole => 'Select Your Role';

  @override
  String get registerRoleCustomer => 'Customer';

  @override
  String get registerRoleStationOwner => 'Station Owner';

  @override
  String get registerFullNameLabel => 'Full Name';

  @override
  String get registerFullNameHint => 'Enter your full name';

  @override
  String get registerFullNameRequired => 'Full name is required';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerEmailHint => 'Enter your email';

  @override
  String get registerEmailRequired => 'Email is required';

  @override
  String get registerEmailInvalid => 'Please enter a valid email';

  @override
  String get registerPhoneLabel => 'Phone';

  @override
  String get registerPhoneHint => 'Enter your phone number';

  @override
  String get registerPhoneRequired => 'Phone is required';

  @override
  String get registerPasswordLabel => 'Password';

  @override
  String get registerPasswordHint => 'Enter your password';

  @override
  String get registerPasswordRequired => 'Password is required';

  @override
  String get registerPasswordMinLength =>
      'Password must be at least 6 characters';

  @override
  String get registerConfirmPasswordLabel => 'Confirm Password';

  @override
  String get registerConfirmPasswordHint => 'Confirm your password';

  @override
  String get registerConfirmPasswordRequired => 'Please confirm your password';

  @override
  String get registerConfirmPasswordMismatch => 'Passwords do not match';

  @override
  String get registerButton => 'Register';

  @override
  String get registerHaveAccount => 'Already have an account?';

  @override
  String get registerLoginLink => 'Sign In';

  @override
  String get registerErrorEmailExists => 'Email already registered';

  @override
  String get settingsLogoutTitle => 'Logout';

  @override
  String get settingsLogoutMessage => 'Are you sure you want to logout?';

  @override
  String get settingsLogoutButton => 'Logout';

  @override
  String get manageStationsTitle => 'Manage Stations';

  @override
  String get manageStationsComingSoon => 'Station management coming soon';

  @override
  String get managePricesTitle => 'Manage Prices';

  @override
  String get managePricesComingSoon => 'Price management coming soon';

  @override
  String get stationsViewMyStation => 'My Station';

  @override
  String get stationsViewAllStations => 'All Stations';

  @override
  String get stationsViewSearchHint => 'Search stations...';

  @override
  String get stationsViewAddStation => 'Add Station';

  @override
  String get receiptPaymentSuccessfulBanner => 'Payment Successful';

  @override
  String get commonView => 'View';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDelete => 'Delete';

  @override
  String get manageStationsSearchHint => 'Search stations...';

  @override
  String get manageStationsNoStations => 'No stations found';

  @override
  String get manageStationsAddStation => 'Add Station';

  @override
  String get manageStationsEditStation => 'Edit Station';

  @override
  String get manageStationsAddress => 'Address';

  @override
  String get manageStationsLocation => 'Location';

  @override
  String get manageStationsSelectLocation => 'Select Location on Map';

  @override
  String get manageStationsActive => 'Active';

  @override
  String get manageStationsDeleteTitle => 'Delete Station';

  @override
  String manageStationsDeleteMessage(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get manageStationsDeleteSuccess => 'Station deleted successfully';

  @override
  String get managePricesUpdatePetrol => 'Update Petrol Price';

  @override
  String get managePricesUpdateDiesel => 'Update Diesel Price';

  @override
  String get managePricesPriceHistory => 'Price History';

  @override
  String get managePricesBulkUpdate => 'Bulk Update';

  @override
  String get managePricesSelectStations => 'Select Stations';

  @override
  String get managePricesNewPrice => 'New Price (KES)';

  @override
  String get managePricesUpdateSuccess => 'Price updated successfully';

  @override
  String get managePricesHistoryEmpty => 'No price history available';

  @override
  String get receiptDetailsTitle => 'Receipt Details';

  @override
  String get receiptDetailsTransactionId => 'Transaction ID';

  @override
  String get receiptDetailsDate => 'Date';

  @override
  String get receiptDetailsStation => 'Station';

  @override
  String get receiptDetailsFuelType => 'Fuel Type';

  @override
  String get receiptDetailsQuantity => 'Quantity';

  @override
  String get receiptDetailsPricePerLiter => 'Price per Liter';

  @override
  String get receiptDetailsTotalAmount => 'Total Amount';

  @override
  String get receiptDetailsPaymentMethod => 'Payment Method';

  @override
  String get receiptDetailsCustomer => 'Customer';

  @override
  String get reportsTitle => 'Reports & Analytics';

  @override
  String get reportsExportPDF => 'Export as PDF';

  @override
  String get reportsExportExcel => 'Export as Excel';

  @override
  String get reportsSalesReport => 'Sales Report';

  @override
  String get reportsFuelConsumption => 'Fuel Consumption';

  @override
  String get reportsCustomerAnalytics => 'Customer Analytics';

  @override
  String get reportsRevenueTrends => 'Revenue Trends';

  @override
  String get reportsSelectPeriod => 'Select Period';

  @override
  String get reportsGenerate => 'Generate Report';

  @override
  String get stockManagementTitle => 'Stock Management';

  @override
  String get stockManagementTrackStock => 'Track Stock';

  @override
  String get stockManagementLowStockAlerts => 'Low Stock Alerts';

  @override
  String get stockManagementStockHistory => 'Stock History';

  @override
  String get stockManagementReorder => 'Reorder Management';

  @override
  String get stockManagementCurrentStock => 'Current Stock';

  @override
  String get stockManagementMinThreshold => 'Minimum Threshold';

  @override
  String get stockManagementUpdateStock => 'Update Stock';

  @override
  String get stockManagementStockUpdated => 'Stock updated successfully';

  @override
  String get stockManagementLowStock => 'Low Stock Alert';

  @override
  String get stockManagementReorderLevel => 'Reorder Level';

  @override
  String get employeeManagementTitle => 'Employee Management';

  @override
  String get employeeManagementAddEmployee => 'Add Employee';

  @override
  String get employeeManagementEditEmployee => 'Edit Employee';

  @override
  String get employeeManagementFullName => 'Full Name';

  @override
  String get employeeManagementEmail => 'Email';

  @override
  String get employeeManagementPhone => 'Phone';

  @override
  String get employeeManagementRole => 'Role';

  @override
  String get employeeManagementActive => 'Active';

  @override
  String get employeeManagementNoEmployees => 'No employees found';

  @override
  String get employeeManagementDeleteTitle => 'Delete Employee';

  @override
  String employeeManagementDeleteMessage(String name) {
    return 'Are you sure you want to delete $name?';
  }

  @override
  String get stationHoursTitle => 'Station Hours';

  @override
  String get stationHoursManageHours => 'Manage Hours';

  @override
  String get stationHoursDay => 'Day';

  @override
  String get stationHoursOpenTime => 'Open Time';

  @override
  String get stationHoursCloseTime => 'Close Time';

  @override
  String get stationHours24Hours => '24 Hours';

  @override
  String get stationHoursClosed => 'Closed';

  @override
  String get stationHoursMonday => 'Monday';

  @override
  String get stationHoursTuesday => 'Tuesday';

  @override
  String get stationHoursWednesday => 'Wednesday';

  @override
  String get stationHoursThursday => 'Thursday';

  @override
  String get stationHoursFriday => 'Friday';

  @override
  String get stationHoursSaturday => 'Saturday';

  @override
  String get stationHoursSunday => 'Sunday';

  @override
  String get customerManagementTitle => 'Customer Management';

  @override
  String get customerManagementAllCustomers => 'All Customers';

  @override
  String get customerManagementSearchHint => 'Search customers...';

  @override
  String get customerManagementNoCustomers => 'No customers found';

  @override
  String get customerManagementTotalPurchases => 'Total Purchases';

  @override
  String get customerManagementTotalSpent => 'Total Spent';

  @override
  String get promotionsTitle => 'Promotions & Discounts';

  @override
  String get promotionsAddPromotion => 'Add Promotion';

  @override
  String get promotionsEditPromotion => 'Edit Promotion';

  @override
  String get promotionsTitleLabel => 'Title';

  @override
  String get promotionsDescription => 'Description';

  @override
  String get promotionsDiscountPercent => 'Discount (%)';

  @override
  String get promotionsDiscountAmount => 'Discount Amount (KES)';

  @override
  String get promotionsStartDate => 'Start Date';

  @override
  String get promotionsEndDate => 'End Date';

  @override
  String get promotionsActive => 'Active';

  @override
  String get promotionsNoPromotions => 'No promotions found';

  @override
  String get promotionsDeleteTitle => 'Delete Promotion';

  @override
  String get promotionsDeleteMessage =>
      'Are you sure you want to delete this promotion?';

  @override
  String get paymentMethodsTitle => 'Payment Methods';

  @override
  String get paymentMethodsAddMethod => 'Add Payment Method';

  @override
  String get paymentMethodsEditMethod => 'Edit Payment Method';

  @override
  String get paymentMethodsMethodName => 'Method Name';

  @override
  String get paymentMethodsEnabled => 'Enabled';

  @override
  String get paymentMethodsAccountDetails => 'Account Details';

  @override
  String get paymentMethodsNoMethods => 'No payment methods found';

  @override
  String get paymentMethodsDeleteTitle => 'Delete Payment Method';

  @override
  String get paymentMethodsDeleteMessage =>
      'Are you sure you want to delete this payment method?';
}
