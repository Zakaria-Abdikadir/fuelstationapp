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

  /// No description provided for @navStations.
  ///
  /// In en, this message translates to:
  /// **'Stations'**
  String get navStations;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

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

  /// No description provided for @settingsSectionProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settingsSectionProfile;

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

  /// No description provided for @settingsProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get settingsProfileTitle;

  /// No description provided for @settingsProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and edit your profile'**
  String get settingsProfileSubtitle;

  /// No description provided for @settingsProfileEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get settingsProfileEditTitle;

  /// No description provided for @settingsProfileEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get settingsProfileEditButton;

  /// No description provided for @settingsProfileInfo.
  ///
  /// In en, this message translates to:
  /// **'Profile Information'**
  String get settingsProfileInfo;

  /// No description provided for @settingsProfilePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get settingsProfilePhone;

  /// No description provided for @settingsProfileRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get settingsProfileRole;

  /// No description provided for @settingsProfileGoToSettings.
  ///
  /// In en, this message translates to:
  /// **'Manage app settings'**
  String get settingsProfileGoToSettings;

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

  /// No description provided for @dashboardTitleStationOwner.
  ///
  /// In en, this message translates to:
  /// **'Station Owner Dashboard'**
  String get dashboardTitleStationOwner;

  /// No description provided for @dashboardTitleCustomer.
  ///
  /// In en, this message translates to:
  /// **'My Dashboard'**
  String get dashboardTitleCustomer;

  /// No description provided for @dashboardWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}'**
  String dashboardWelcome(String name);

  /// No description provided for @dashboardStatTotalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total Spent'**
  String get dashboardStatTotalSpent;

  /// No description provided for @dashboardStatFuelPurchased.
  ///
  /// In en, this message translates to:
  /// **'Fuel Purchased'**
  String get dashboardStatFuelPurchased;

  /// No description provided for @dashboardStatTotalPurchases.
  ///
  /// In en, this message translates to:
  /// **'Total Purchases'**
  String get dashboardStatTotalPurchases;

  /// No description provided for @dashboardStatAveragePurchase.
  ///
  /// In en, this message translates to:
  /// **'Avg Purchase'**
  String get dashboardStatAveragePurchase;

  /// No description provided for @dashboardStatStations.
  ///
  /// In en, this message translates to:
  /// **'Stations'**
  String get dashboardStatStations;

  /// No description provided for @dashboardPurchaseHistory.
  ///
  /// In en, this message translates to:
  /// **'Purchase History'**
  String get dashboardPurchaseHistory;

  /// No description provided for @dashboardNoPurchases.
  ///
  /// In en, this message translates to:
  /// **'No purchases yet'**
  String get dashboardNoPurchases;

  /// No description provided for @dashboardNoPurchasesHint.
  ///
  /// In en, this message translates to:
  /// **'Start purchasing fuel to see your history here'**
  String get dashboardNoPurchasesHint;

  /// No description provided for @commonViewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get commonViewAll;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue'**
  String get loginSubtitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// No description provided for @loginEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get loginEmailHint;

  /// No description provided for @loginEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get loginEmailRequired;

  /// No description provided for @loginEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get loginEmailInvalid;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get loginPasswordHint;

  /// No description provided for @loginPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get loginPasswordRequired;

  /// No description provided for @loginPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get loginPasswordMinLength;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginButton;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get loginNoAccount;

  /// No description provided for @loginRegisterLink.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get loginRegisterLink;

  /// No description provided for @loginErrorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password'**
  String get loginErrorInvalidCredentials;

  /// No description provided for @loginDemoAccounts.
  ///
  /// In en, this message translates to:
  /// **'Demo Accounts'**
  String get loginDemoAccounts;

  /// No description provided for @loginDemoOwner.
  ///
  /// In en, this message translates to:
  /// **'Owner: owner@station.com / owner123'**
  String get loginDemoOwner;

  /// No description provided for @loginDemoCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer: customer@example.com / customer123'**
  String get loginDemoCustomer;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerTitle;

  /// No description provided for @registerSelectRole.
  ///
  /// In en, this message translates to:
  /// **'Select Your Role'**
  String get registerSelectRole;

  /// No description provided for @registerRoleCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get registerRoleCustomer;

  /// No description provided for @registerRoleStationOwner.
  ///
  /// In en, this message translates to:
  /// **'Station Owner'**
  String get registerRoleStationOwner;

  /// No description provided for @registerFullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get registerFullNameLabel;

  /// No description provided for @registerFullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get registerFullNameHint;

  /// No description provided for @registerFullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Full name is required'**
  String get registerFullNameRequired;

  /// No description provided for @registerEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registerEmailLabel;

  /// No description provided for @registerEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get registerEmailHint;

  /// No description provided for @registerEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get registerEmailRequired;

  /// No description provided for @registerEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get registerEmailInvalid;

  /// No description provided for @registerPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get registerPhoneLabel;

  /// No description provided for @registerPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get registerPhoneHint;

  /// No description provided for @registerPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone is required'**
  String get registerPhoneRequired;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registerPasswordLabel;

  /// No description provided for @registerPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get registerPasswordHint;

  /// No description provided for @registerPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get registerPasswordRequired;

  /// No description provided for @registerPasswordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get registerPasswordMinLength;

  /// No description provided for @registerConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get registerConfirmPasswordLabel;

  /// No description provided for @registerConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get registerConfirmPasswordHint;

  /// No description provided for @registerConfirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get registerConfirmPasswordRequired;

  /// No description provided for @registerConfirmPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get registerConfirmPasswordMismatch;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @registerHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get registerHaveAccount;

  /// No description provided for @registerLoginLink.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get registerLoginLink;

  /// No description provided for @registerErrorEmailExists.
  ///
  /// In en, this message translates to:
  /// **'Email already registered'**
  String get registerErrorEmailExists;

  /// No description provided for @settingsLogoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogoutTitle;

  /// No description provided for @settingsLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get settingsLogoutMessage;

  /// No description provided for @settingsLogoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get settingsLogoutButton;

  /// No description provided for @manageStationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Stations'**
  String get manageStationsTitle;

  /// No description provided for @manageStationsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Station management coming soon'**
  String get manageStationsComingSoon;

  /// No description provided for @managePricesTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Prices'**
  String get managePricesTitle;

  /// No description provided for @managePricesComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Price management coming soon'**
  String get managePricesComingSoon;

  /// No description provided for @stationsViewMyStation.
  ///
  /// In en, this message translates to:
  /// **'My Station'**
  String get stationsViewMyStation;

  /// No description provided for @stationsViewAllStations.
  ///
  /// In en, this message translates to:
  /// **'All Stations'**
  String get stationsViewAllStations;

  /// No description provided for @stationsViewSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search stations...'**
  String get stationsViewSearchHint;

  /// No description provided for @stationsViewAddStation.
  ///
  /// In en, this message translates to:
  /// **'Add Station'**
  String get stationsViewAddStation;

  /// No description provided for @receiptPaymentSuccessfulBanner.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get receiptPaymentSuccessfulBanner;

  /// No description provided for @commonView.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get commonView;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @manageStationsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search stations...'**
  String get manageStationsSearchHint;

  /// No description provided for @manageStationsNoStations.
  ///
  /// In en, this message translates to:
  /// **'No stations found'**
  String get manageStationsNoStations;

  /// No description provided for @manageStationsAddStation.
  ///
  /// In en, this message translates to:
  /// **'Add Station'**
  String get manageStationsAddStation;

  /// No description provided for @manageStationsEditStation.
  ///
  /// In en, this message translates to:
  /// **'Edit Station'**
  String get manageStationsEditStation;

  /// No description provided for @manageStationsAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get manageStationsAddress;

  /// No description provided for @manageStationsLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get manageStationsLocation;

  /// No description provided for @manageStationsSelectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location on Map'**
  String get manageStationsSelectLocation;

  /// No description provided for @manageStationsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get manageStationsActive;

  /// No description provided for @manageStationsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Station'**
  String get manageStationsDeleteTitle;

  /// No description provided for @manageStationsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String manageStationsDeleteMessage(String name);

  /// No description provided for @manageStationsDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Station deleted successfully'**
  String get manageStationsDeleteSuccess;

  /// No description provided for @managePricesUpdatePetrol.
  ///
  /// In en, this message translates to:
  /// **'Update Petrol Price'**
  String get managePricesUpdatePetrol;

  /// No description provided for @managePricesUpdateDiesel.
  ///
  /// In en, this message translates to:
  /// **'Update Diesel Price'**
  String get managePricesUpdateDiesel;

  /// No description provided for @managePricesPriceHistory.
  ///
  /// In en, this message translates to:
  /// **'Price History'**
  String get managePricesPriceHistory;

  /// No description provided for @managePricesBulkUpdate.
  ///
  /// In en, this message translates to:
  /// **'Bulk Update'**
  String get managePricesBulkUpdate;

  /// No description provided for @managePricesSelectStations.
  ///
  /// In en, this message translates to:
  /// **'Select Stations'**
  String get managePricesSelectStations;

  /// No description provided for @managePricesNewPrice.
  ///
  /// In en, this message translates to:
  /// **'New Price (KES)'**
  String get managePricesNewPrice;

  /// No description provided for @managePricesUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Price updated successfully'**
  String get managePricesUpdateSuccess;

  /// No description provided for @managePricesHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No price history available'**
  String get managePricesHistoryEmpty;

  /// No description provided for @receiptDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt Details'**
  String get receiptDetailsTitle;

  /// No description provided for @receiptDetailsTransactionId.
  ///
  /// In en, this message translates to:
  /// **'Transaction ID'**
  String get receiptDetailsTransactionId;

  /// No description provided for @receiptDetailsDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get receiptDetailsDate;

  /// No description provided for @receiptDetailsStation.
  ///
  /// In en, this message translates to:
  /// **'Station'**
  String get receiptDetailsStation;

  /// No description provided for @receiptDetailsFuelType.
  ///
  /// In en, this message translates to:
  /// **'Fuel Type'**
  String get receiptDetailsFuelType;

  /// No description provided for @receiptDetailsQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get receiptDetailsQuantity;

  /// No description provided for @receiptDetailsPricePerLiter.
  ///
  /// In en, this message translates to:
  /// **'Price per Liter'**
  String get receiptDetailsPricePerLiter;

  /// No description provided for @receiptDetailsTotalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get receiptDetailsTotalAmount;

  /// No description provided for @receiptDetailsPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get receiptDetailsPaymentMethod;

  /// No description provided for @receiptDetailsCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get receiptDetailsCustomer;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports & Analytics'**
  String get reportsTitle;

  /// No description provided for @reportsExportPDF.
  ///
  /// In en, this message translates to:
  /// **'Export as PDF'**
  String get reportsExportPDF;

  /// No description provided for @reportsExportExcel.
  ///
  /// In en, this message translates to:
  /// **'Export as Excel'**
  String get reportsExportExcel;

  /// No description provided for @reportsSalesReport.
  ///
  /// In en, this message translates to:
  /// **'Sales Report'**
  String get reportsSalesReport;

  /// No description provided for @reportsFuelConsumption.
  ///
  /// In en, this message translates to:
  /// **'Fuel Consumption'**
  String get reportsFuelConsumption;

  /// No description provided for @reportsCustomerAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Customer Analytics'**
  String get reportsCustomerAnalytics;

  /// No description provided for @reportsRevenueTrends.
  ///
  /// In en, this message translates to:
  /// **'Revenue Trends'**
  String get reportsRevenueTrends;

  /// No description provided for @reportsSelectPeriod.
  ///
  /// In en, this message translates to:
  /// **'Select Period'**
  String get reportsSelectPeriod;

  /// No description provided for @reportsGenerate.
  ///
  /// In en, this message translates to:
  /// **'Generate Report'**
  String get reportsGenerate;

  /// No description provided for @stockManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Stock Management'**
  String get stockManagementTitle;

  /// No description provided for @stockManagementTrackStock.
  ///
  /// In en, this message translates to:
  /// **'Track Stock'**
  String get stockManagementTrackStock;

  /// No description provided for @stockManagementLowStockAlerts.
  ///
  /// In en, this message translates to:
  /// **'Low Stock Alerts'**
  String get stockManagementLowStockAlerts;

  /// No description provided for @stockManagementStockHistory.
  ///
  /// In en, this message translates to:
  /// **'Stock History'**
  String get stockManagementStockHistory;

  /// No description provided for @stockManagementReorder.
  ///
  /// In en, this message translates to:
  /// **'Reorder Management'**
  String get stockManagementReorder;

  /// No description provided for @stockManagementCurrentStock.
  ///
  /// In en, this message translates to:
  /// **'Current Stock'**
  String get stockManagementCurrentStock;

  /// No description provided for @stockManagementMinThreshold.
  ///
  /// In en, this message translates to:
  /// **'Minimum Threshold'**
  String get stockManagementMinThreshold;

  /// No description provided for @stockManagementUpdateStock.
  ///
  /// In en, this message translates to:
  /// **'Update Stock'**
  String get stockManagementUpdateStock;

  /// No description provided for @stockManagementStockUpdated.
  ///
  /// In en, this message translates to:
  /// **'Stock updated successfully'**
  String get stockManagementStockUpdated;

  /// No description provided for @stockManagementLowStock.
  ///
  /// In en, this message translates to:
  /// **'Low Stock Alert'**
  String get stockManagementLowStock;

  /// No description provided for @stockManagementReorderLevel.
  ///
  /// In en, this message translates to:
  /// **'Reorder Level'**
  String get stockManagementReorderLevel;

  /// No description provided for @employeeManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Employee Management'**
  String get employeeManagementTitle;

  /// No description provided for @employeeManagementAddEmployee.
  ///
  /// In en, this message translates to:
  /// **'Add Employee'**
  String get employeeManagementAddEmployee;

  /// No description provided for @employeeManagementEditEmployee.
  ///
  /// In en, this message translates to:
  /// **'Edit Employee'**
  String get employeeManagementEditEmployee;

  /// No description provided for @employeeManagementFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get employeeManagementFullName;

  /// No description provided for @employeeManagementEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get employeeManagementEmail;

  /// No description provided for @employeeManagementPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get employeeManagementPhone;

  /// No description provided for @employeeManagementRole.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get employeeManagementRole;

  /// No description provided for @employeeManagementActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get employeeManagementActive;

  /// No description provided for @employeeManagementNoEmployees.
  ///
  /// In en, this message translates to:
  /// **'No employees found'**
  String get employeeManagementNoEmployees;

  /// No description provided for @employeeManagementDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Employee'**
  String get employeeManagementDeleteTitle;

  /// No description provided for @employeeManagementDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete {name}?'**
  String employeeManagementDeleteMessage(String name);

  /// No description provided for @stationHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'Station Hours'**
  String get stationHoursTitle;

  /// No description provided for @stationHoursManageHours.
  ///
  /// In en, this message translates to:
  /// **'Manage Hours'**
  String get stationHoursManageHours;

  /// No description provided for @stationHoursDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get stationHoursDay;

  /// No description provided for @stationHoursOpenTime.
  ///
  /// In en, this message translates to:
  /// **'Open Time'**
  String get stationHoursOpenTime;

  /// No description provided for @stationHoursCloseTime.
  ///
  /// In en, this message translates to:
  /// **'Close Time'**
  String get stationHoursCloseTime;

  /// No description provided for @stationHours24Hours.
  ///
  /// In en, this message translates to:
  /// **'24 Hours'**
  String get stationHours24Hours;

  /// No description provided for @stationHoursClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get stationHoursClosed;

  /// No description provided for @stationHoursMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get stationHoursMonday;

  /// No description provided for @stationHoursTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get stationHoursTuesday;

  /// No description provided for @stationHoursWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get stationHoursWednesday;

  /// No description provided for @stationHoursThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get stationHoursThursday;

  /// No description provided for @stationHoursFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get stationHoursFriday;

  /// No description provided for @stationHoursSaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get stationHoursSaturday;

  /// No description provided for @stationHoursSunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get stationHoursSunday;

  /// No description provided for @customerManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'Customer Management'**
  String get customerManagementTitle;

  /// No description provided for @customerManagementAllCustomers.
  ///
  /// In en, this message translates to:
  /// **'All Customers'**
  String get customerManagementAllCustomers;

  /// No description provided for @customerManagementSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search customers...'**
  String get customerManagementSearchHint;

  /// No description provided for @customerManagementNoCustomers.
  ///
  /// In en, this message translates to:
  /// **'No customers found'**
  String get customerManagementNoCustomers;

  /// No description provided for @customerManagementTotalPurchases.
  ///
  /// In en, this message translates to:
  /// **'Total Purchases'**
  String get customerManagementTotalPurchases;

  /// No description provided for @customerManagementTotalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total Spent'**
  String get customerManagementTotalSpent;

  /// No description provided for @promotionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Promotions & Discounts'**
  String get promotionsTitle;

  /// No description provided for @promotionsAddPromotion.
  ///
  /// In en, this message translates to:
  /// **'Add Promotion'**
  String get promotionsAddPromotion;

  /// No description provided for @promotionsEditPromotion.
  ///
  /// In en, this message translates to:
  /// **'Edit Promotion'**
  String get promotionsEditPromotion;

  /// No description provided for @promotionsTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get promotionsTitleLabel;

  /// No description provided for @promotionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get promotionsDescription;

  /// No description provided for @promotionsDiscountPercent.
  ///
  /// In en, this message translates to:
  /// **'Discount (%)'**
  String get promotionsDiscountPercent;

  /// No description provided for @promotionsDiscountAmount.
  ///
  /// In en, this message translates to:
  /// **'Discount Amount (KES)'**
  String get promotionsDiscountAmount;

  /// No description provided for @promotionsStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get promotionsStartDate;

  /// No description provided for @promotionsEndDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get promotionsEndDate;

  /// No description provided for @promotionsActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get promotionsActive;

  /// No description provided for @promotionsNoPromotions.
  ///
  /// In en, this message translates to:
  /// **'No promotions found'**
  String get promotionsNoPromotions;

  /// No description provided for @promotionsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Promotion'**
  String get promotionsDeleteTitle;

  /// No description provided for @promotionsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this promotion?'**
  String get promotionsDeleteMessage;

  /// No description provided for @paymentMethodsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethodsTitle;

  /// No description provided for @paymentMethodsAddMethod.
  ///
  /// In en, this message translates to:
  /// **'Add Payment Method'**
  String get paymentMethodsAddMethod;

  /// No description provided for @paymentMethodsEditMethod.
  ///
  /// In en, this message translates to:
  /// **'Edit Payment Method'**
  String get paymentMethodsEditMethod;

  /// No description provided for @paymentMethodsMethodName.
  ///
  /// In en, this message translates to:
  /// **'Method Name'**
  String get paymentMethodsMethodName;

  /// No description provided for @paymentMethodsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get paymentMethodsEnabled;

  /// No description provided for @paymentMethodsAccountDetails.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get paymentMethodsAccountDetails;

  /// No description provided for @paymentMethodsNoMethods.
  ///
  /// In en, this message translates to:
  /// **'No payment methods found'**
  String get paymentMethodsNoMethods;

  /// No description provided for @paymentMethodsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Payment Method'**
  String get paymentMethodsDeleteTitle;

  /// No description provided for @paymentMethodsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this payment method?'**
  String get paymentMethodsDeleteMessage;
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
