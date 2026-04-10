// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Car Coop';

  @override
  String get navBookings => 'Reservas';

  @override
  String get navTrips => 'Viajes';

  @override
  String get navExpenses => 'Gastos';

  @override
  String get navPayments => 'Pagos';

  @override
  String get navMessages => 'Mensajes';

  @override
  String get navParking => 'Parking';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get registerNewAccount => 'Registrar nueva cuenta';

  @override
  String get changeServerUrl => 'Cambiar URL del servidor';

  @override
  String get email => 'Correo electrónico';

  @override
  String get emailRequired => 'El correo electrónico es obligatorio';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordRequired => 'La contraseña es obligatoria';

  @override
  String get setupSubtitle =>
      'Introduzca la URL de su servidor Car Coop para comenzar.';

  @override
  String get setupUrlRequired => 'Por favor introduzca una URL';

  @override
  String get setupUrlInvalid => 'La URL debe comenzar con http o https';

  @override
  String get setupContinue => 'Continuar';

  @override
  String get settings => 'Ajustes';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Oscuro';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsServerUrl => 'URL del servidor';

  @override
  String get settingsSave => 'Guardar';

  @override
  String get settingsServerUrlUpdated => 'URL del servidor actualizada';

  @override
  String get settingsSwitchCar => 'Cambiar coche';

  @override
  String get selectCar => 'Seleccionar un coche';

  @override
  String get noCarMember =>
      'Aún no eres miembro de ningún grupo de coche compartido.';

  @override
  String get goToWebsite => 'Ir a car-coop.net';

  @override
  String get bookingsTitle => 'Reservas';

  @override
  String get noBookings => 'Aún no hay reservas';

  @override
  String get newBooking => 'Nueva reserva';

  @override
  String get editBooking => 'Editar reserva';

  @override
  String get bookingTitle => 'Título';

  @override
  String get bookingTitleOptional => 'Título (opcional)';

  @override
  String get bookingDescription => 'Descripción (opcional)';

  @override
  String get bookingStatus => 'Estado';

  @override
  String get bookingStatusFixed => '¡Fijo!';

  @override
  String get bookingStatusMaybe => '¿Quizás?';

  @override
  String get bookingSelectStatus => 'Seleccionar estado';

  @override
  String get bookingStartDate => 'Fecha de inicio';

  @override
  String get bookingEndDate => 'Fecha de fin';

  @override
  String get bookingStartTime => 'Hora de inicio';

  @override
  String get bookingEndTime => 'Hora de fin';

  @override
  String get bookingSelectStartEnd =>
      'Por favor selecciona las horas de inicio y fin';

  @override
  String get bookingSelectUser => 'Seleccionar usuario';

  @override
  String get bookingsCalendar => 'Calendario';

  @override
  String get bookingsList => 'Lista';

  @override
  String get bookingCreate => 'Crear';

  @override
  String get bookingUpdate => 'Actualizar';

  @override
  String get deleteBooking => 'Eliminar reserva';

  @override
  String get deleteBookingConfirm => '¿Eliminar esta reserva?';

  @override
  String get tripsTitle => 'Viajes';

  @override
  String get noTrips => 'Aún no hay viajes';

  @override
  String get newTrip => 'Nuevo viaje';

  @override
  String get editTrip => 'Editar viaje';

  @override
  String get tripStartMileage => 'Kilometraje inicial';

  @override
  String get tripEndMileage => 'Kilometraje final';

  @override
  String get tripEndMileageLocked => 'No editable — existen viajes posteriores';

  @override
  String get tripStartTime => 'Hora de inicio';

  @override
  String get tripEndTime => 'Hora de fin (opcional)';

  @override
  String get tripType => 'Tipo';

  @override
  String get tripTypeVacation => 'Vacaciones';

  @override
  String get tripTypeTransport => 'Transporte';

  @override
  String get tripTypeService => 'Taller/Servicio';

  @override
  String get tripComment => 'Comentario (opcional)';

  @override
  String get tripUsers => 'Usuarios';

  @override
  String get tripDriver => 'Conductor';

  @override
  String get tripMultipleDrivers => 'Varios';

  @override
  String get tripDistance => 'Distancia';

  @override
  String get tripCosts => 'Costes';

  @override
  String get tripStart => 'Inicio';

  @override
  String get tripEnd => 'Fin';

  @override
  String get tripSaved => '¡Viaje guardado!';

  @override
  String get tripRecorded => 'Viaje registrado';

  @override
  String get tripBackToList => 'Volver a viajes';

  @override
  String get scanMileage => 'Escanear kilometraje';

  @override
  String get scanNoMileage =>
      'No se encontró kilometraje en la foto. Inténtalo de nuevo.';

  @override
  String get deleteTrip => 'Eliminar viaje';

  @override
  String get deleteTripConfirm => '¿Eliminar este viaje?';

  @override
  String get expensesTitle => 'Gastos';

  @override
  String get noExpenses => 'Aún no hay gastos';

  @override
  String get newExpense => 'Nuevo gasto';

  @override
  String get editExpense => 'Editar gasto';

  @override
  String get expenseName => 'Nombre';

  @override
  String get expenseNameRequired => 'El nombre es obligatorio';

  @override
  String get expenseAmount => 'Importe (€)';

  @override
  String get deleteExpense => 'Eliminar gasto';

  @override
  String get deleteExpenseConfirm => '¿Eliminar este gasto?';

  @override
  String get paymentsTitle => 'Pagos';

  @override
  String get noPayments => 'Aún no hay pagos';

  @override
  String get newPayment => 'Nuevo pago';

  @override
  String get editPayment => 'Editar pago';

  @override
  String get paymentType => 'Tipo de pago';

  @override
  String get paymentFrom => 'De';

  @override
  String get paymentTo => 'A';

  @override
  String get paymentSelectPaidBy => '¿Quién pagó?';

  @override
  String get paymentSelectRecipient => 'Seleccionar destinatario';

  @override
  String get deletePayment => 'Eliminar pago';

  @override
  String get deletePaymentConfirm => '¿Eliminar este pago?';

  @override
  String get messagesTitle => 'Mensajes';

  @override
  String get noMessages => 'Aún no hay mensajes';

  @override
  String get newMessage => 'Nuevo mensaje';

  @override
  String get messageContent => 'Mensaje';

  @override
  String get messageWriteHint => 'Escribe un mensaje...';

  @override
  String get messageContentRequired =>
      'El contenido del mensaje es obligatorio';

  @override
  String get messageMaxPhotos => 'Máximo 4 fotos';

  @override
  String messageAddPhotoCount(int count) {
    return 'Añadir foto ($count/4)';
  }

  @override
  String get messagePost => 'Publicar';

  @override
  String get messageAddPhoto => 'Añadir foto';

  @override
  String get loadMore => 'Cargar más';

  @override
  String get parkingTitle => 'Aparcamiento';

  @override
  String get setParking => 'Establecer ubicación de aparcamiento';

  @override
  String get parkingSaved => '¡Ubicación de aparcamiento guardada!';

  @override
  String get navigateToVehicle => 'Navegar al vehículo';

  @override
  String get locationPermissionRequired => 'Se requiere permiso de ubicación';

  @override
  String get couldNotOpenNav => 'No se pudo abrir la aplicación de navegación';

  @override
  String get date => 'Fecha';

  @override
  String get user => 'Usuario';

  @override
  String get selectUser => 'Seleccionar usuario';

  @override
  String get amountRequired => 'El importe es obligatorio';

  @override
  String get create => 'Crear';

  @override
  String get update => 'Actualizar';

  @override
  String get notSet => 'No establecido';

  @override
  String get noCarSelected => 'Ningún coche seleccionado';

  @override
  String get retry => 'Reintentar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get pleaseSelectStartTime => 'Por favor selecciona una hora de inicio';

  @override
  String get enterWholeNumber => 'Introduce un número entero';

  @override
  String get enterValidNumber => 'Introduce un número válido';
}
