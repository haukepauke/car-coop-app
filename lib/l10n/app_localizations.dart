import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';

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
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('nl'),
    Locale('pl')
  ];

  /// App title
  ///
  /// In en, this message translates to:
  /// **'Car Coop'**
  String get appTitle;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navTrips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get navTrips;

  /// No description provided for @navExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get navExpenses;

  /// No description provided for @navPayments.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get navPayments;

  /// No description provided for @navMessages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get navMessages;

  /// No description provided for @navParking.
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get navParking;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @registerNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Register a new account'**
  String get registerNewAccount;

  /// No description provided for @changeServerUrl.
  ///
  /// In en, this message translates to:
  /// **'Change server URL'**
  String get changeServerUrl;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @setupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the URL of your Car Coop server to get started.'**
  String get setupSubtitle;

  /// No description provided for @setupUrlRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a URL'**
  String get setupUrlRequired;

  /// No description provided for @setupUrlInvalid.
  ///
  /// In en, this message translates to:
  /// **'URL must start with http or https'**
  String get setupUrlInvalid;

  /// No description provided for @setupContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get setupContinue;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsServerUrl.
  ///
  /// In en, this message translates to:
  /// **'Server URL'**
  String get settingsServerUrl;

  /// No description provided for @settingsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsSave;

  /// No description provided for @settingsServerUrlUpdated.
  ///
  /// In en, this message translates to:
  /// **'Server URL updated'**
  String get settingsServerUrlUpdated;

  /// No description provided for @settingsSwitchCar.
  ///
  /// In en, this message translates to:
  /// **'Switch car'**
  String get settingsSwitchCar;

  /// No description provided for @selectCar.
  ///
  /// In en, this message translates to:
  /// **'Select a Car'**
  String get selectCar;

  /// No description provided for @noCarMember.
  ///
  /// In en, this message translates to:
  /// **'You\'re not a member of any car sharing group yet.'**
  String get noCarMember;

  /// No description provided for @goToWebsite.
  ///
  /// In en, this message translates to:
  /// **'Go to car-coop.net'**
  String get goToWebsite;

  /// No description provided for @bookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookingsTitle;

  /// No description provided for @noBookings.
  ///
  /// In en, this message translates to:
  /// **'No bookings yet'**
  String get noBookings;

  /// No description provided for @newBooking.
  ///
  /// In en, this message translates to:
  /// **'New Booking'**
  String get newBooking;

  /// No description provided for @editBooking.
  ///
  /// In en, this message translates to:
  /// **'Edit Booking'**
  String get editBooking;

  /// No description provided for @bookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get bookingTitle;

  /// No description provided for @bookingTitleOptional.
  ///
  /// In en, this message translates to:
  /// **'Title (optional)'**
  String get bookingTitleOptional;

  /// No description provided for @bookingDescription.
  ///
  /// In en, this message translates to:
  /// **'Description (optional)'**
  String get bookingDescription;

  /// No description provided for @bookingStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get bookingStatus;

  /// No description provided for @bookingStatusFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed!'**
  String get bookingStatusFixed;

  /// No description provided for @bookingStatusMaybe.
  ///
  /// In en, this message translates to:
  /// **'Maybe?'**
  String get bookingStatusMaybe;

  /// No description provided for @bookingSelectStatus.
  ///
  /// In en, this message translates to:
  /// **'Select a status'**
  String get bookingSelectStatus;

  /// No description provided for @bookingStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get bookingStartDate;

  /// No description provided for @bookingEndDate.
  ///
  /// In en, this message translates to:
  /// **'End date'**
  String get bookingEndDate;

  /// No description provided for @bookingStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get bookingStartTime;

  /// No description provided for @bookingEndTime.
  ///
  /// In en, this message translates to:
  /// **'End time'**
  String get bookingEndTime;

  /// No description provided for @bookingSelectStartEnd.
  ///
  /// In en, this message translates to:
  /// **'Please select start and end times'**
  String get bookingSelectStartEnd;

  /// No description provided for @bookingSelectUser.
  ///
  /// In en, this message translates to:
  /// **'Select a user'**
  String get bookingSelectUser;

  /// No description provided for @bookingsCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get bookingsCalendar;

  /// No description provided for @bookingsList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get bookingsList;

  /// No description provided for @bookingCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get bookingCreate;

  /// No description provided for @bookingUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get bookingUpdate;

  /// No description provided for @deleteBooking.
  ///
  /// In en, this message translates to:
  /// **'Delete Booking'**
  String get deleteBooking;

  /// No description provided for @deleteBookingConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this booking?'**
  String get deleteBookingConfirm;

  /// No description provided for @tripsTitle.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get tripsTitle;

  /// No description provided for @noTrips.
  ///
  /// In en, this message translates to:
  /// **'No trips yet'**
  String get noTrips;

  /// No description provided for @newTrip.
  ///
  /// In en, this message translates to:
  /// **'New Trip'**
  String get newTrip;

  /// No description provided for @editTrip.
  ///
  /// In en, this message translates to:
  /// **'Edit Trip'**
  String get editTrip;

  /// No description provided for @tripStartMileage.
  ///
  /// In en, this message translates to:
  /// **'Start mileage'**
  String get tripStartMileage;

  /// No description provided for @tripEndMileage.
  ///
  /// In en, this message translates to:
  /// **'End mileage'**
  String get tripEndMileage;

  /// No description provided for @tripEndMileageLocked.
  ///
  /// In en, this message translates to:
  /// **'Cannot edit — later trips exist'**
  String get tripEndMileageLocked;

  /// No description provided for @tripStartTime.
  ///
  /// In en, this message translates to:
  /// **'Start time'**
  String get tripStartTime;

  /// No description provided for @tripEndTime.
  ///
  /// In en, this message translates to:
  /// **'End time (optional)'**
  String get tripEndTime;

  /// No description provided for @tripType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get tripType;

  /// No description provided for @tripTypeVacation.
  ///
  /// In en, this message translates to:
  /// **'Vacation'**
  String get tripTypeVacation;

  /// No description provided for @tripTypeTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get tripTypeTransport;

  /// No description provided for @tripTypeService.
  ///
  /// In en, this message translates to:
  /// **'Workshop/Service'**
  String get tripTypeService;

  /// No description provided for @tripComment.
  ///
  /// In en, this message translates to:
  /// **'Comment (optional)'**
  String get tripComment;

  /// No description provided for @tripUsers.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get tripUsers;

  /// No description provided for @tripDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get tripDriver;

  /// No description provided for @tripMultipleDrivers.
  ///
  /// In en, this message translates to:
  /// **'Multiple'**
  String get tripMultipleDrivers;

  /// No description provided for @tripDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get tripDistance;

  /// No description provided for @tripCosts.
  ///
  /// In en, this message translates to:
  /// **'Costs'**
  String get tripCosts;

  /// No description provided for @tripStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get tripStart;

  /// No description provided for @tripEnd.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get tripEnd;

  /// No description provided for @tripSaved.
  ///
  /// In en, this message translates to:
  /// **'Trip saved!'**
  String get tripSaved;

  /// No description provided for @tripRecorded.
  ///
  /// In en, this message translates to:
  /// **'Trip Recorded'**
  String get tripRecorded;

  /// No description provided for @tripBackToList.
  ///
  /// In en, this message translates to:
  /// **'Back to Trips'**
  String get tripBackToList;

  /// No description provided for @scanMileage.
  ///
  /// In en, this message translates to:
  /// **'Scan mileage from photo'**
  String get scanMileage;

  /// No description provided for @scanNoMileage.
  ///
  /// In en, this message translates to:
  /// **'No mileage value found in photo. Please try again.'**
  String get scanNoMileage;

  /// No description provided for @deleteTrip.
  ///
  /// In en, this message translates to:
  /// **'Delete Trip'**
  String get deleteTrip;

  /// No description provided for @deleteTripConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this trip?'**
  String get deleteTripConfirm;

  /// No description provided for @expensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesTitle;

  /// No description provided for @noExpenses.
  ///
  /// In en, this message translates to:
  /// **'No expenses yet'**
  String get noExpenses;

  /// No description provided for @newExpense.
  ///
  /// In en, this message translates to:
  /// **'New Expense'**
  String get newExpense;

  /// No description provided for @editExpense.
  ///
  /// In en, this message translates to:
  /// **'Edit Expense'**
  String get editExpense;

  /// No description provided for @expenseName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get expenseName;

  /// No description provided for @expenseNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get expenseNameRequired;

  /// No description provided for @expenseAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount (€)'**
  String get expenseAmount;

  /// No description provided for @deleteExpense.
  ///
  /// In en, this message translates to:
  /// **'Delete Expense'**
  String get deleteExpense;

  /// No description provided for @deleteExpenseConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this expense?'**
  String get deleteExpenseConfirm;

  /// No description provided for @paymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get paymentsTitle;

  /// No description provided for @noPayments.
  ///
  /// In en, this message translates to:
  /// **'No payments yet'**
  String get noPayments;

  /// No description provided for @newPayment.
  ///
  /// In en, this message translates to:
  /// **'New Payment'**
  String get newPayment;

  /// No description provided for @editPayment.
  ///
  /// In en, this message translates to:
  /// **'Edit Payment'**
  String get editPayment;

  /// No description provided for @paymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment type'**
  String get paymentType;

  /// No description provided for @paymentFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get paymentFrom;

  /// No description provided for @paymentTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get paymentTo;

  /// No description provided for @paymentSelectPaidBy.
  ///
  /// In en, this message translates to:
  /// **'Select who paid'**
  String get paymentSelectPaidBy;

  /// No description provided for @paymentSelectRecipient.
  ///
  /// In en, this message translates to:
  /// **'Select the recipient'**
  String get paymentSelectRecipient;

  /// No description provided for @deletePayment.
  ///
  /// In en, this message translates to:
  /// **'Delete Payment'**
  String get deletePayment;

  /// No description provided for @deletePaymentConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this payment?'**
  String get deletePaymentConfirm;

  /// No description provided for @messagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messagesTitle;

  /// No description provided for @noMessages.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessages;

  /// No description provided for @newMessage.
  ///
  /// In en, this message translates to:
  /// **'New Message'**
  String get newMessage;

  /// No description provided for @messageContent.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageContent;

  /// No description provided for @messageWriteHint.
  ///
  /// In en, this message translates to:
  /// **'Write a message...'**
  String get messageWriteHint;

  /// No description provided for @messageContentRequired.
  ///
  /// In en, this message translates to:
  /// **'Message content is required'**
  String get messageContentRequired;

  /// No description provided for @messageMaxPhotos.
  ///
  /// In en, this message translates to:
  /// **'Maximum 4 photos'**
  String get messageMaxPhotos;

  /// Button label for adding photos with current count
  ///
  /// In en, this message translates to:
  /// **'Add photo ({count}/4)'**
  String messageAddPhotoCount(int count);

  /// No description provided for @messagePost.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get messagePost;

  /// No description provided for @messageAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get messageAddPhoto;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;

  /// No description provided for @parkingTitle.
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get parkingTitle;

  /// No description provided for @setParking.
  ///
  /// In en, this message translates to:
  /// **'Set parking location'**
  String get setParking;

  /// No description provided for @parkingSaved.
  ///
  /// In en, this message translates to:
  /// **'Parking location saved!'**
  String get parkingSaved;

  /// No description provided for @navigateToVehicle.
  ///
  /// In en, this message translates to:
  /// **'Navigate to vehicle'**
  String get navigateToVehicle;

  /// No description provided for @locationPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Location permission is required to set parking location'**
  String get locationPermissionRequired;

  /// No description provided for @couldNotOpenNav.
  ///
  /// In en, this message translates to:
  /// **'Could not open navigation app'**
  String get couldNotOpenNav;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @selectUser.
  ///
  /// In en, this message translates to:
  /// **'Select a user'**
  String get selectUser;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Amount is required'**
  String get amountRequired;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @noCarSelected.
  ///
  /// In en, this message translates to:
  /// **'No car selected'**
  String get noCarSelected;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @pleaseSelectStartTime.
  ///
  /// In en, this message translates to:
  /// **'Please select a start time'**
  String get pleaseSelectStartTime;

  /// No description provided for @enterWholeNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number'**
  String get enterWholeNumber;

  /// No description provided for @enterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid number'**
  String get enterValidNumber;

  /// No description provided for @board_system_trip_added.
  ///
  /// In en, this message translates to:
  /// **'<strong>%user%</strong> added a new trip with <strong>%car%</strong>.'**
  String get board_system_trip_added;

  /// No description provided for @board_system_booking_added.
  ///
  /// In en, this message translates to:
  /// **'<strong>%user%</strong> added a new booking for <strong>%car%</strong> (<em>%start%</em> – <em>%end%</em>).'**
  String get board_system_booking_added;

  /// No description provided for @board_system_booking_updated.
  ///
  /// In en, this message translates to:
  /// **'<strong>%user%</strong> updated a booking for <strong>%car%</strong>.'**
  String get board_system_booking_updated;

  /// No description provided for @board_system_booking_deleted.
  ///
  /// In en, this message translates to:
  /// **'<strong>%user%</strong> deleted a booking for <strong>%car%</strong>: <em>%title%</em> (%start% – %end%).'**
  String get board_system_booking_deleted;

  /// No description provided for @board_system_payment_added.
  ///
  /// In en, this message translates to:
  /// **'<strong>%from%</strong> sent a payment to <strong>%to%</strong> for <strong>%car%</strong>.'**
  String get board_system_payment_added;

  /// No description provided for @board_system_invitation_created.
  ///
  /// In en, this message translates to:
  /// **'<strong>%user%</strong> invited <em>%email%</em> to join <strong>%car%</strong>.'**
  String get board_system_invitation_created;

  /// No description provided for @board_system_invitation_accepted.
  ///
  /// In en, this message translates to:
  /// **'<strong>%user%</strong> joined <strong>%car%</strong>.'**
  String get board_system_invitation_accepted;

  /// No description provided for @board_system_user_removed.
  ///
  /// In en, this message translates to:
  /// **'<strong>%user%</strong> left or was removed from <strong>%car%</strong>.'**
  String get board_system_user_removed;

  /// No description provided for @board_system_price_per_unit_changed.
  ///
  /// In en, this message translates to:
  /// **'The price per unit for group <strong>%group%</strong> in <strong>%car%</strong> has been changed from %old_price% € to <strong>%new_price% €</strong>.'**
  String get board_system_price_per_unit_changed;

  /// No description provided for @board_system_milestone_100k.
  ///
  /// In en, this message translates to:
  /// **'<strong>%car%</strong> just hit <strong>100,000 %unit%</strong>! The odometer has broken into six figures — a historic moment!'**
  String get board_system_milestone_100k;

  /// No description provided for @board_system_milestone_200k.
  ///
  /// In en, this message translates to:
  /// **'<strong>%car%</strong> rolls past <strong>200,000 %unit%</strong>! roughly five laps around the Earth\'s equator.'**
  String get board_system_milestone_200k;

  /// No description provided for @board_system_milestone_300k.
  ///
  /// In en, this message translates to:
  /// **'<strong>%car%</strong> reaches <strong>300,000 %unit%</strong>! You could have driven to the Moon and most of the way back.'**
  String get board_system_milestone_300k;

  /// No description provided for @board_system_milestone_400k.
  ///
  /// In en, this message translates to:
  /// **'<strong>%car%</strong> blazes past <strong>400,000 %unit%</strong>! That\'s the distance to the Moon — achieved on four wheels!'**
  String get board_system_milestone_400k;

  /// No description provided for @board_system_milestone_500k.
  ///
  /// In en, this message translates to:
  /// **'HALF A MILLION! <strong>%car%</strong> cruises past <strong>500,000 %unit%</strong>!'**
  String get board_system_milestone_500k;

  /// No description provided for @board_system_milestone_600k.
  ///
  /// In en, this message translates to:
  /// **'<strong>%car%</strong> powers through <strong>600,000 %unit%</strong>! That\'s fifteen laps of the Earth\'s equator.'**
  String get board_system_milestone_600k;

  /// No description provided for @board_system_milestone_700k.
  ///
  /// In en, this message translates to:
  /// **'<strong>%car%</strong> rockets past <strong>700,000 %unit%</strong>! You\'ve nearly covered the route from Earth to Venus.'**
  String get board_system_milestone_700k;

  /// No description provided for @board_system_milestone_800k.
  ///
  /// In en, this message translates to:
  /// **'<strong>%car%</strong> screams past <strong>800,000 %unit%</strong>! Only 200,000 to go to the magical million!'**
  String get board_system_milestone_800k;

  /// No description provided for @board_system_milestone_900k.
  ///
  /// In en, this message translates to:
  /// **'<strong>%car%</strong> thunders through <strong>900,000 %unit%</strong>! The penultimate milestone!'**
  String get board_system_milestone_900k;

  /// No description provided for @board_system_milestone_1000k.
  ///
  /// In en, this message translates to:
  /// **'ONE MILLION! <strong>%car%</strong> conquers the ultimate milestone: <strong>1,000,000 %unit%</strong>!'**
  String get board_system_milestone_1000k;

  /// No description provided for @board_system_milestone_repeating.
  ///
  /// In en, this message translates to:
  /// **'<strong>%car%</strong> just rolled past <strong>%milestone% %unit%</strong> — what a beautifully poetic number!'**
  String get board_system_milestone_repeating;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'nl',
        'pl'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
