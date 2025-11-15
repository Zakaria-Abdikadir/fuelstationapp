// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appTitle => 'Programu ya Kituo cha Mafuta';

  @override
  String get appName => 'Kituo cha Mafuta';

  @override
  String get appTagline => 'Suluhisho lako la Kidijitali la Mafuta';

  @override
  String get navHome => 'Mwanzo';

  @override
  String get navFuel => 'Mafuta';

  @override
  String get navPayment => 'Malipo';

  @override
  String get navDashboard => 'Dashibodi';

  @override
  String get navManageStations => 'Dhibiti Vituo';

  @override
  String get navManagePrices => 'Sasisha Bei';

  @override
  String get navReports => 'Ripoti';

  @override
  String get navSettings => 'Mipangilio';

  @override
  String get commonCancel => 'Ghairi';

  @override
  String get commonClose => 'Funga';

  @override
  String get commonSave => 'Hifadhi';

  @override
  String get commonDone => 'Imekamilika';

  @override
  String get commonRefresh => 'Onyesha upya';

  @override
  String get commonSelect => 'Chagua';

  @override
  String get commonLogout => 'Toka';

  @override
  String get commonClear => 'Futa';

  @override
  String get commonPrint => 'Chapisha';

  @override
  String get commonViewReceipt => 'Tazama Risiti';

  @override
  String get commonName => 'Jina';

  @override
  String get commonEmail => 'Barua pepe';

  @override
  String get commonContinue => 'Endelea';

  @override
  String get settingsTitle => 'Mipangilio';

  @override
  String get settingsSectionGeneral => 'Jumla';

  @override
  String get settingsSectionData => 'Data';

  @override
  String get settingsSectionAbout => 'Kuhusu';

  @override
  String get settingsNotificationsTitle => 'Arifa';

  @override
  String get settingsNotificationsSubtitle => 'Washa au zima arifa';

  @override
  String get settingsLanguageTitle => 'Lugha';

  @override
  String get settingsThemeTitle => 'Mandhari';

  @override
  String get settingsBackupTitle => 'Hifadhi Nakala ya Data';

  @override
  String get settingsBackupSubtitle => 'Hifadhi data yako kwenye wingu';

  @override
  String get settingsRestoreTitle => 'Rejesha Data';

  @override
  String get settingsRestoreSubtitle => 'Rejesha data kutoka kwenye nakala';

  @override
  String get settingsClearCacheTitle => 'Futa Kache';

  @override
  String get settingsClearCacheSubtitle =>
      'Futa kache na faili za muda za programu';

  @override
  String get settingsAppVersionTitle => 'Toleo la Programu';

  @override
  String get settingsTermsTitle => 'Sheria na Masharti';

  @override
  String get settingsTermsSubtitle => 'Soma sheria na masharti yetu';

  @override
  String get settingsPrivacyTitle => 'Sera ya Faragha';

  @override
  String get settingsPrivacySubtitle => 'Soma sera yetu ya faragha';

  @override
  String get settingsLanguageDialogTitle => 'Chagua Lugha';

  @override
  String get settingsThemeDialogTitle => 'Chagua Mandhari';

  @override
  String get settingsProfileEditTitle => 'Hariri Wasifu';

  @override
  String get settingsProfileFillAllFields => 'Tafadhali jaza maeneo yote';

  @override
  String get settingsProfileUpdated => 'Wasifu umeboreshwa kwa mafanikio';

  @override
  String get settingsProfilePhotoUpdated => 'Picha ya wasifu imesasishwa';

  @override
  String get settingsProfilePhotoError =>
      'Imeshindikana kusasisha picha ya wasifu';

  @override
  String get settingsChangePhoto => 'Badilisha picha';

  @override
  String settingsLanguageChanged(String language) {
    return 'Lugha imebadilishwa kuwa $language. Mpangilio umehifadhiwa.';
  }

  @override
  String settingsThemeChanged(String theme) {
    return 'Mandhari imebadilishwa kuwa $theme';
  }

  @override
  String get settingsLogoutDialogTitle => 'Toka';

  @override
  String get settingsLogoutDialogMessage => 'Una uhakika unataka kutoka?';

  @override
  String get settingsLogoutSuccess => 'Umetoka kwa mafanikio';

  @override
  String get settingsClearCacheDialogTitle => 'Futa Kache';

  @override
  String get settingsClearCacheDialogMessage =>
      'Una uhakika unataka kufuta kache yote?';

  @override
  String get settingsClearCacheSuccess => 'Kache imefutwa kwa mafanikio';

  @override
  String settingsBackupSuccess(String path) {
    return 'Nakala imehifadhiwa kwenye $path';
  }

  @override
  String settingsBackupError(String error) {
    return 'Kuhifadhi nakala kimeshindwa: $error';
  }

  @override
  String get settingsRestoreSuccess => 'Data imerejeshwa kwa mafanikio.';

  @override
  String settingsRestoreError(String error) {
    return 'Kurejesha kimeshindwa: $error';
  }

  @override
  String get languageEnglish => 'Kiingereza';

  @override
  String get languageSwahili => 'Kiswahili';

  @override
  String get languageFrench => 'Kifaransa';

  @override
  String get languageSpanish => 'Kihispania';

  @override
  String get themeLight => 'Nuru';

  @override
  String get themeDark => 'Giza';

  @override
  String get themeSystem => 'Mfumo';

  @override
  String get termsAndConditionsTitle => 'Sheria na Masharti';

  @override
  String termsAndConditionsBody(int year) {
    return '1. Kukubalika kwa Sheria\nKwa kutumia Programu hii ya Kituo cha Mafuta, unakubali kufungwa na Sheria na Masharti haya.\n\n2. Matumizi ya Huduma\nProgramu hii imetolewa kwa ajili ya ununuzi wa mafuta na usimamizi pekee.\n\n3. Wajibu wa Mtumiaji\n- Watumiaji wanapaswa kutoa taarifa sahihi\n- Watumiaji wanawajibika kulinda usalama wa akaunti\n- Watumiaji lazima watii sheria zote zinazohusika\n\n4. Kiasi cha Uwajibikaji\nMtoa programu hayawajibiki kwa madhara yoyote yanayotokana na matumizi ya huduma hii.\n\n5. Mabadiliko\nTunahifadhi haki ya kubadilisha sheria hizi wakati wowote.\n\nImesasishwa mwisho: $year';
  }

  @override
  String get privacyPolicyTitle => 'Sera ya Faragha';

  @override
  String privacyPolicyBody(int year) {
    return 'Sera ya Faragha\n\n1. Taarifa Tunazokusanya\n- Taarifa binafsi (jina, barua pepe)\n- Data ya eneo kwa ajili ya kupata vituo vilivyo karibu\n- Historia ya ununuzi na mapendeleo\n\n2. Jinsi Tunavyotumia Taarifa Zako\n- Kutoa na kuboresha huduma zetu\n- Kuchakata miamala\n- Kutuma arifa muhimu\n\n3. Usalama wa Data\nTunatumia hatua zinazofaa za usalama kulinda taarifa zako binafsi.\n\n4. Kushiriki Data\nHatuzui taarifa zako binafsi. Tunaweza kushiriki data kwa ajili ya utoaji huduma pekee.\n\n5. Haki Zako\n- Kufikia data zako binafsi\n- Kuomba kufutwa kwa data\n- Kusasisha taarifa zako\n\n6. Wasiliana Nasi\nKwa masuala ya faragha, wasiliana nasi kupitia privacy@fuelstation.com\n\nImesasishwa mwisho: $year';
  }

  @override
  String get homeTitle => 'Tafuta Vituo vya Mafuta';

  @override
  String get homeSearchHint => 'Tafuta vituo au maeneo...';

  @override
  String get homeNearbyStations => 'Vituo Vilivyo Karibu';

  @override
  String homeStationsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vituo $count vimepatikana',
      one: 'Kituo $count kimepatikana',
      zero: 'Hakuna vituo vilivyopatikana',
    );
    return '$_temp0';
  }

  @override
  String get homeNoStationsFound => 'Hakuna vituo vilivyo karibu';

  @override
  String get homeRefresh => 'Onyesha upya';

  @override
  String get homeErrorLocationServicesDisabled =>
      'Huduma za eneo zimezimwa. Tafadhali ziwashe.';

  @override
  String get homeErrorLocationDenied => 'Ruhusa za eneo zimekataliwa.';

  @override
  String get homeErrorLocationDeniedForever =>
      'Ruhusa za eneo zimekataliwa kabisa.';

  @override
  String homeErrorGettingLocation(String error) {
    return 'Hitilafu katika kupata eneo: $error';
  }

  @override
  String homeErrorLoadingStations(String error) {
    return 'Hitilafu katika kupakia vituo: $error';
  }

  @override
  String get homeNoStationsFoundAction => 'Onyesha upya';

  @override
  String stationDistanceAway(String distance) {
    return '$distance km kutoka';
  }

  @override
  String get stationClosedLabel => 'Imefungwa';

  @override
  String get stationSelectButton => 'Chagua';

  @override
  String get fuelTypePetrol => 'Petroli';

  @override
  String get fuelTypeDiesel => 'Dizeli';

  @override
  String get fuelSelectFuelType => 'Chagua Aina ya Mafuta';

  @override
  String get fuelEnterQuantity => 'Ingiza Kiasi';

  @override
  String get fuelChoiceAmount => 'Kiasi (KES)';

  @override
  String get fuelChoiceLiters => 'Lita (L)';

  @override
  String get fuelInputAmountLabel => 'Kiasi (KES)';

  @override
  String get fuelInputLitersLabel => 'Lita (L)';

  @override
  String get fuelInputAmountHint => 'Ingiza kiasi';

  @override
  String get fuelInputLitersHint => 'Ingiza lita';

  @override
  String get fuelPricePerLiterLabel => 'Bei kwa Lita:';

  @override
  String get fuelLitersLabel => 'Lita:';

  @override
  String get fuelAmountLabel => 'Kiasi:';

  @override
  String get fuelTotalLabel => 'Jumla:';

  @override
  String get fuelInProgressTitle => 'Kumimina Mafuta Kunaendelea...';

  @override
  String get fuelStopButton => 'Simamisha Kumimina';

  @override
  String get fuelStartButton => 'Anza Kumimina';

  @override
  String get fuelErrorEnterAmountOrLiters => 'Tafadhali ingiza kiasi au lita';

  @override
  String fuelPumpStatus(String status) {
    return 'Pampu: $status';
  }

  @override
  String get pumpStatusIdle => 'Haifanyi kazi';

  @override
  String get pumpStatusBusy => 'Ina kazi';

  @override
  String get pumpStatusInUse => 'Inaendelea';

  @override
  String get paymentTitle => 'Malipo';

  @override
  String get paymentSummaryTitle => 'Muhtasari wa Muamala';

  @override
  String get paymentSummaryStation => 'Kituo';

  @override
  String get paymentSummaryFuelType => 'Aina ya Mafuta';

  @override
  String get paymentSummaryQuantity => 'Kiasi';

  @override
  String get paymentSummaryPricePerLiter => 'Bei kwa Lita';

  @override
  String get paymentSummaryTotalLabel => 'Jumla ya Malipo:';

  @override
  String get paymentMethodTitle => 'Chagua Njia ya Malipo';

  @override
  String get paymentMethodMpesa => 'M-Pesa';

  @override
  String get paymentMethodCard => 'Kadi';

  @override
  String get paymentMethodCash => 'Fedha taslimu';

  @override
  String get paymentButtonPayNow => 'Lipa Sasa';

  @override
  String get paymentProcessing => 'Inachakata...';

  @override
  String paymentError(String error) {
    return 'Malipo yameshindwa: $error';
  }

  @override
  String get paymentSuccessAppBarTitle => 'Malipo Yamefaulu';

  @override
  String get paymentSuccessTitle => 'Malipo Yamekamilika Kwa Mafanikio!';

  @override
  String get paymentSuccessButtonViewReceipt => 'Tazama Risiti';

  @override
  String get paymentSuccessButtonDone => 'Imekamilika';

  @override
  String get paymentReceiptTitle => 'Risiti';

  @override
  String get paymentReceiptTransactionId => 'Kitambulisho cha Muamala';

  @override
  String get paymentReceiptDate => 'Tarehe';

  @override
  String get paymentReceiptFuelType => 'Aina ya Mafuta';

  @override
  String get paymentReceiptQuantity => 'Kiasi';

  @override
  String get paymentReceiptPricePerLiter => 'Bei kwa Lita';

  @override
  String get paymentReceiptTotalAmount => 'Jumla ya Malipo';

  @override
  String get paymentReceiptPaymentMethod => 'Njia ya Malipo';

  @override
  String get paymentReceiptSuccessMessage => 'Malipo Yamefaulu';

  @override
  String get paymentReceiptSuccessTagline => 'Malipo Yamefaulu';

  @override
  String get paymentReceiptPrinted => 'Risiti imechapishwa kwa mafanikio';

  @override
  String get mainPlaceholderFuelTitle => 'Mafuta';

  @override
  String get mainPlaceholderFuelMessage =>
      'Tafadhali chagua kituo kutoka Mwanzo';

  @override
  String get mainPlaceholderPaymentTitle => 'Malipo';

  @override
  String get mainPlaceholderPaymentMessage =>
      'Kamilisha mchakato wa kumimina ili kuendelea';

  @override
  String get dashboardTitle => 'Dashibodi';

  @override
  String get dashboardPeriodToday => 'Leo';

  @override
  String get dashboardPeriodWeek => 'Wiki Hii';

  @override
  String get dashboardPeriodMonth => 'Mwezi Huu';

  @override
  String get dashboardStatTotalSales => 'Jumla ya Mauzo';

  @override
  String get dashboardStatFuelDispensed => 'Mafuta Yaliyotolewa';

  @override
  String get dashboardStatReceipts => 'Risiti';

  @override
  String get dashboardStatTransactions => 'Miamala';

  @override
  String get dashboardSalesPerformanceTitle => 'Utendaji wa Mauzo';

  @override
  String get dashboardSalesPerformanceEmpty => 'Hakuna data ya mauzo';

  @override
  String get dashboardRecentTransactionsTitle => 'Miamala ya Hivi Karibuni';

  @override
  String get dashboardRecentTransactionsEmpty =>
      'Hakuna miamala ya hivi karibuni';

  @override
  String get dashboardQuickActionsTitle => 'Vitendo vya Haraka';

  @override
  String get dashboardQuickActionManageStations => 'Dhibiti Vituo';

  @override
  String get dashboardQuickActionUpdatePrices => 'Sasisha Bei';

  @override
  String get receiptPaymentSuccessfulBanner => 'Malipo Yamefaulu';
}
