// lib/core/l10n/app_en.dart
import 'app_localizations.dart';

class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn() : super('en');

  @override String get appName => 'SmartQueue';
  @override String get hello => 'Hello';
  @override String get whereToGo => 'Where would you like to go?';
  @override String get search => 'Search';
  @override String get searchHint => 'Bank, hospital, city...';
  @override String get myEstablishments => 'My establishments';
  @override String get results => 'Results';
  @override String get noFavorites => 'No favorites yet.\nSearch for an establishment to add one.';
  @override String get noResults => 'No establishment found.';
  @override String get open => 'Open';
  @override String get closed => 'Closed';

  // Auth
  @override String get login => 'Sign in';
  @override String get register => 'Create account';
  @override String get logout => 'Sign out';
  @override String get email => 'Email';
  @override String get password => 'Password';
  @override String get firstName => 'First name';
  @override String get lastName => 'Last name';
  @override String get phone => 'Phone';
  @override String get continueAsGuest => 'Continue as guest';
  @override String get guestMode => 'Guest Mode';
  @override String get limitedFeatures => 'Limited features';
  @override String get leaveGuestMode => 'Leave guest mode';

  // Profile
  @override String get myProfile => 'My profile';
  @override String get editProfile => 'Edit profile';
  @override String get changePassword => 'Change password';
  @override String get language => 'Language';
  @override String get myTickets => 'My tickets';
  @override String get favoriteEstablishments => 'Favorite establishments';
  @override String get about => 'About';
  @override String get appVersion => 'App version';
  @override String get account => 'Account';
  @override String get myData => 'My data';
  @override String get save => 'Save';
  @override String get currentPassword => 'Current password';
  @override String get newPassword => 'New password';
  @override String get confirmPassword => 'Confirm new password';
  @override String get modify => 'Update';
  @override String get chooseLanguage => 'Choose language';
  @override String get profileUpdated => 'Profile updated!';
  @override String get passwordChanged => 'Password changed!';
  @override String get languageChanged => 'Language changed';
  @override String get passwordMismatch => 'Passwords do not match';
  @override String get passwordTooShort => 'Minimum 8 characters';
  @override String get wrongPassword => 'Current password is incorrect';
  @override String get updateError => 'Error while updating';

  // Tickets
  @override String get activeTicket => 'Active ticket';
  @override String get myTurn => 'It\'s your turn!';
  @override String get position => 'Position';
  @override String get estimatedWait => 'Estimated wait';
  @override String get cancelTicket => 'Cancel ticket';
  @override String get seeQrCode => 'See QR Code';
  @override String get all => 'All';
  @override String get completed => 'Completed';
  @override String get cancelled => 'Cancelled';
  @override String get missed => 'Missed';
  @override String get noTickets => 'No tickets';
  @override String get takeTicket => 'Take a ticket';
  @override String get waiting => 'Waiting';
  @override String get called => 'Called';

  // Branch
  @override String get queues => 'queues';
  @override String get goToCounter => 'Go to';

  // Onboarding
  @override String get skip => 'Skip';
  @override String get next => 'Next';
  @override String get getStarted => 'Get started';
}
