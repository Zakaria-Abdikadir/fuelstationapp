// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Application Station-Service';

  @override
  String get appName => 'Station-Service';

  @override
  String get appTagline => 'Votre solution numérique pour le carburant';

  @override
  String get navHome => 'Accueil';

  @override
  String get navFuel => 'Carburant';

  @override
  String get navPayment => 'Paiement';

  @override
  String get navDashboard => 'Tableau de bord';

  @override
  String get navManageStations => 'Gérer les stations';

  @override
  String get navManagePrices => 'Gérer les prix';

  @override
  String get navReports => 'Rapports';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get navStations => 'Stations';

  @override
  String get navProfile => 'Profile';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonDone => 'Terminé';

  @override
  String get commonRefresh => 'Actualiser';

  @override
  String get commonSelect => 'Sélectionner';

  @override
  String get commonLogout => 'Déconnexion';

  @override
  String get commonClear => 'Effacer';

  @override
  String get commonPrint => 'Imprimer';

  @override
  String get commonViewReceipt => 'Voir le reçu';

  @override
  String get commonName => 'Nom';

  @override
  String get commonEmail => 'E-mail';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsSectionProfile => 'Profile';

  @override
  String get settingsSectionGeneral => 'Général';

  @override
  String get settingsSectionData => 'Données';

  @override
  String get settingsSectionAbout => 'À propos';

  @override
  String get settingsNotificationsTitle => 'Notifications';

  @override
  String get settingsNotificationsSubtitle =>
      'Activer ou désactiver les notifications';

  @override
  String get settingsLanguageTitle => 'Langue';

  @override
  String get settingsThemeTitle => 'Thème';

  @override
  String get settingsBackupTitle => 'Sauvegarder les données';

  @override
  String get settingsBackupSubtitle => 'Sauvegardez vos données sur le cloud';

  @override
  String get settingsRestoreTitle => 'Restaurer les données';

  @override
  String get settingsRestoreSubtitle =>
      'Restaurer les données depuis une sauvegarde';

  @override
  String get settingsClearCacheTitle => 'Vider le cache';

  @override
  String get settingsClearCacheSubtitle =>
      'Vider le cache et les fichiers temporaires';

  @override
  String get settingsAppVersionTitle => 'Version de l\'application';

  @override
  String get settingsTermsTitle => 'Conditions générales';

  @override
  String get settingsTermsSubtitle => 'Lire nos conditions générales';

  @override
  String get settingsPrivacyTitle => 'Politique de confidentialité';

  @override
  String get settingsPrivacySubtitle =>
      'Lire notre politique de confidentialité';

  @override
  String get settingsLanguageDialogTitle => 'Choisir la langue';

  @override
  String get settingsThemeDialogTitle => 'Choisir le thème';

  @override
  String get settingsProfileTitle => 'Profile';

  @override
  String get settingsProfileSubtitle => 'View and edit your profile';

  @override
  String get settingsProfileEditTitle => 'Modifier le profil';

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
  String get settingsProfileFillAllFields => 'Veuillez remplir tous les champs';

  @override
  String get settingsProfileUpdated => 'Profil mis à jour avec succès';

  @override
  String get settingsProfilePhotoUpdated => 'Photo de profil mise à jour';

  @override
  String get settingsProfilePhotoError =>
      'Impossible de mettre à jour la photo de profil';

  @override
  String get settingsChangePhoto => 'Changer la photo';

  @override
  String settingsLanguageChanged(String language) {
    return 'Langue changée en $language. Paramètre enregistré.';
  }

  @override
  String settingsThemeChanged(String theme) {
    return 'Thème changé en $theme';
  }

  @override
  String get settingsLogoutDialogTitle => 'Déconnexion';

  @override
  String get settingsLogoutDialogMessage =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get settingsLogoutSuccess => 'Déconnexion réussie';

  @override
  String get settingsClearCacheDialogTitle => 'Vider le cache';

  @override
  String get settingsClearCacheDialogMessage =>
      'Voulez-vous vraiment vider tout le cache ?';

  @override
  String get settingsClearCacheSuccess => 'Cache vidé avec succès';

  @override
  String settingsBackupSuccess(String path) {
    return 'Sauvegarde enregistrée dans $path';
  }

  @override
  String settingsBackupError(String error) {
    return 'Échec de la sauvegarde : $error';
  }

  @override
  String get settingsRestoreSuccess => 'Données restaurées avec succès.';

  @override
  String settingsRestoreError(String error) {
    return 'Échec de la restauration : $error';
  }

  @override
  String get languageEnglish => 'Anglais';

  @override
  String get languageSwahili => 'Swahili';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageSpanish => 'Espagnol';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get termsAndConditionsTitle => 'Conditions générales';

  @override
  String termsAndConditionsBody(int year) {
    return '1. Acceptation des conditions\nEn utilisant cette application Station-Service, vous acceptez d\'être lié par ces Conditions Générales.\n\n2. Utilisation du service\nL\'application est fournie uniquement pour l\'achat et la gestion du carburant.\n\n3. Responsabilités de l\'utilisateur\n- Les utilisateurs doivent fournir des informations exactes\n- Les utilisateurs sont responsables de la sécurité de leur compte\n- Les utilisateurs doivent respecter toutes les lois applicables\n\n4. Limitation de responsabilité\nLe fournisseur de l\'application n\'est pas responsable des dommages résultant de l\'utilisation du service.\n\n5. Modifications\nNous nous réservons le droit de modifier ces conditions à tout moment.\n\nDernière mise à jour : $year';
  }

  @override
  String get privacyPolicyTitle => 'Politique de confidentialité';

  @override
  String privacyPolicyBody(int year) {
    return 'Politique de confidentialité\n\n1. Informations collectées\n- Informations personnelles (nom, e-mail)\n- Données de localisation pour trouver les stations à proximité\n- Historique d\'achat et préférences\n\n2. Utilisation des informations\n- Fournir et améliorer nos services\n- Traiter les transactions\n- Envoyer des notifications importantes\n\n3. Sécurité des données\nNous mettons en œuvre des mesures de sécurité appropriées pour protéger vos informations personnelles.\n\n4. Partage des données\nNous ne vendons pas vos informations personnelles. Nous pouvons partager des données uniquement pour la fourniture du service.\n\n5. Vos droits\n- Accéder à vos données personnelles\n- Demander la suppression des données\n- Mettre à jour vos informations\n\n6. Contactez-nous\nPour toute question de confidentialité, contactez privacy@fuelstation.com\n\nDernière mise à jour : $year';
  }

  @override
  String get homeTitle => 'Trouver des stations-service';

  @override
  String get homeSearchHint => 'Recherchez des stations ou des lieux...';

  @override
  String get homeNearbyStations => 'Stations à proximité';

  @override
  String homeStationsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count stations trouvées',
      one: '$count station trouvée',
      zero: 'Aucune station trouvée',
    );
    return '$_temp0';
  }

  @override
  String get homeNoStationsFound => 'Aucune station trouvée à proximité';

  @override
  String get homeRefresh => 'Actualiser';

  @override
  String get homeErrorLocationServicesDisabled =>
      'Les services de localisation sont désactivés. Veuillez les activer.';

  @override
  String get homeErrorLocationDenied =>
      'Les autorisations de localisation sont refusées.';

  @override
  String get homeErrorLocationDeniedForever =>
      'Les autorisations de localisation sont refusées en permanence.';

  @override
  String homeErrorGettingLocation(String error) {
    return 'Erreur lors de l\'obtention de la localisation : $error';
  }

  @override
  String homeErrorLoadingStations(String error) {
    return 'Erreur lors du chargement des stations : $error';
  }

  @override
  String get homeNoStationsFoundAction => 'Actualiser';

  @override
  String stationDistanceAway(String distance) {
    return 'À $distance km';
  }

  @override
  String get stationClosedLabel => 'Fermé';

  @override
  String get stationSelectButton => 'Sélectionner';

  @override
  String get fuelTypePetrol => 'Essence';

  @override
  String get fuelTypeDiesel => 'Diesel';

  @override
  String get fuelSelectFuelType => 'Choisir le type de carburant';

  @override
  String get fuelEnterQuantity => 'Entrer la quantité';

  @override
  String get fuelChoiceAmount => 'Montant (KES)';

  @override
  String get fuelChoiceLiters => 'Litres (L)';

  @override
  String get fuelInputAmountLabel => 'Montant (KES)';

  @override
  String get fuelInputLitersLabel => 'Litres (L)';

  @override
  String get fuelInputAmountHint => 'Entrer le montant';

  @override
  String get fuelInputLitersHint => 'Entrer les litres';

  @override
  String get fuelPricePerLiterLabel => 'Prix par litre :';

  @override
  String get fuelLitersLabel => 'Litres :';

  @override
  String get fuelAmountLabel => 'Montant :';

  @override
  String get fuelTotalLabel => 'Total :';

  @override
  String get fuelInProgressTitle => 'Distribution en cours...';

  @override
  String get fuelStopButton => 'Arrêter la distribution';

  @override
  String get fuelStartButton => 'Commencer la distribution';

  @override
  String get fuelErrorEnterAmountOrLiters =>
      'Veuillez entrer un montant ou un volume';

  @override
  String fuelPumpStatus(String status) {
    return 'Pompe : $status';
  }

  @override
  String get pumpStatusIdle => 'Libre';

  @override
  String get pumpStatusBusy => 'Occupée';

  @override
  String get pumpStatusInUse => 'En cours';

  @override
  String get paymentTitle => 'Paiement';

  @override
  String get paymentSummaryTitle => 'Récapitulatif de la transaction';

  @override
  String get paymentSummaryStation => 'Station';

  @override
  String get paymentSummaryFuelType => 'Type de carburant';

  @override
  String get paymentSummaryQuantity => 'Quantité';

  @override
  String get paymentSummaryPricePerLiter => 'Prix par litre';

  @override
  String get paymentSummaryTotalLabel => 'Montant total :';

  @override
  String get paymentMethodTitle => 'Choisir le mode de paiement';

  @override
  String get paymentMethodMpesa => 'M-Pesa';

  @override
  String get paymentMethodCard => 'Carte';

  @override
  String get paymentMethodCash => 'Espèces';

  @override
  String get paymentButtonPayNow => 'Payer maintenant';

  @override
  String get paymentProcessing => 'Traitement...';

  @override
  String paymentError(String error) {
    return 'Échec du paiement : $error';
  }

  @override
  String get paymentSuccessAppBarTitle => 'Paiement réussi';

  @override
  String get paymentSuccessTitle => 'Paiement effectué avec succès !';

  @override
  String get paymentSuccessButtonViewReceipt => 'Voir le reçu';

  @override
  String get paymentSuccessButtonDone => 'Terminé';

  @override
  String get paymentReceiptTitle => 'Reçu';

  @override
  String get paymentReceiptTransactionId => 'ID de transaction';

  @override
  String get paymentReceiptDate => 'Date';

  @override
  String get paymentReceiptFuelType => 'Type de carburant';

  @override
  String get paymentReceiptQuantity => 'Quantité';

  @override
  String get paymentReceiptPricePerLiter => 'Prix par litre';

  @override
  String get paymentReceiptTotalAmount => 'Montant total';

  @override
  String get paymentReceiptPaymentMethod => 'Mode de paiement';

  @override
  String get paymentReceiptSuccessMessage => 'Paiement réussi';

  @override
  String get paymentReceiptSuccessTagline => 'Paiement réussi';

  @override
  String get paymentReceiptPrinted => 'Reçu imprimé avec succès';

  @override
  String get mainPlaceholderFuelTitle => 'Carburant';

  @override
  String get mainPlaceholderFuelMessage =>
      'Veuillez sélectionner une station depuis l\'accueil';

  @override
  String get mainPlaceholderPaymentTitle => 'Paiement';

  @override
  String get mainPlaceholderPaymentMessage =>
      'Terminez une session de ravitaillement pour continuer';

  @override
  String get dashboardTitle => 'Tableau de bord';

  @override
  String get dashboardPeriodToday => 'Aujourd\'hui';

  @override
  String get dashboardPeriodWeek => 'Cette semaine';

  @override
  String get dashboardPeriodMonth => 'Ce mois-ci';

  @override
  String get dashboardStatTotalSales => 'Ventes totales';

  @override
  String get dashboardStatFuelDispensed => 'Carburant distribué';

  @override
  String get dashboardStatReceipts => 'Reçus';

  @override
  String get dashboardStatTransactions => 'Transactions';

  @override
  String get dashboardSalesPerformanceTitle => 'Performance des ventes';

  @override
  String get dashboardSalesPerformanceEmpty =>
      'Aucune donnée de vente disponible';

  @override
  String get dashboardRecentTransactionsTitle => 'Transactions récentes';

  @override
  String get dashboardRecentTransactionsEmpty => 'Aucune transaction récente';

  @override
  String get dashboardQuickActionsTitle => 'Actions rapides';

  @override
  String get dashboardQuickActionManageStations => 'Gérer les stations';

  @override
  String get dashboardQuickActionUpdatePrices => 'Mettre à jour les prix';

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
  String get receiptPaymentSuccessfulBanner => 'Paiement réussi';

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
