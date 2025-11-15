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
  String get settingsProfileEditTitle => 'Modifier le profil';

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
  String get receiptPaymentSuccessfulBanner => 'Paiement réussi';
}
