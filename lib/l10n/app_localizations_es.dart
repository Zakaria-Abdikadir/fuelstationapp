// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Aplicación Estación de Combustible';

  @override
  String get appName => 'Estación de Combustible';

  @override
  String get appTagline => 'Tu solución digital de combustible';

  @override
  String get navHome => 'Inicio';

  @override
  String get navFuel => 'Combustible';

  @override
  String get navPayment => 'Pago';

  @override
  String get navDashboard => 'Tablero';

  @override
  String get navManageStations => 'Gestionar estaciones';

  @override
  String get navManagePrices => 'Gestionar precios';

  @override
  String get navReports => 'Reportes';

  @override
  String get navSettings => 'Configuración';

  @override
  String get navStations => 'Stations';

  @override
  String get navProfile => 'Profile';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDone => 'Listo';

  @override
  String get commonRefresh => 'Actualizar';

  @override
  String get commonSelect => 'Seleccionar';

  @override
  String get commonLogout => 'Cerrar sesión';

  @override
  String get commonClear => 'Limpiar';

  @override
  String get commonPrint => 'Imprimir';

  @override
  String get commonViewReceipt => 'Ver recibo';

  @override
  String get commonName => 'Nombre';

  @override
  String get commonEmail => 'Correo electrónico';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsSectionProfile => 'Profile';

  @override
  String get settingsSectionGeneral => 'General';

  @override
  String get settingsSectionData => 'Datos';

  @override
  String get settingsSectionAbout => 'Acerca de';

  @override
  String get settingsNotificationsTitle => 'Notificaciones';

  @override
  String get settingsNotificationsSubtitle =>
      'Activar o desactivar notificaciones';

  @override
  String get settingsLanguageTitle => 'Idioma';

  @override
  String get settingsThemeTitle => 'Tema';

  @override
  String get settingsBackupTitle => 'Respaldar datos';

  @override
  String get settingsBackupSubtitle => 'Respaldar tus datos en la nube';

  @override
  String get settingsRestoreTitle => 'Restaurar datos';

  @override
  String get settingsRestoreSubtitle => 'Restaurar datos desde un respaldo';

  @override
  String get settingsClearCacheTitle => 'Limpiar caché';

  @override
  String get settingsClearCacheSubtitle =>
      'Limpiar caché y archivos temporales';

  @override
  String get settingsAppVersionTitle => 'Versión de la aplicación';

  @override
  String get settingsTermsTitle => 'Términos y condiciones';

  @override
  String get settingsTermsSubtitle => 'Lee nuestros términos y condiciones';

  @override
  String get settingsPrivacyTitle => 'Política de privacidad';

  @override
  String get settingsPrivacySubtitle => 'Lee nuestra política de privacidad';

  @override
  String get settingsLanguageDialogTitle => 'Seleccionar idioma';

  @override
  String get settingsThemeDialogTitle => 'Seleccionar tema';

  @override
  String get settingsProfileTitle => 'Profile';

  @override
  String get settingsProfileSubtitle => 'View and edit your profile';

  @override
  String get settingsProfileEditTitle => 'Editar perfil';

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
  String get settingsProfileFillAllFields =>
      'Por favor completa todos los campos';

  @override
  String get settingsProfileUpdated => 'Perfil actualizado correctamente';

  @override
  String get settingsProfilePhotoUpdated => 'Foto de perfil actualizada';

  @override
  String get settingsProfilePhotoError =>
      'No se pudo actualizar la foto de perfil';

  @override
  String get settingsChangePhoto => 'Cambiar foto';

  @override
  String settingsLanguageChanged(String language) {
    return 'El idioma cambió a $language. Ajuste guardado.';
  }

  @override
  String settingsThemeChanged(String theme) {
    return 'El tema cambió a $theme';
  }

  @override
  String get settingsLogoutDialogTitle => 'Cerrar sesión';

  @override
  String get settingsLogoutDialogMessage => '¿Seguro que deseas cerrar sesión?';

  @override
  String get settingsLogoutSuccess => 'Sesión cerrada correctamente';

  @override
  String get settingsClearCacheDialogTitle => 'Limpiar caché';

  @override
  String get settingsClearCacheDialogMessage =>
      '¿Seguro que deseas limpiar todo el caché?';

  @override
  String get settingsClearCacheSuccess => 'Caché limpiado correctamente';

  @override
  String settingsBackupSuccess(String path) {
    return 'Respaldo guardado en $path';
  }

  @override
  String settingsBackupError(String error) {
    return 'Error al crear el respaldo: $error';
  }

  @override
  String get settingsRestoreSuccess => 'Datos restaurados correctamente.';

  @override
  String settingsRestoreError(String error) {
    return 'No se pudo restaurar: $error';
  }

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageSwahili => 'Suajili';

  @override
  String get languageFrench => 'Francés';

  @override
  String get languageSpanish => 'Español';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get termsAndConditionsTitle => 'Términos y condiciones';

  @override
  String termsAndConditionsBody(int year) {
    return '1. Aceptación de los términos\nAl usar esta Aplicación Estación de Combustible, aceptas estar sujeto a estos Términos y Condiciones.\n\n2. Uso del servicio\nLa aplicación se proporciona únicamente para la compra y gestión de combustible.\n\n3. Responsabilidades del usuario\n- Los usuarios deben proporcionar información precisa\n- Los usuarios son responsables de la seguridad de su cuenta\n- Los usuarios deben cumplir con todas las leyes aplicables\n\n4. Limitación de responsabilidad\nEl proveedor de la aplicación no se hace responsable de los daños que surjan del uso de este servicio.\n\n5. Modificaciones\nNos reservamos el derecho de modificar estos términos en cualquier momento.\n\nÚltima actualización: $year';
  }

  @override
  String get privacyPolicyTitle => 'Política de privacidad';

  @override
  String privacyPolicyBody(int year) {
    return 'Política de privacidad\n\n1. Información que recopilamos\n- Información personal (nombre, correo electrónico)\n- Datos de ubicación para encontrar estaciones cercanas\n- Historial de compras y preferencias\n\n2. Cómo usamos tu información\n- Para proporcionar y mejorar nuestros servicios\n- Para procesar transacciones\n- Para enviar notificaciones importantes\n\n3. Seguridad de datos\nImplementamos medidas de seguridad adecuadas para proteger tu información personal.\n\n4. Compartir datos\nNo vendemos tu información personal. Podemos compartir datos solo para la prestación del servicio.\n\n5. Tus derechos\n- Acceder a tus datos personales\n- Solicitar la eliminación de datos\n- Actualizar tu información\n\n6. Contáctanos\nPara inquietudes de privacidad, contáctanos en privacy@fuelstation.com\n\nÚltima actualización: $year';
  }

  @override
  String get homeTitle => 'Buscar estaciones de combustible';

  @override
  String get homeSearchHint => 'Busca estaciones o ubicaciones...';

  @override
  String get homeNearbyStations => 'Estaciones cercanas';

  @override
  String homeStationsFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se encontraron $count estaciones',
      one: 'Se encontró $count estación',
      zero: 'No se encontraron estaciones',
    );
    return '$_temp0';
  }

  @override
  String get homeNoStationsFound => 'No se encontraron estaciones cercanas';

  @override
  String get homeRefresh => 'Actualizar';

  @override
  String get homeErrorLocationServicesDisabled =>
      'Los servicios de ubicación están desactivados. Por favor actívalos.';

  @override
  String get homeErrorLocationDenied =>
      'Los permisos de ubicación fueron denegados.';

  @override
  String get homeErrorLocationDeniedForever =>
      'Los permisos de ubicación fueron denegados permanentemente.';

  @override
  String homeErrorGettingLocation(String error) {
    return 'Error al obtener la ubicación: $error';
  }

  @override
  String homeErrorLoadingStations(String error) {
    return 'Error al cargar las estaciones: $error';
  }

  @override
  String get homeNoStationsFoundAction => 'Actualizar';

  @override
  String stationDistanceAway(String distance) {
    return 'A $distance km';
  }

  @override
  String get stationClosedLabel => 'Cerrado';

  @override
  String get stationSelectButton => 'Seleccionar';

  @override
  String get fuelTypePetrol => 'Gasolina';

  @override
  String get fuelTypeDiesel => 'Diésel';

  @override
  String get fuelSelectFuelType => 'Seleccionar tipo de combustible';

  @override
  String get fuelEnterQuantity => 'Ingresar cantidad';

  @override
  String get fuelChoiceAmount => 'Monto (KES)';

  @override
  String get fuelChoiceLiters => 'Litros (L)';

  @override
  String get fuelInputAmountLabel => 'Monto (KES)';

  @override
  String get fuelInputLitersLabel => 'Litros (L)';

  @override
  String get fuelInputAmountHint => 'Ingresa el monto';

  @override
  String get fuelInputLitersHint => 'Ingresa los litros';

  @override
  String get fuelPricePerLiterLabel => 'Precio por litro:';

  @override
  String get fuelLitersLabel => 'Litros:';

  @override
  String get fuelAmountLabel => 'Monto:';

  @override
  String get fuelTotalLabel => 'Total:';

  @override
  String get fuelInProgressTitle => 'Suministro en progreso...';

  @override
  String get fuelStopButton => 'Detener suministro';

  @override
  String get fuelStartButton => 'Iniciar suministro';

  @override
  String get fuelErrorEnterAmountOrLiters => 'Por favor ingresa monto o litros';

  @override
  String fuelPumpStatus(String status) {
    return 'Bomba: $status';
  }

  @override
  String get pumpStatusIdle => 'Libre';

  @override
  String get pumpStatusBusy => 'Ocupada';

  @override
  String get pumpStatusInUse => 'En uso';

  @override
  String get paymentTitle => 'Pago';

  @override
  String get paymentSummaryTitle => 'Resumen de la transacción';

  @override
  String get paymentSummaryStation => 'Estación';

  @override
  String get paymentSummaryFuelType => 'Tipo de combustible';

  @override
  String get paymentSummaryQuantity => 'Cantidad';

  @override
  String get paymentSummaryPricePerLiter => 'Precio por litro';

  @override
  String get paymentSummaryTotalLabel => 'Monto total:';

  @override
  String get paymentMethodTitle => 'Seleccionar método de pago';

  @override
  String get paymentMethodMpesa => 'M-Pesa';

  @override
  String get paymentMethodCard => 'Tarjeta';

  @override
  String get paymentMethodCash => 'Efectivo';

  @override
  String get paymentButtonPayNow => 'Pagar ahora';

  @override
  String get paymentProcessing => 'Procesando...';

  @override
  String paymentError(String error) {
    return 'El pago falló: $error';
  }

  @override
  String get paymentSuccessAppBarTitle => 'Pago exitoso';

  @override
  String get paymentSuccessTitle => '¡Pago completado con éxito!';

  @override
  String get paymentSuccessButtonViewReceipt => 'Ver recibo';

  @override
  String get paymentSuccessButtonDone => 'Listo';

  @override
  String get paymentReceiptTitle => 'Recibo';

  @override
  String get paymentReceiptTransactionId => 'ID de transacción';

  @override
  String get paymentReceiptDate => 'Fecha';

  @override
  String get paymentReceiptFuelType => 'Tipo de combustible';

  @override
  String get paymentReceiptQuantity => 'Cantidad';

  @override
  String get paymentReceiptPricePerLiter => 'Precio por litro';

  @override
  String get paymentReceiptTotalAmount => 'Monto total';

  @override
  String get paymentReceiptPaymentMethod => 'Método de pago';

  @override
  String get paymentReceiptSuccessMessage => 'Pago exitoso';

  @override
  String get paymentReceiptSuccessTagline => 'Pago exitoso';

  @override
  String get paymentReceiptPrinted => 'Recibo impreso correctamente';

  @override
  String get mainPlaceholderFuelTitle => 'Combustible';

  @override
  String get mainPlaceholderFuelMessage =>
      'Selecciona una estación desde Inicio';

  @override
  String get mainPlaceholderPaymentTitle => 'Pago';

  @override
  String get mainPlaceholderPaymentMessage =>
      'Completa una sesión de suministro para continuar';

  @override
  String get dashboardTitle => 'Tablero';

  @override
  String get dashboardPeriodToday => 'Hoy';

  @override
  String get dashboardPeriodWeek => 'Esta semana';

  @override
  String get dashboardPeriodMonth => 'Este mes';

  @override
  String get dashboardStatTotalSales => 'Ventas totales';

  @override
  String get dashboardStatFuelDispensed => 'Combustible suministrado';

  @override
  String get dashboardStatReceipts => 'Recibos';

  @override
  String get dashboardStatTransactions => 'Transacciones';

  @override
  String get dashboardSalesPerformanceTitle => 'Desempeño de ventas';

  @override
  String get dashboardSalesPerformanceEmpty =>
      'No hay datos de ventas disponibles';

  @override
  String get dashboardRecentTransactionsTitle => 'Transacciones recientes';

  @override
  String get dashboardRecentTransactionsEmpty =>
      'No hay transacciones recientes';

  @override
  String get dashboardQuickActionsTitle => 'Acciones rápidas';

  @override
  String get dashboardQuickActionManageStations => 'Gestionar estaciones';

  @override
  String get dashboardQuickActionUpdatePrices => 'Actualizar precios';

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
  String get receiptPaymentSuccessfulBanner => 'Pago exitoso';

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
