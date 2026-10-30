// lib/core/l10n/app_localizations.dart
import 'package:flutter/material.dart';
import 'app_ar.dart';
import 'app_en.dart';
import 'app_fr.dart';

abstract class AppLocalizations {
  AppLocalizations(this.locale);
  final String locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // App
  String get appName;
  String get hello;
  String get whereToGo;
  String get search;
  String get searchHint;
  String get myEstablishments;
  String get results;
  String get noFavorites;
  String get noResults;
  String get open;
  String get closed;

  // Auth
  String get login;
  String get register;
  String get logout;
  String get email;
  String get password;
  String get firstName;
  String get lastName;
  String get phone;
  String get continueAsGuest;
  String get guestMode;
  String get limitedFeatures;
  String get leaveGuestMode;

  // Profile
  String get myProfile;
  String get editProfile;
  String get changePassword;
  String get language;
  String get myTickets;
  String get favoriteEstablishments;
  String get about;
  String get appVersion;
  String get account;
  String get myData;
  String get save;
  String get currentPassword;
  String get newPassword;
  String get confirmPassword;
  String get modify;
  String get chooseLanguage;
  String get profileUpdated;
  String get passwordChanged;
  String get languageChanged;
  String get passwordMismatch;
  String get passwordTooShort;
  String get wrongPassword;
  String get updateError;

  // Tickets
  String get activeTicket;
  String get myTurn;
  String get position;
  String get estimatedWait;
  String get cancelTicket;
  String get seeQrCode;
  String get all;
  String get completed;
  String get cancelled;
  String get missed;
  String get noTickets;
  String get takeTicket;
  String get waiting;
  String get called;

  // Branch
  String get queues;
  String get goToCounter;

  // Onboarding
  String get skip;
  String get next;
  String get getStarted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['fr', 'ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return switch (locale.languageCode) {
      'ar' => AppLocalizationsAr(),
      'en' => AppLocalizationsEn(),
      _    => AppLocalizationsFr(),
    };
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
