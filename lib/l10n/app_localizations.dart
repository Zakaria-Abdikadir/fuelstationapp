import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('sw'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Fuel Station App'**
  String get appTitle;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Fuel Station'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Your Digital Fuel Solution'**
  String get appTagline;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navFuel.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get navFuel;

  /// No description provided for @navPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get navPayment;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navManageStations.
  ///
  /// In en, this message translates to:
  /// **'Manage Stations'**
  String get navManageStations;

  /// No description provided for @navManagePrices.
  ///
  /// In en, this message translates to:
  /// **'Manage Prices'**
  String get navManagePrices;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get commonRefresh;

  /// No description provided for @commonSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get commonSelect;

  /// No description provided for @commonLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get commonLogout;

  /// No description provided for @commonClear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get commonClear;

  /// No description provided for @commonPrint.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get commonPrint;

  /// No description provided for @commonViewReceipt.
  ///
  /// In en, this message translates to:
  /// **'View Receipt'**
  String get commonViewReceipt;

  /// No description provided for @commonName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get commonName;

  /// No description provided for @commonEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get commonEmail;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSectionGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsSectionGeneral;

  /// No description provided for @settingsSectionData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get settingsSectionData;

  /// No description provided for @settingsSectionAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsSectionAbout;

  /// No description provided for @settingsNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotificationsTitle;

  /// No description provided for @settingsNotificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable or disable notifications'**
  String get settingsNotificationsSubtitle;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeTitle;

  /// No description provided for @settingsBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup Data'**
  String get settingsBackupTitle;

  /// No description provided for @settingsBackupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Backup your data to cloud'**
  String get settingsBackupSubtitle;

  /// No description provided for @settingsRestoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore Data'**
  String get settingsRestoreTitle;

  /// No description provided for @settingsRestoreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Restore data from backup'**
  String get settingsRestoreSubtitle;

  /// No description provided for @settingsClearCacheTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get settingsClearCacheTitle;

  /// No description provided for @settingsClearCacheSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clear app cache and temporary files'**
  String get settingsClearCacheSubtitle;

  /// No description provided for @settingsAppVersionTitle.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get settingsAppVersionTitle;

  /// No description provided for @settingsTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get settingsTermsTitle;

  /// No description provided for @settingsTermsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Read our terms and conditions'**
  String get settingsTermsSubtitle;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyTitle;

  /// No description provided for @settingsPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Read our privacy policy'**
  String get settingsPrivacySubtitle;

  /// No description provided for @settingsLanguageDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settingsLanguageDialogTitle;

  /// No description provided for @settingsThemeDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get settingsThemeDialogTitle;

  /// No description provided for @settingsProfileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get settingsProfileEditTitle;

  /// No description provided for @settingsProfileFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get settingsProfileFillAllFields;

  /// No description provided for @settingsProfileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get settingsProfileUpdated;

  /// No description provided for @settingsProfilePhotoUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile photo updated'**
  String get settingsProfilePhotoUpdated;

  /// No description provided for @settingsProfilePhotoError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update profile photo'**
  String get settingsProfilePhotoError;

  /// No description provided for @settingsChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get settingsChangePhoto;

  /// No description provided for @settingsLanguageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language changed to {language}. Setting saved successfully.'**
  String settingsLanguageChanged(String language);

  /// No description provided for @settingsThemeChanged.
  ///
  /// In en, this message translates to:
  /// **'Theme changed to {theme}'**
  String settingsThemeChanged(String theme);

  /// No description provided for @settingsLogoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogoutDialogTitle;

  /// No description provided for @settingsLogoutDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get settingsLogoutDialogMessage;

  /// No description provided for @settingsLogoutSuccess.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully'**
  String get settingsLogoutSuccess;

  /// No description provided for @settingsClearCacheDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get settingsClearCacheDialogTitle;

  /// No description provided for @settingsClearCacheDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all cache?'**
  String get settingsClearCacheDialogMessage;

  /// No description provided for @settingsClearCacheSuccess.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared successfully'**
  String get settingsClearCacheSuccess;

  /// No description provided for @settingsBackupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup saved to {path}'**
  String settingsBackupSuccess(String path);

  /// No description provided for @settingsBackupError.
  ///
  /// In en, this message translates to:
  /// **'Backup failed: {error}'**
  String settingsBackupError(String error);

  /// No description provided for @settingsRestoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data restored successfully.'**
  String get settingsRestoreSuccess;

  /// No description provided for @settingsRestoreError.
  ///
  /// In en, this message translates to:
  /// **'Restore failed: {error}'**
  String settingsRestoreError(String error);

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSwahili.
  ///
  /// In en, this message translates to:
  /// **'Swahili'**
  String get languageSwahili;

  /// No description provided for @languageFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageFrench;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @termsAndConditionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditionsTitle;

  /// No description provided for @termsAndConditionsBody.
  ///
  /// In en, this message translates to:
  /// **'1. Acceptance of Terms\nBy using this Fuel Station App, you agree to be bound by these Terms and Conditions.\n\n2. Use of Service\nThe app is provided for fuel purchase and management purposes only.\n\n3. User Responsibilities\n- Users must provide accurate information\n- Users are responsible for maintaining account security\n- Users must comply with all applicable laws\n\n4. Limitation of Liability\nThe app provider is not liable for any damages arising from the use of this service.\n\n5. Modifications\nWe reserve the right to modify these terms at any time.\n\nLast updated: {year}'**
  String termsAndConditionsBody(int year);

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicyBody.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy\n\n1. Information We Collect\n- Personal information (name, email)\n- Location data for finding nearby stations\n- Purchase history and preferences\n\n2. How We Use Your Information\n- To provide and improve our services\n- To process transactions\n- To send important notifications\n\n3. Data Security\nWe implement appropriate security measures to protect your personal information.\n\n4. Data Sharing\nWe do not sell your personal information. We may share data only for service provision.\n\n5. Your Rights\n- Access your personal data\n- Request data deletion\n- Update your information\n\n6. Contact Us\nFor privacy concerns, contact us at privacy@fuelstation.com\n\nLast updated: {year}'**
  String privacyPolicyBody(int year);

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Find Fuel Stations'**
  String get homeTitle;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search stations or locations...'**
  String get homeSearchHint;

  /// No description provided for @homeNearbyStations.
  ///
  /// In en, this message translates to:
  /// **'Nearby Stations'**
  String get homeNearbyStations;

  /// No description provided for @homeStationsFound.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0 {No stations found} one {{count} station found} other {{count} stations found}}'**
  String homeStationsFound(int count);

  /// No description provided for @homeNoStationsFound.
  ///
  /// In en, this message translates to:
  /// **'No stations found nearby'**
  String get homeNoStationsFound;

  /// No description provided for @homeRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get homeRefresh;

  /// No description provided for @homeErrorLocationServicesDisabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled. Please enable them.'**
  String get homeErrorLocationServicesDisabled;

  /// No description provided for @homeErrorLocationDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are denied.'**
  String get homeErrorLocationDenied;

  /// No description provided for @homeErrorLocationDeniedForever.
  ///
  /// In en, this message translates to:
  /// **'Location permissions are permanently denied.'**
  String get homeErrorLocationDeniedForever;

  /// No description provided for @homeErrorGettingLocation.
  ///
  /// In en, this message translates to:
  /// **'Error getting location: {error}'**
  String homeErrorGettingLocation(String error);

  /// No description provided for @homeErrorLoadingStations.
  ///
  /// In en, this message translates to:
  /// **'Error loading stations: {error}'**
  String homeErrorLoadingStations(String error);

  /// No description provided for @homeNoStationsFoundAction.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get homeNoStationsFoundAction;

  /// No description provided for @stationDistanceAway.
  ///
  /// In en, this message translates to:
  /// **'{distance} km away'**
  String stationDistanceAway(String distance);

  /// No description provided for @stationClosedLabel.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get stationClosedLabel;

  /// No description provided for @stationSelectButton.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get stationSelectButton;

  /// No description provided for @fuelTypePetrol.
  ///
  /// In en, this message translates to:
  /// **'Petrol'**
  String get fuelTypePetrol;

  /// No description provided for @fuelTypeDiesel.
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get fuelTypeDiesel;

  /// No description provided for @fuelSelectFuelType.
  ///
  /// In en, this message translates to:
  /// **'Select Fuel Type'**
  String get fuelSelectFuelType;

  /// No description provided for @fuelEnterQuantity.
  ///
  /// In en, this message translates to:
  /// **'Enter Quantity'**
  String get fuelEnterQuantity;

  /// No description provided for @fuelChoiceAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount (KES)'**
  String get fuelChoiceAmount;

  /// No description provided for @fuelChoiceLiters.
  ///
  /// In en, this message translates to:
  /// **'Liters (L)'**
  String get fuelChoiceLiters;

  /// No description provided for @fuelInputAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount (KES)'**
  String get fuelInputAmountLabel;

  /// No description provided for @fuelInputLitersLabel.
  ///
  /// In en, this message translates to:
  /// **'Liters (L)'**
  String get fuelInputLitersLabel;

  /// No description provided for @fuelInputAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get fuelInputAmountHint;

  /// No description provided for @fuelInputLitersHint.
  ///
  /// In en, this message translates to:
  /// **'Enter liters'**
  String get fuelInputLitersHint;

  /// No description provided for @fuelPricePerLiterLabel.
  ///
  /// In en, this message translates to:
  /// **'Price per Liter:'**
  String get fuelPricePerLiterLabel;

  /// No description provided for @fuelLitersLabel.
  ///
  /// In en, this message translates to:
  /// **'Liters:'**
  String get fuelLitersLabel;

  /// No description provided for @fuelAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount:'**
  String get fuelAmountLabel;

  /// No description provided for @fuelTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total:'**
  String get fuelTotalLabel;

  /// No description provided for @fuelInProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Fueling in Progress...'**
  String get fuelInProgressTitle;

  /// No description provided for @fuelStopButton.
  ///
  /// In en, this message translates to:
  /// **'Stop Fueling'**
  String get fuelStopButton;

  /// No description provided for @fuelStartButton.
  ///
  /// In en, this message translates to:
  /// **'Start Fueling'**
  String get fuelStartButton;

  /// No description provided for @fuelErrorEnterAmountOrLiters.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount or liters'**
  String get fuelErrorEnterAmountOrLiters;

  /// No description provided for @fuelPumpStatus.
  ///
  /// In en, this message translates to:
  /// **'Pump: {status}'**
  String fuelPumpStatus(String status);

  /// No description provided for @pumpStatusIdle.
  ///
  /// In en, this message translates to:
  /// **'Idle'**
  String get pumpStatusIdle;

  /// No description provided for @pumpStatusBusy.
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get pumpStatusBusy;

  /// No description provided for @pumpStatusInUse.
  ///
  /// In en, this message translates to:
  /// **'In Use'**
  String get pumpStatusInUse;

  /// No description provided for @paymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentTitle;

  /// No description provided for @paymentSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction Summary'**
  String get paymentSummaryTitle;

  /// No description provided for @paymentSummaryStation.
  ///
  /// In en, this message translates to:
  /// **'Station'**
  String get paymentSummaryStation;

  /// No description provided for @paymentSummaryFuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel Type'**
  String get paymentSummaryFuelType;

  /// No description provided for @paymentSummaryQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get paymentSummaryQuantity;

  /// No description provided for @paymentSummaryPricePerLiter.
  ///
  /// In en, this message translates to:
  /// **'Price per Liter'**
  String get paymentSummaryPricePerLiter;

  /// No description provided for @paymentSummaryTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Amount:'**
  String get paymentSummaryTotalLabel;

  /// No description provided for @paymentMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Payment Method'**
  String get paymentMethodTitle;

  /// No description provided for @paymentMethodMpesa.
  ///
  /// In en, this message translates to:
  /// **'M-Pesa'**
  String get paymentMethodMpesa;

  /// No description provided for @paymentMethodCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get paymentMethodCard;

  /// No description provided for @paymentMethodCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get paymentMethodCash;

  /// No description provided for @paymentButtonPayNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get paymentButtonPayNow;

  /// No description provided for @paymentProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get paymentProcessing;

  /// No description provided for @paymentError.
  ///
  /// In en, this message translates to:
  /// **'Payment failed: {error}'**
  String paymentError(String error);

  /// No description provided for @paymentSuccessAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentSuccessAppBarTitle;

  /// No description provided for @paymentSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Completed Successfully!'**
  String get paymentSuccessTitle;

  /// No description provided for @paymentSuccessButtonViewReceipt.
  ///
  /// In en, this message translates to:
  /// **'View Receipt'**
  String get paymentSuccessButtonViewReceipt;

  /// No description provided for @paymentSuccessButtonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get paymentSuccessButtonDone;

  /// No description provided for @paymentReceiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get paymentReceiptTitle;

  /// No description provided for @paymentReceiptTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get paymentReceiptTransactionId;

  /// No description provided for @paymentReceiptDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get paymentReceiptDate;

  /// No description provided for @paymentReceiptFuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel Type'**
  String get paymentReceiptFuelType;

  /// No description provided for @paymentReceiptQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get paymentReceiptQuantity;

  /// No description provided for @paymentReceiptPricePerLiter.
  ///
  /// In en, this message translates to:
  /// **'Price per Liter'**
  String get paymentReceiptPricePerLiter;

  /// No description provided for @paymentReceiptTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get paymentReceiptTotalAmount;

  /// No description provided for @paymentReceiptPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentReceiptPaymentMethod;

  /// No description provided for @paymentReceiptSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentReceiptSuccessMessage;

  /// No description provided for @paymentReceiptSuccessTagline.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get paymentReceiptSuccessTagline;

  /// No description provided for @paymentReceiptPrinted.
  ///
  /// In en, this message translates to:
  /// **'Receipt printed successfully'**
  String get paymentReceiptPrinted;

  /// No description provided for @mainPlaceholderFuelTitle.
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get mainPlaceholderFuelTitle;

  /// No description provided for @mainPlaceholderFuelMessage.
  ///
  /// In en, this message translates to:
  /// **'Please select a station from Home'**
  String get mainPlaceholderFuelMessage;

  /// No description provided for @mainPlaceholderPaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get mainPlaceholderPaymentTitle;

  /// No description provided for @mainPlaceholderPaymentMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete a fueling session to proceed'**
  String get mainPlaceholderPaymentMessage;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @dashboardPeriodToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dashboardPeriodToday;

  /// No description provided for @dashboardPeriodWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get dashboardPeriodWeek;

  /// No description provided for @dashboardPeriodMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get dashboardPeriodMonth;

  /// No description provided for @dashboardStatTotalSales.
  ///
  /// In en, this message translates to:
  /// **'Total Sales'**
  String get dashboardStatTotalSales;

  /// No description provided for @dashboardStatFuelDispensed.
  ///
  /// In en, this message translates to:
  /// **'Fuel Dispensed'**
  String get dashboardStatFuelDispensed;

  /// No description provided for @dashboardStatReceipts.
  ///
  /// In en, this message translates to:
  /// **'Receipts'**
  String get dashboardStatReceipts;

  /// No description provided for @dashboardStatTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get dashboardStatTransactions;

  /// No description provided for @dashboardSalesPerformanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Sales Performance'**
  String get dashboardSalesPerformanceTitle;

  /// No description provided for @dashboardSalesPerformanceEmpty.
  ///
  /// In en, this message translates to:
  /// **'No sales data available'**
  String get dashboardSalesPerformanceEmpty;

  /// No description provided for @dashboardRecentTransactionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get dashboardRecentTransactionsTitle;

  /// No description provided for @dashboardRecentTransactionsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No recent transactions'**
  String get dashboardRecentTransactionsEmpty;

  /// No description provided for @dashboardQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get dashboardQuickActionsTitle;

  /// No description provided for @dashboardQuickActionManageStations.
  ///
  /// In en, this message translates to:
  /// **'Manage Stations'**
  String get dashboardQuickActionManageStations;

  /// No description provided for @dashboardQuickActionUpdatePrices.
  ///
  /// In en, this message translates to:
  /// **'Update Prices'**
  String get dashboardQuickActionUpdatePrices;

  /// No description provided for @receiptPaymentSuccessfulBanner.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get receiptPaymentSuccessfulBanner;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'fr', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'sw':
      return AppLocalizationsSw();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
