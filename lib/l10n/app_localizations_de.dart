// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Car Coop';

  @override
  String get navBookings => 'Buchungen';

  @override
  String get navBookingsShort => 'Buchen';

  @override
  String get navTrips => 'Fahrten';

  @override
  String get navTripsShort => 'Fahrten';

  @override
  String get navExpenses => 'Ausgaben';

  @override
  String get navExpensesShort => 'Ausgaben';

  @override
  String get navPayments => 'Zahlungen';

  @override
  String get navPaymentsShort => 'Zahlen';

  @override
  String get navMessages => 'Beiträge';

  @override
  String get navMessagesShort => 'Beiträge';

  @override
  String get navParking => 'Parken';

  @override
  String get navParkingShort => 'Parken';

  @override
  String get signIn => 'Anmelden';

  @override
  String get signOut => 'Abmelden';

  @override
  String get registerNewAccount => 'Neues Konto registrieren';

  @override
  String get changeServerUrl => 'Server-URL ändern';

  @override
  String get email => 'E-Mail';

  @override
  String get emailRequired => 'E-Mail ist erforderlich';

  @override
  String get password => 'Passwort';

  @override
  String get passwordRequired => 'Passwort ist erforderlich';

  @override
  String get invalidCredentials => 'E-Mail oder Passwort ist nicht korrekt.';

  @override
  String get setupSubtitle =>
      'Geben Sie die URL Ihres Car Coop Servers ein, um zu beginnen.';

  @override
  String get setupUrlRequired => 'Bitte eine URL eingeben';

  @override
  String get setupUrlInvalid => 'URL muss mit http oder https beginnen';

  @override
  String get setupContinue => 'Weiter';

  @override
  String get settings => 'Einstellungen';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsServerUrl => 'Server-URL';

  @override
  String get settingsSave => 'Speichern';

  @override
  String get settingsServerUrlUpdated => 'Server-URL aktualisiert';

  @override
  String get settingsQuickActions => 'Schnellaktionen standardmäßig anzeigen';

  @override
  String get settingsSwitchCar => 'Auto wechseln';

  @override
  String get selectCar => 'Auto auswählen';

  @override
  String get noCarMember =>
      'Du bist noch kein Mitglied einer Fahrgemeinschaft.';

  @override
  String get goToWebsite => 'Zu car-coop.net';

  @override
  String get bookingsTitle => 'Buchungen';

  @override
  String get noBookings => 'Noch keine Buchungen';

  @override
  String get newBooking => 'Neue Buchung';

  @override
  String get editBooking => 'Buchung bearbeiten';

  @override
  String get bookingTitle => 'Titel';

  @override
  String get bookingTitleOptional => 'Titel (optional)';

  @override
  String get bookingDescription => 'Beschreibung (optional)';

  @override
  String get bookingStatus => 'Status';

  @override
  String get bookingStatusFixed => 'Fest!';

  @override
  String get bookingStatusMaybe => 'Vielleicht?';

  @override
  String get bookingSelectStatus => 'Status auswählen';

  @override
  String get bookingStartDate => 'Startdatum';

  @override
  String get bookingEndDate => 'Enddatum';

  @override
  String get bookingStartTime => 'Startzeit';

  @override
  String get bookingEndTime => 'Endzeit';

  @override
  String get bookingSelectStartEnd => 'Bitte Start- und Endzeit auswählen';

  @override
  String get bookingSelectUser => 'Benutzer auswählen';

  @override
  String get bookingsCalendar => 'Kalender';

  @override
  String get bookingsList => 'Liste';

  @override
  String get bookingCreate => 'Erstellen';

  @override
  String get bookingUpdate => 'Aktualisieren';

  @override
  String get deleteBooking => 'Buchung löschen';

  @override
  String get deleteBookingConfirm => 'Diese Buchung löschen?';

  @override
  String get tripsTitle => 'Fahrten';

  @override
  String get noTrips => 'Noch keine Fahrten';

  @override
  String get newTrip => 'Neue Fahrt';

  @override
  String get editTrip => 'Fahrt bearbeiten';

  @override
  String get tripStartMileage => 'Startkilometerstand';

  @override
  String get tripEndMileage => 'Endkilometerstand';

  @override
  String get tripEndMileageLocked =>
      'Nicht bearbeitbar — spätere Fahrten vorhanden';

  @override
  String get tripStartTime => 'Startzeit';

  @override
  String get tripEndTime => 'Endzeit (optional)';

  @override
  String get tripType => 'Typ';

  @override
  String get tripTypeVacation => 'Urlaub';

  @override
  String get tripTypeTransport => 'Transport';

  @override
  String get tripTypeService => 'Werkstatt/Service';

  @override
  String get tripComment => 'Kommentar (optional)';

  @override
  String get tripUsers => 'Fahrer';

  @override
  String get tripDriver => 'Fahrer';

  @override
  String get tripMultipleDrivers => 'Mehrere';

  @override
  String get tripDistance => 'Distanz';

  @override
  String get tripCosts => 'Kosten';

  @override
  String get tripStart => 'Start';

  @override
  String get tripEnd => 'Ende';

  @override
  String get tripSaved => 'Fahrt gespeichert!';

  @override
  String get tripRecorded => 'Fahrt aufgezeichnet';

  @override
  String get tripBackToList => 'Zurück zu Fahrten';

  @override
  String get scanMileage => 'Kilometerstand fotografieren';

  @override
  String get scanNoMileage =>
      'Kein Kilometerstand im Foto gefunden. Bitte erneut versuchen.';

  @override
  String get deleteTrip => 'Fahrt löschen';

  @override
  String get deleteTripConfirm => 'Diese Fahrt löschen?';

  @override
  String get expensesTitle => 'Ausgaben';

  @override
  String get noExpenses => 'Noch keine Ausgaben';

  @override
  String get newExpense => 'Neue Ausgabe';

  @override
  String get editExpense => 'Ausgabe bearbeiten';

  @override
  String get expenseName => 'Name';

  @override
  String get expenseNameRequired => 'Name ist erforderlich';

  @override
  String get expenseAmount => 'Betrag (€)';

  @override
  String get deleteExpense => 'Ausgabe löschen';

  @override
  String get deleteExpenseConfirm => 'Diese Ausgabe löschen?';

  @override
  String get paymentsTitle => 'Zahlungen';

  @override
  String get noPayments => 'Noch keine Zahlungen';

  @override
  String get newPayment => 'Neue Zahlung';

  @override
  String get editPayment => 'Zahlung bearbeiten';

  @override
  String get paymentType => 'Zahlungsart';

  @override
  String get paymentFrom => 'Von';

  @override
  String get paymentTo => 'An';

  @override
  String get paymentSelectPaidBy => 'Wer hat bezahlt?';

  @override
  String get paymentSelectRecipient => 'Empfänger auswählen';

  @override
  String get deletePayment => 'Zahlung löschen';

  @override
  String get deletePaymentConfirm => 'Diese Zahlung löschen?';

  @override
  String get messagesTitle => 'Nachrichten';

  @override
  String get noMessages => 'Noch keine Nachrichten';

  @override
  String get newMessage => 'Neue Nachricht';

  @override
  String get messageContent => 'Nachricht';

  @override
  String get messageWriteHint => 'Nachricht schreiben...';

  @override
  String get messageContentRequired => 'Nachrichteninhalt ist erforderlich';

  @override
  String get messageMaxPhotos => 'Maximal 4 Fotos';

  @override
  String messageAddPhotoCount(int count) {
    return 'Foto hinzufügen ($count/4)';
  }

  @override
  String get messagePost => 'Senden';

  @override
  String get messageAddPhoto => 'Foto hinzufügen';

  @override
  String get loadMore => 'Mehr laden';

  @override
  String get parkingTitle => 'Parken';

  @override
  String get setParking => 'Parkposition setzen';

  @override
  String get parkingSaved => 'Parkposition gespeichert!';

  @override
  String get navigateToVehicle => 'Zum Fahrzeug navigieren';

  @override
  String get locationPermissionRequired => 'Standortberechtigung erforderlich';

  @override
  String get couldNotOpenNav => 'Navigations-App konnte nicht geöffnet werden';

  @override
  String get quickActionsTitle => 'Schnellaktionen';

  @override
  String get findVehicle => 'Fahrzeug finden';

  @override
  String get startTrip => 'Fahrt starten';

  @override
  String get addExpense => 'Ausgabe hinzufügen';

  @override
  String get parkCar => 'Auto parken';

  @override
  String get finishTrip => 'Fahrt beenden';

  @override
  String mileageCheck(int mileage) {
    return 'Ist der Kilometerstand bei $mileage?';
  }

  @override
  String get tempTripNotice =>
      'Oh, oh! Jemand hat offenbar vergessen, die letzte Fahrt einzutragen. Wir erstellen jetzt eine temporäre Fahrt, damit Kilometerstand und Fahrtenbuch wieder zusammenpassen. Die Gruppe muss herausfinden, warum diese Abweichung entstanden ist.';

  @override
  String get haveNiceTrip => 'Gute Fahrt!';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get date => 'Datum';

  @override
  String get user => 'Benutzer';

  @override
  String get selectUser => 'Benutzer auswählen';

  @override
  String get amountRequired => 'Betrag ist erforderlich';

  @override
  String get create => 'Erstellen';

  @override
  String get update => 'Aktualisieren';

  @override
  String get notSet => 'Nicht festgelegt';

  @override
  String get noCarSelected => 'Kein Auto ausgewählt';

  @override
  String get retry => 'Wiederholen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get ok => 'OK';

  @override
  String get delete => 'Löschen';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get pleaseSelectStartTime => 'Bitte Startzeit auswählen';

  @override
  String get enterWholeNumber => 'Ganze Zahl eingeben';

  @override
  String get enterValidNumber => 'Gültige Zahl eingeben';

  @override
  String get board_system_trip_added =>
      '<strong>%user%</strong> hat eine neue Fahrt mit <strong>%car%</strong> hinzugefügt.';

  @override
  String get board_system_booking_added =>
      '<strong>%user%</strong> hat eine neue Buchung für <strong>%car%</strong> erstellt (<em>%start%</em> – <em>%end%</em>).';

  @override
  String get board_system_booking_updated =>
      '<strong>%user%</strong> hat eine Buchung für <strong>%car%</strong> aktualisiert.';

  @override
  String get board_system_booking_deleted =>
      '<strong>%user%</strong> hat eine Buchung für <strong>%car%</strong> gelöscht: <em>%title%</em> (%start% – %end%).';

  @override
  String get board_system_payment_added =>
      '<strong>%from%</strong> hat eine Zahlung an <strong>%to%</strong> für <strong>%car%</strong> gesendet.';

  @override
  String get board_system_invitation_created =>
      '<strong>%user%</strong> hat <em>%email%</em> eingeladen, <strong>%car%</strong> beizutreten.';

  @override
  String get board_system_invitation_accepted =>
      '<strong>%user%</strong> ist <strong>%car%</strong> beigetreten.';

  @override
  String get board_system_user_removed =>
      '<strong>%user%</strong> hat <strong>%car%</strong> verlassen oder wurde entfernt.';

  @override
  String get board_system_price_per_unit_changed =>
      'Der Preis pro Einheit für die Gruppe <strong>%group%</strong> in <strong>%car%</strong> wurde von %old_price% € auf <strong>%new_price% €</strong> geändert.';

  @override
  String get board_system_milestone_100k =>
      '<strong>%car%</strong> hat gerade die <strong>100.000 %unit%</strong> erreicht! Der Kilometerzähler ist sechsstellig geworden — ein historischer Moment!';

  @override
  String get board_system_milestone_200k =>
      '<strong>%car%</strong> rollt an <strong>200.000 %unit%</strong> vorbei! Etwa fünf Runden um den Äquator.';

  @override
  String get board_system_milestone_300k =>
      '<strong>%car%</strong> erreicht <strong>300.000 %unit%</strong>! Du hättest zum Mond und fast den ganzen Weg zurück fahren können.';

  @override
  String get board_system_milestone_400k =>
      '<strong>%car%</strong> jagt an <strong>400.000 %unit%</strong> vorbei! Das ist die Entfernung zum Mond — auf vier Rädern geschafft!';

  @override
  String get board_system_milestone_500k =>
      'EINE HALBE MILLION! <strong>%car%</strong> fährt an <strong>500.000 %unit%</strong> vorbei!';

  @override
  String get board_system_milestone_600k =>
      '<strong>%car%</strong> knackt die <strong>600.000 %unit%</strong>! Das sind fünfzehn Runden um den Äquator.';

  @override
  String get board_system_milestone_700k =>
      '<strong>%car%</strong> schießt an <strong>700.000 %unit%</strong> vorbei! Das ist fast die Strecke von der Erde bis zur Venus.';

  @override
  String get board_system_milestone_800k =>
      '<strong>%car%</strong> rast an <strong>800.000 %unit%</strong> vorbei! Nur noch 200.000 bis zur magischen Million!';

  @override
  String get board_system_milestone_900k =>
      '<strong>%car%</strong> donnert durch die <strong>900.000 %unit%</strong>! Der vorletzte Meilenstein!';

  @override
  String get board_system_milestone_1000k =>
      'EINE MILLION! <strong>%car%</strong> erobert den ultimativen Meilenstein: <strong>1.000.000 %unit%</strong>!';

  @override
  String get board_system_milestone_repeating =>
      '<strong>%car%</strong> ist gerade an <strong>%milestone% %unit%</strong> vorbeigerollt — was für eine schöne Zahl!';
}
