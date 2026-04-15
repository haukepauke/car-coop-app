// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Car Coop';

  @override
  String get navBookings => 'Rezerwacje';

  @override
  String get navTrips => 'Przejazdy';

  @override
  String get navExpenses => 'Wydatki';

  @override
  String get navPayments => 'Płatności';

  @override
  String get navMessages => 'Wiadom.';

  @override
  String get navParking => 'Parking';

  @override
  String get signIn => 'Zaloguj się';

  @override
  String get signOut => 'Wyloguj się';

  @override
  String get registerNewAccount => 'Zarejestruj nowe konto';

  @override
  String get changeServerUrl => 'Zmień adres URL serwera';

  @override
  String get email => 'E-mail';

  @override
  String get emailRequired => 'E-mail jest wymagany';

  @override
  String get password => 'Hasło';

  @override
  String get passwordRequired => 'Hasło jest wymagane';

  @override
  String get setupSubtitle =>
      'Wprowadź adres URL swojego serwera Car Coop, aby rozpocząć.';

  @override
  String get setupUrlRequired => 'Proszę podać adres URL';

  @override
  String get setupUrlInvalid => 'Adres URL musi zaczynać się od http lub https';

  @override
  String get setupContinue => 'Kontynuuj';

  @override
  String get settings => 'Ustawienia';

  @override
  String get settingsTheme => 'Motyw';

  @override
  String get settingsThemeSystem => 'Systemowy';

  @override
  String get settingsThemeLight => 'Jasny';

  @override
  String get settingsThemeDark => 'Ciemny';

  @override
  String get settingsLanguage => 'Język';

  @override
  String get settingsServerUrl => 'Adres URL serwera';

  @override
  String get settingsSave => 'Zapisz';

  @override
  String get settingsServerUrlUpdated => 'Adres URL serwera zaktualizowany';

  @override
  String get settingsSwitchCar => 'Zmień samochód';

  @override
  String get selectCar => 'Wybierz samochód';

  @override
  String get noCarMember =>
      'Nie jesteś jeszcze członkiem żadnej grupy współdzielenia samochodu.';

  @override
  String get goToWebsite => 'Przejdź do car-coop.net';

  @override
  String get bookingsTitle => 'Rezerwacje';

  @override
  String get noBookings => 'Brak rezerwacji';

  @override
  String get newBooking => 'Nowa rezerwacja';

  @override
  String get editBooking => 'Edytuj rezerwację';

  @override
  String get bookingTitle => 'Tytuł';

  @override
  String get bookingTitleOptional => 'Tytuł (opcjonalnie)';

  @override
  String get bookingDescription => 'Opis (opcjonalnie)';

  @override
  String get bookingStatus => 'Status';

  @override
  String get bookingStatusFixed => 'Pewne!';

  @override
  String get bookingStatusMaybe => 'Może?';

  @override
  String get bookingSelectStatus => 'Wybierz status';

  @override
  String get bookingStartDate => 'Data początkowa';

  @override
  String get bookingEndDate => 'Data końcowa';

  @override
  String get bookingStartTime => 'Czas rozpoczęcia';

  @override
  String get bookingEndTime => 'Czas zakończenia';

  @override
  String get bookingSelectStartEnd => 'Wybierz czas rozpoczęcia i zakończenia';

  @override
  String get bookingSelectUser => 'Wybierz użytkownika';

  @override
  String get bookingsCalendar => 'Kalendarz';

  @override
  String get bookingsList => 'Lista';

  @override
  String get bookingCreate => 'Utwórz';

  @override
  String get bookingUpdate => 'Aktualizuj';

  @override
  String get deleteBooking => 'Usuń rezerwację';

  @override
  String get deleteBookingConfirm => 'Usunąć tę rezerwację?';

  @override
  String get tripsTitle => 'Przejazdy';

  @override
  String get noTrips => 'Brak przejazdów';

  @override
  String get newTrip => 'Nowy przejazd';

  @override
  String get editTrip => 'Edytuj przejazd';

  @override
  String get tripStartMileage => 'Przebieg początkowy';

  @override
  String get tripEndMileage => 'Przebieg końcowy';

  @override
  String get tripEndMileageLocked =>
      'Nie można edytować — istnieją późniejsze przejazdy';

  @override
  String get tripStartTime => 'Czas rozpoczęcia';

  @override
  String get tripEndTime => 'Czas zakończenia (opcjonalnie)';

  @override
  String get tripType => 'Typ';

  @override
  String get tripTypeVacation => 'Wakacje';

  @override
  String get tripTypeTransport => 'Transport';

  @override
  String get tripTypeService => 'Warsztat/Serwis';

  @override
  String get tripComment => 'Komentarz (opcjonalnie)';

  @override
  String get tripUsers => 'Użytkownicy';

  @override
  String get tripDriver => 'Kierowca';

  @override
  String get tripMultipleDrivers => 'Wielu';

  @override
  String get tripDistance => 'Dystans';

  @override
  String get tripCosts => 'Koszty';

  @override
  String get tripStart => 'Start';

  @override
  String get tripEnd => 'Koniec';

  @override
  String get tripSaved => 'Przejazd zapisany!';

  @override
  String get tripRecorded => 'Przejazd zapisany';

  @override
  String get tripBackToList => 'Powrót do przejazdów';

  @override
  String get scanMileage => 'Skanuj przebieg ze zdjęcia';

  @override
  String get scanNoMileage =>
      'Nie znaleziono przebiegu na zdjęciu. Spróbuj ponownie.';

  @override
  String get deleteTrip => 'Usuń przejazd';

  @override
  String get deleteTripConfirm => 'Usunąć ten przejazd?';

  @override
  String get expensesTitle => 'Wydatki';

  @override
  String get noExpenses => 'Brak wydatków';

  @override
  String get newExpense => 'Nowy wydatek';

  @override
  String get editExpense => 'Edytuj wydatek';

  @override
  String get expenseName => 'Nazwa';

  @override
  String get expenseNameRequired => 'Nazwa jest wymagana';

  @override
  String get expenseAmount => 'Kwota (€)';

  @override
  String get deleteExpense => 'Usuń wydatek';

  @override
  String get deleteExpenseConfirm => 'Usunąć ten wydatek?';

  @override
  String get paymentsTitle => 'Płatności';

  @override
  String get noPayments => 'Brak płatności';

  @override
  String get newPayment => 'Nowa płatność';

  @override
  String get editPayment => 'Edytuj płatność';

  @override
  String get paymentType => 'Typ płatności';

  @override
  String get paymentFrom => 'Od';

  @override
  String get paymentTo => 'Do';

  @override
  String get paymentSelectPaidBy => 'Kto zapłacił?';

  @override
  String get paymentSelectRecipient => 'Wybierz odbiorcę';

  @override
  String get deletePayment => 'Usuń płatność';

  @override
  String get deletePaymentConfirm => 'Usunąć tę płatność?';

  @override
  String get messagesTitle => 'Wiadomości';

  @override
  String get noMessages => 'Brak wiadomości';

  @override
  String get newMessage => 'Nowa wiadomość';

  @override
  String get messageContent => 'Wiadomość';

  @override
  String get messageWriteHint => 'Napisz wiadomość...';

  @override
  String get messageContentRequired => 'Treść wiadomości jest wymagana';

  @override
  String get messageMaxPhotos => 'Maksymalnie 4 zdjęcia';

  @override
  String messageAddPhotoCount(int count) {
    return 'Dodaj zdjęcie ($count/4)';
  }

  @override
  String get messagePost => 'Wyślij';

  @override
  String get messageAddPhoto => 'Dodaj zdjęcie';

  @override
  String get loadMore => 'Załaduj więcej';

  @override
  String get parkingTitle => 'Parking';

  @override
  String get setParking => 'Ustaw lokalizację parkowania';

  @override
  String get parkingSaved => 'Lokalizacja parkowania zapisana!';

  @override
  String get navigateToVehicle => 'Nawiguj do pojazdu';

  @override
  String get locationPermissionRequired => 'Wymagane pozwolenie na lokalizację';

  @override
  String get couldNotOpenNav => 'Nie można otworzyć aplikacji nawigacyjnej';

  @override
  String get date => 'Data';

  @override
  String get user => 'Użytkownik';

  @override
  String get selectUser => 'Wybierz użytkownika';

  @override
  String get amountRequired => 'Kwota jest wymagana';

  @override
  String get create => 'Utwórz';

  @override
  String get update => 'Aktualizuj';

  @override
  String get notSet => 'Nie ustawiono';

  @override
  String get noCarSelected => 'Nie wybrano samochodu';

  @override
  String get retry => 'Ponów';

  @override
  String get cancel => 'Anuluj';

  @override
  String get delete => 'Usuń';

  @override
  String get confirm => 'Potwierdź';

  @override
  String get pleaseSelectStartTime => 'Wybierz czas rozpoczęcia';

  @override
  String get enterWholeNumber => 'Wprowadź liczbę całkowitą';

  @override
  String get enterValidNumber => 'Wprowadź prawidłową liczbę';

  @override
  String get board_system_trip_added =>
      '<strong>%user%</strong> added a new trip with <strong>%car%</strong>.';

  @override
  String get board_system_booking_added =>
      '<strong>%user%</strong> added a new booking for <strong>%car%</strong> (<em>%start%</em> – <em>%end%</em>).';

  @override
  String get board_system_booking_updated =>
      '<strong>%user%</strong> updated a booking for <strong>%car%</strong>.';

  @override
  String get board_system_booking_deleted =>
      '<strong>%user%</strong> deleted a booking for <strong>%car%</strong>: <em>%title%</em> (%start% – %end%).';

  @override
  String get board_system_payment_added =>
      '<strong>%from%</strong> sent a payment to <strong>%to%</strong> for <strong>%car%</strong>.';

  @override
  String get board_system_invitation_created =>
      '<strong>%user%</strong> invited <em>%email%</em> to join <strong>%car%</strong>.';

  @override
  String get board_system_invitation_accepted =>
      '<strong>%user%</strong> joined <strong>%car%</strong>.';

  @override
  String get board_system_user_removed =>
      '<strong>%user%</strong> left or was removed from <strong>%car%</strong>.';

  @override
  String get board_system_price_per_unit_changed =>
      'The price per unit for group <strong>%group%</strong> in <strong>%car%</strong> has been changed from %old_price% € to <strong>%new_price% €</strong>.';

  @override
  String get board_system_milestone_100k =>
      '<strong>%car%</strong> just hit <strong>100,000 %unit%</strong>! The odometer has broken into six figures — a historic moment!';

  @override
  String get board_system_milestone_200k =>
      '<strong>%car%</strong> rolls past <strong>200,000 %unit%</strong>! roughly five laps around the Earth\'s equator.';

  @override
  String get board_system_milestone_300k =>
      '<strong>%car%</strong> reaches <strong>300,000 %unit%</strong>! You could have driven to the Moon and most of the way back.';

  @override
  String get board_system_milestone_400k =>
      '<strong>%car%</strong> blazes past <strong>400,000 %unit%</strong>! That\'s the distance to the Moon — achieved on four wheels!';

  @override
  String get board_system_milestone_500k =>
      'HALF A MILLION! <strong>%car%</strong> cruises past <strong>500,000 %unit%</strong>!';

  @override
  String get board_system_milestone_600k =>
      '<strong>%car%</strong> powers through <strong>600,000 %unit%</strong>! That\'s fifteen laps of the Earth\'s equator.';

  @override
  String get board_system_milestone_700k =>
      '<strong>%car%</strong> rockets past <strong>700,000 %unit%</strong>! You\'ve nearly covered the route from Earth to Venus.';

  @override
  String get board_system_milestone_800k =>
      '<strong>%car%</strong> screams past <strong>800,000 %unit%</strong>! Only 200,000 to go to the magical million!';

  @override
  String get board_system_milestone_900k =>
      '<strong>%car%</strong> thunders through <strong>900,000 %unit%</strong>! The penultimate milestone!';

  @override
  String get board_system_milestone_1000k =>
      'ONE MILLION! <strong>%car%</strong> conquers the ultimate milestone: <strong>1,000,000 %unit%</strong>!';

  @override
  String get board_system_milestone_repeating =>
      '<strong>%car%</strong> just rolled past <strong>%milestone% %unit%</strong> — what a beautifully poetic number!';
}
