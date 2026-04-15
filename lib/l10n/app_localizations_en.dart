// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Car Coop';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navBookingsShort => 'Bookings';

  @override
  String get navTrips => 'Trips';

  @override
  String get navTripsShort => 'Trips';

  @override
  String get navExpenses => 'Expenses';

  @override
  String get navExpensesShort => 'Expenses';

  @override
  String get navPayments => 'Payments';

  @override
  String get navPaymentsShort => 'Payments';

  @override
  String get navMessages => 'Messages';

  @override
  String get navMessagesShort => 'Messages';

  @override
  String get navParking => 'Parking';

  @override
  String get navParkingShort => 'Parking';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign out';

  @override
  String get registerNewAccount => 'Register a new account';

  @override
  String get changeServerUrl => 'Change server URL';

  @override
  String get email => 'Email';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get invalidCredentials => 'Incorrect email or password.';

  @override
  String get setupSubtitle =>
      'Enter the URL of your Car Coop server to get started.';

  @override
  String get setupUrlRequired => 'Please enter a URL';

  @override
  String get setupUrlInvalid => 'URL must start with http or https';

  @override
  String get setupContinue => 'Continue';

  @override
  String get settings => 'Settings';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsServerUrl => 'Server URL';

  @override
  String get settingsSave => 'Save';

  @override
  String get settingsServerUrlUpdated => 'Server URL updated';

  @override
  String get settingsQuickActions => 'Show quick actions by default';

  @override
  String get settingsSwitchCar => 'Switch car';

  @override
  String get selectCar => 'Select a Car';

  @override
  String get noCarMember =>
      'You\'re not a member of any car sharing group yet.';

  @override
  String get goToWebsite => 'Go to car-coop.net';

  @override
  String get bookingsTitle => 'Bookings';

  @override
  String get noBookings => 'No bookings yet';

  @override
  String get newBooking => 'New Booking';

  @override
  String get editBooking => 'Edit Booking';

  @override
  String get bookingTitle => 'Title';

  @override
  String get bookingTitleOptional => 'Title (optional)';

  @override
  String get bookingDescription => 'Description (optional)';

  @override
  String get bookingStatus => 'Status';

  @override
  String get bookingStatusFixed => 'Fixed!';

  @override
  String get bookingStatusMaybe => 'Maybe?';

  @override
  String get bookingSelectStatus => 'Select a status';

  @override
  String get bookingStartDate => 'Start date';

  @override
  String get bookingEndDate => 'End date';

  @override
  String get bookingStartTime => 'Start time';

  @override
  String get bookingEndTime => 'End time';

  @override
  String get bookingSelectStartEnd => 'Please select start and end times';

  @override
  String get bookingSelectUser => 'Select a user';

  @override
  String get bookingsCalendar => 'Calendar';

  @override
  String get bookingsList => 'List';

  @override
  String get bookingCreate => 'Create';

  @override
  String get bookingUpdate => 'Update';

  @override
  String get deleteBooking => 'Delete Booking';

  @override
  String get deleteBookingConfirm => 'Delete this booking?';

  @override
  String get tripsTitle => 'Trips';

  @override
  String get noTrips => 'No trips yet';

  @override
  String get newTrip => 'New Trip';

  @override
  String get editTrip => 'Edit Trip';

  @override
  String get tripStartMileage => 'Start mileage';

  @override
  String get tripEndMileage => 'End mileage';

  @override
  String get tripEndMileageLocked => 'Cannot edit — later trips exist';

  @override
  String get tripStartTime => 'Start time';

  @override
  String get tripEndTime => 'End time (optional)';

  @override
  String get tripType => 'Type';

  @override
  String get tripTypeVacation => 'Vacation';

  @override
  String get tripTypeTransport => 'Transport';

  @override
  String get tripTypeService => 'Workshop/Service';

  @override
  String get tripComment => 'Comment (optional)';

  @override
  String get tripUsers => 'Users';

  @override
  String get tripDriver => 'Driver';

  @override
  String get tripMultipleDrivers => 'Multiple';

  @override
  String get tripDistance => 'Distance';

  @override
  String get tripCosts => 'Costs';

  @override
  String get tripStart => 'Start';

  @override
  String get tripEnd => 'End';

  @override
  String get tripSaved => 'Trip saved!';

  @override
  String get tripRecorded => 'Trip Recorded';

  @override
  String get tripBackToList => 'Back to Trips';

  @override
  String get scanMileage => 'Scan mileage from photo';

  @override
  String get scanNoMileage =>
      'No mileage value found in photo. Please try again.';

  @override
  String get deleteTrip => 'Delete Trip';

  @override
  String get deleteTripConfirm => 'Delete this trip?';

  @override
  String get expensesTitle => 'Expenses';

  @override
  String get noExpenses => 'No expenses yet';

  @override
  String get newExpense => 'New Expense';

  @override
  String get editExpense => 'Edit Expense';

  @override
  String get expenseName => 'Name';

  @override
  String get expenseNameRequired => 'Name is required';

  @override
  String get expenseAmount => 'Amount (€)';

  @override
  String get expenseTypeFuel => 'Fuel';

  @override
  String get expenseTypeCharging => 'Charging';

  @override
  String get expenseTypeService => 'Workshop/Service';

  @override
  String get expenseTypeOther => 'Other';

  @override
  String get deleteExpense => 'Delete Expense';

  @override
  String get deleteExpenseConfirm => 'Delete this expense?';

  @override
  String get paymentsTitle => 'Payments';

  @override
  String get noPayments => 'No payments yet';

  @override
  String get newPayment => 'New Payment';

  @override
  String get editPayment => 'Edit Payment';

  @override
  String get paymentType => 'Payment type';

  @override
  String get paymentTypeCash => 'Cash';

  @override
  String get paymentTypePaypal => 'PayPal';

  @override
  String get paymentTypeBankTransfer => 'Bank transfer';

  @override
  String get paymentTypeOther => 'Other';

  @override
  String get paymentFrom => 'From';

  @override
  String get paymentTo => 'To';

  @override
  String get paymentSelectPaidBy => 'Select who paid';

  @override
  String get paymentSelectRecipient => 'Select the recipient';

  @override
  String get paymentSenderReceiverMustDiffer =>
      'Sender and recipient must be different users';

  @override
  String get deletePayment => 'Delete Payment';

  @override
  String get deletePaymentConfirm => 'Delete this payment?';

  @override
  String get messagesTitle => 'Messages';

  @override
  String get noMessages => 'No messages yet';

  @override
  String get newMessage => 'New Message';

  @override
  String get messageContent => 'Message';

  @override
  String get messageWriteHint => 'Write a message...';

  @override
  String get messageContentRequired => 'Message content is required';

  @override
  String get messageMaxPhotos => 'Maximum 4 photos';

  @override
  String messageAddPhotoCount(int count) {
    return 'Add photo ($count/4)';
  }

  @override
  String get messagePost => 'Post';

  @override
  String get messageAddPhoto => 'Add photo';

  @override
  String get loadMore => 'Load more';

  @override
  String get parkingTitle => 'Parking';

  @override
  String get setParking => 'Set parking location';

  @override
  String get parkingSaved => 'Parking location saved!';

  @override
  String get navigateToVehicle => 'Navigate to vehicle';

  @override
  String get locationPermissionRequired =>
      'Location permission is required to set parking location';

  @override
  String get couldNotOpenNav => 'Could not open navigation app';

  @override
  String get quickActionsTitle => 'Quick Actions';

  @override
  String get findVehicle => 'Find vehicle';

  @override
  String get startTrip => 'Start trip';

  @override
  String get addExpense => 'Add expense';

  @override
  String get parkCar => 'Park car';

  @override
  String get finishTrip => 'Finish trip';

  @override
  String mileageCheck(int mileage) {
    return 'Is the odometer at $mileage?';
  }

  @override
  String get tempTripNotice =>
      'Oh, oh! Someone seems to have missed adding the last trip. We will now create a temporary trip so that the odometer and our logbook match. The group needs to find out why this mismatch exists.';

  @override
  String get haveNiceTrip => 'Have a nice trip!';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get date => 'Date';

  @override
  String get user => 'User';

  @override
  String get selectUser => 'Select a user';

  @override
  String get amountRequired => 'Amount is required';

  @override
  String get create => 'Create';

  @override
  String get update => 'Update';

  @override
  String get notSet => 'Not set';

  @override
  String get noCarSelected => 'No car selected';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get delete => 'Delete';

  @override
  String get confirm => 'Confirm';

  @override
  String get pleaseSelectStartTime => 'Please select a start time';

  @override
  String get pleaseSelectEndTime => 'Please select an end time';

  @override
  String get enterWholeNumber => 'Enter a whole number';

  @override
  String get enterValidNumber => 'Enter a valid number';

  @override
  String get tripSelectAtLeastOneUser => 'Select at least one user';

  @override
  String get tripEndMileageMustExceedStart =>
      'End mileage must be greater than start mileage';

  @override
  String get tripEndDateMustNotBeBeforeStart =>
      'End date must be on or after the start date';

  @override
  String get tripDatesCannotBeInFuture => 'Trip dates cannot be in the future';

  @override
  String tripStartDateMustNotBeBeforePreviousEnd(Object date) {
    return 'Start date cannot be before the previous trip ended on $date';
  }

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
