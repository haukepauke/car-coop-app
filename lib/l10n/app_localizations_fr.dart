// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Car Coop';

  @override
  String get navBookings => 'Agenda';

  @override
  String get navBookingsShort => 'Agenda';

  @override
  String get navTrips => 'Trajets';

  @override
  String get navTripsShort => 'Trajets';

  @override
  String get navExpenses => 'Dépenses';

  @override
  String get navExpensesShort => 'Dépenses';

  @override
  String get navPayments => 'Paiements';

  @override
  String get navPaymentsShort => 'Payer';

  @override
  String get navMessages => 'Messages';

  @override
  String get navMessagesShort => 'Messages';

  @override
  String get navParking => 'Parking';

  @override
  String get navParkingShort => 'Parking';

  @override
  String get signIn => 'Se connecter';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get registerNewAccount => 'Créer un nouveau compte';

  @override
  String get changeServerUrl => 'Modifier l\'URL du serveur';

  @override
  String get email => 'E-mail';

  @override
  String get emailRequired => 'L\'e-mail est requis';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordRequired => 'Le mot de passe est requis';

  @override
  String get invalidCredentials => 'E-mail ou mot de passe incorrect.';

  @override
  String get setupSubtitle =>
      'Entrez l\'URL de votre serveur Car Coop pour commencer.';

  @override
  String get setupUrlRequired => 'Veuillez entrer une URL';

  @override
  String get setupUrlInvalid => 'L\'URL doit commencer par http ou https';

  @override
  String get setupContinue => 'Continuer';

  @override
  String get settings => 'Paramètres';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsThemeSystem => 'Système';

  @override
  String get settingsThemeLight => 'Clair';

  @override
  String get settingsThemeDark => 'Sombre';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsServerUrl => 'URL du serveur';

  @override
  String get settingsSave => 'Enregistrer';

  @override
  String get settingsServerUrlUpdated => 'URL du serveur mise à jour';

  @override
  String get settingsQuickActions => 'Afficher les actions rapides par défaut';

  @override
  String get settingsSwitchCar => 'Changer de voiture';

  @override
  String get selectCar => 'Sélectionner une voiture';

  @override
  String get noCarMember =>
      'Vous n\'êtes pas encore membre d\'un groupe de covoiturage.';

  @override
  String get goToWebsite => 'Aller sur car-coop.net';

  @override
  String get bookingsTitle => 'Réservations';

  @override
  String get noBookings => 'Pas encore de réservations';

  @override
  String get newBooking => 'Nouvelle réservation';

  @override
  String get editBooking => 'Modifier la réservation';

  @override
  String get bookingTitle => 'Titre';

  @override
  String get bookingTitleOptional => 'Titre (optionnel)';

  @override
  String get bookingDescription => 'Description (optionnel)';

  @override
  String get bookingStatus => 'Statut';

  @override
  String get bookingStatusFixed => 'Confirmé !';

  @override
  String get bookingStatusMaybe => 'Peut-être ?';

  @override
  String get bookingSelectStatus => 'Sélectionner un statut';

  @override
  String get bookingStartDate => 'Date de début';

  @override
  String get bookingEndDate => 'Date de fin';

  @override
  String get bookingStartTime => 'Heure de début';

  @override
  String get bookingEndTime => 'Heure de fin';

  @override
  String get bookingSelectStartEnd =>
      'Veuillez sélectionner les heures de début et de fin';

  @override
  String get bookingSelectUser => 'Sélectionner un utilisateur';

  @override
  String get bookingsCalendar => 'Calendrier';

  @override
  String get bookingsList => 'Liste';

  @override
  String get bookingCreate => 'Créer';

  @override
  String get bookingUpdate => 'Mettre à jour';

  @override
  String get deleteBooking => 'Supprimer la réservation';

  @override
  String get deleteBookingConfirm => 'Supprimer cette réservation ?';

  @override
  String get tripsTitle => 'Trajets';

  @override
  String get noTrips => 'Pas encore de trajets';

  @override
  String get newTrip => 'Nouveau trajet';

  @override
  String get editTrip => 'Modifier le trajet';

  @override
  String get tripStartMileage => 'Kilométrage de départ';

  @override
  String get tripEndMileage => 'Kilométrage d\'arrivée';

  @override
  String get tripEndMileageLocked =>
      'Non modifiable — trajets ultérieurs existants';

  @override
  String get tripStartTime => 'Heure de départ';

  @override
  String get tripEndTime => 'Heure d\'arrivée (optionnel)';

  @override
  String get tripType => 'Type';

  @override
  String get tripTypeVacation => 'Vacances';

  @override
  String get tripTypeTransport => 'Transport';

  @override
  String get tripTypeService => 'Atelier/Service';

  @override
  String get tripComment => 'Commentaire (optionnel)';

  @override
  String get tripUsers => 'Utilisateurs';

  @override
  String get tripDriver => 'Conducteur';

  @override
  String get tripMultipleDrivers => 'Plusieurs';

  @override
  String get tripDistance => 'Distance';

  @override
  String get tripCosts => 'Coûts';

  @override
  String get tripStart => 'Départ';

  @override
  String get tripEnd => 'Arrivée';

  @override
  String get tripSaved => 'Trajet enregistré !';

  @override
  String get tripRecorded => 'Trajet enregistré';

  @override
  String get tripBackToList => 'Retour aux trajets';

  @override
  String get scanMileage => 'Scanner le kilométrage';

  @override
  String get scanNoMileage =>
      'Aucun kilométrage trouvé dans la photo. Veuillez réessayer.';

  @override
  String get deleteTrip => 'Supprimer le trajet';

  @override
  String get deleteTripConfirm => 'Supprimer ce trajet ?';

  @override
  String get expensesTitle => 'Dépenses';

  @override
  String get noExpenses => 'Pas encore de dépenses';

  @override
  String get newExpense => 'Nouvelle dépense';

  @override
  String get editExpense => 'Modifier la dépense';

  @override
  String get expenseName => 'Nom';

  @override
  String get expenseNameRequired => 'Le nom est requis';

  @override
  String get expenseAmount => 'Montant (€)';

  @override
  String get expenseTypeFuel => 'Carburant';

  @override
  String get expenseTypeCharging => 'Recharge';

  @override
  String get expenseTypeService => 'Atelier/Service';

  @override
  String get expenseTypeOther => 'Autre';

  @override
  String get deleteExpense => 'Supprimer la dépense';

  @override
  String get deleteExpenseConfirm => 'Supprimer cette dépense ?';

  @override
  String get paymentsTitle => 'Paiements';

  @override
  String get noPayments => 'Pas encore de paiements';

  @override
  String get newPayment => 'Nouveau paiement';

  @override
  String get editPayment => 'Modifier le paiement';

  @override
  String get paymentType => 'Type de paiement';

  @override
  String get paymentTypeCash => 'Espèces';

  @override
  String get paymentTypePaypal => 'PayPal';

  @override
  String get paymentTypeBankTransfer => 'Virement bancaire';

  @override
  String get paymentTypeOther => 'Autre';

  @override
  String get paymentFrom => 'De';

  @override
  String get paymentTo => 'À';

  @override
  String get paymentSelectPaidBy => 'Qui a payé ?';

  @override
  String get paymentSelectRecipient => 'Sélectionner le destinataire';

  @override
  String get paymentSenderReceiverMustDiffer =>
      'L\'expéditeur et le destinataire doivent être des utilisateurs différents';

  @override
  String get deletePayment => 'Supprimer le paiement';

  @override
  String get deletePaymentConfirm => 'Supprimer ce paiement ?';

  @override
  String get messagesTitle => 'Messages';

  @override
  String get noMessages => 'Pas encore de messages';

  @override
  String get newMessage => 'Nouveau message';

  @override
  String get messageContent => 'Message';

  @override
  String get messageWriteHint => 'Écrire un message...';

  @override
  String get messageContentRequired => 'Le contenu du message est requis';

  @override
  String get messageMaxPhotos => 'Maximum 4 photos';

  @override
  String messageAddPhotoCount(int count) {
    return 'Ajouter photo ($count/4)';
  }

  @override
  String get messagePost => 'Publier';

  @override
  String get messageAddPhoto => 'Ajouter une photo';

  @override
  String get loadMore => 'Charger plus';

  @override
  String get parkingTitle => 'Parking';

  @override
  String get setParking => 'Définir la position de stationnement';

  @override
  String get parkingSaved => 'Position de stationnement enregistrée !';

  @override
  String get navigateToVehicle => 'Naviguer vers le véhicule';

  @override
  String get locationPermissionRequired => 'Permission de localisation requise';

  @override
  String get couldNotOpenNav =>
      'Impossible d\'ouvrir l\'application de navigation';

  @override
  String get quickActionsTitle => 'Actions rapides';

  @override
  String get findVehicle => 'Trouver le véhicule';

  @override
  String get startTrip => 'Démarrer le trajet';

  @override
  String get addExpense => 'Ajouter une dépense';

  @override
  String get parkCar => 'Garer la voiture';

  @override
  String get finishTrip => 'Terminer le trajet';

  @override
  String mileageCheck(int mileage) {
    return 'Le compteur est-il à $mileage ?';
  }

  @override
  String get tempTripNotice =>
      'Oh là là ! Quelqu\'un semble avoir oublié d\'ajouter le dernier trajet. Nous allons maintenant créer un trajet temporaire afin que le compteur kilométrique et notre carnet de bord correspondent. Le groupe doit découvrir pourquoi cet écart existe.';

  @override
  String get haveNiceTrip => 'Bon trajet !';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get date => 'Date';

  @override
  String get user => 'Utilisateur';

  @override
  String get selectUser => 'Sélectionner un utilisateur';

  @override
  String get amountRequired => 'Le montant est requis';

  @override
  String get create => 'Créer';

  @override
  String get update => 'Mettre à jour';

  @override
  String get notSet => 'Non défini';

  @override
  String get noCarSelected => 'Aucune voiture sélectionnée';

  @override
  String get retry => 'Réessayer';

  @override
  String get cancel => 'Annuler';

  @override
  String get ok => 'OK';

  @override
  String get delete => 'Supprimer';

  @override
  String get confirm => 'Confirmer';

  @override
  String get pleaseSelectStartTime =>
      'Veuillez sélectionner une heure de départ';

  @override
  String get pleaseSelectEndTime => 'Veuillez sélectionner une heure de fin';

  @override
  String get enterWholeNumber => 'Entrez un nombre entier';

  @override
  String get enterValidNumber => 'Entrez un nombre valide';

  @override
  String get tripSelectAtLeastOneUser => 'Sélectionnez au moins un utilisateur';

  @override
  String get tripEndMileageMustExceedStart =>
      'Le kilométrage de fin doit être supérieur au kilométrage de départ';

  @override
  String get tripEndDateMustNotBeBeforeStart =>
      'La date de fin doit être postérieure ou égale à la date de début';

  @override
  String get tripDatesCannotBeInFuture =>
      'Les dates du trajet ne peuvent pas être dans le futur';

  @override
  String tripStartDateMustNotBeBeforePreviousEnd(Object date) {
    return 'La date de début ne peut pas être antérieure à la fin du trajet précédent, le $date';
  }

  @override
  String get board_system_trip_added =>
      '<strong>%user%</strong> a ajouté un nouveau trajet avec <strong>%car%</strong>.';

  @override
  String get board_system_booking_added =>
      '<strong>%user%</strong> a ajouté une nouvelle réservation pour <strong>%car%</strong> (<em>%start%</em> – <em>%end%</em>).';

  @override
  String get board_system_booking_updated =>
      '<strong>%user%</strong> a mis à jour une réservation pour <strong>%car%</strong>.';

  @override
  String get board_system_booking_deleted =>
      '<strong>%user%</strong> a supprimé une réservation pour <strong>%car%</strong> : <em>%title%</em> (%start% – %end%).';

  @override
  String get board_system_payment_added =>
      '<strong>%from%</strong> a envoyé un paiement à <strong>%to%</strong> pour <strong>%car%</strong>.';

  @override
  String get board_system_invitation_created =>
      '<strong>%user%</strong> a invité <em>%email%</em> à rejoindre <strong>%car%</strong>.';

  @override
  String get board_system_invitation_accepted =>
      '<strong>%user%</strong> a rejoint <strong>%car%</strong>.';

  @override
  String get board_system_user_removed =>
      '<strong>%user%</strong> a quitté <strong>%car%</strong> ou en a été retiré.';

  @override
  String get board_system_price_per_unit_changed =>
      'Le prix par unité pour le groupe <strong>%group%</strong> dans <strong>%car%</strong> a changé de %old_price% € à <strong>%new_price% €</strong>.';

  @override
  String get board_system_milestone_100k =>
      '<strong>%car%</strong> vient d\'atteindre <strong>100 000 %unit%</strong> ! Le compteur a franchi les six chiffres, un moment historique.';

  @override
  String get board_system_milestone_200k =>
      '<strong>%car%</strong> dépasse <strong>200 000 %unit%</strong> ! Cela représente environ cinq tours de l\'équateur terrestre.';

  @override
  String get board_system_milestone_300k =>
      '<strong>%car%</strong> atteint <strong>300 000 %unit%</strong> ! Vous auriez pu rouler jusqu\'à la Lune et faire une bonne partie du chemin retour.';

  @override
  String get board_system_milestone_400k =>
      '<strong>%car%</strong> dépasse <strong>400 000 %unit%</strong> ! C\'est la distance jusqu\'à la Lune, accomplie sur quatre roues.';

  @override
  String get board_system_milestone_500k =>
      'UN DEMI-MILLION ! <strong>%car%</strong> dépasse <strong>500 000 %unit%</strong>.';

  @override
  String get board_system_milestone_600k =>
      '<strong>%car%</strong> franchit <strong>600 000 %unit%</strong> ! Cela représente quinze tours de l\'équateur terrestre.';

  @override
  String get board_system_milestone_700k =>
      '<strong>%car%</strong> dépasse <strong>700 000 %unit%</strong> ! Vous avez presque couvert la distance entre la Terre et Vénus.';

  @override
  String get board_system_milestone_800k =>
      '<strong>%car%</strong> dépasse <strong>800 000 %unit%</strong> ! Plus que 200 000 avant le million magique.';

  @override
  String get board_system_milestone_900k =>
      '<strong>%car%</strong> franchit <strong>900 000 %unit%</strong> ! L\'avant-dernier grand palier.';

  @override
  String get board_system_milestone_1000k =>
      'UN MILLION ! <strong>%car%</strong> conquiert le palier ultime : <strong>1 000 000 %unit%</strong>.';

  @override
  String get board_system_milestone_repeating =>
      '<strong>%car%</strong> vient de dépasser <strong>%milestone% %unit%</strong> : quel joli nombre.';
}
