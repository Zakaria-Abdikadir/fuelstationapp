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
  String get settingsProfileEditTitle => 'Editar perfil';

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
  String get receiptPaymentSuccessfulBanner => 'Pago exitoso';
}
