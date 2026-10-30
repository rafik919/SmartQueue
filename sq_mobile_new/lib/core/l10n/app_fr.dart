// lib/core/l10n/app_fr.dart
import 'app_localizations.dart';

class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr() : super('fr');

  @override String get appName => 'SmartQueue';
  @override String get hello => 'Bonjour';
  @override String get whereToGo => 'Où souhaitez-vous aller ?';
  @override String get search => 'Chercher';
  @override String get searchHint => 'Banque, hôpital, ville...';
  @override String get myEstablishments => 'Mes établissements';
  @override String get results => 'Résultats';
  @override String get noFavorites => 'Aucun favori.\nRecherchez un établissement pour en ajouter.';
  @override String get noResults => 'Aucun établissement trouvé.';
  @override String get open => 'Ouvert';
  @override String get closed => 'Fermé';

  // Auth
  @override String get login => 'Se connecter';
  @override String get register => 'Créer un compte';
  @override String get logout => 'Se déconnecter';
  @override String get email => 'Email';
  @override String get password => 'Mot de passe';
  @override String get firstName => 'Prénom';
  @override String get lastName => 'Nom';
  @override String get phone => 'Téléphone';
  @override String get continueAsGuest => 'Continuer en tant qu\'invité';
  @override String get guestMode => 'Mode Invité';
  @override String get limitedFeatures => 'Fonctionnalités limitées';
  @override String get leaveGuestMode => 'Quitter le mode invité';

  // Profile
  @override String get myProfile => 'Mon profil';
  @override String get editProfile => 'Modifier mon profil';
  @override String get changePassword => 'Changer le mot de passe';
  @override String get language => 'Langue';
  @override String get myTickets => 'Mes tickets';
  @override String get favoriteEstablishments => 'Établissements favoris';
  @override String get about => 'À propos';
  @override String get appVersion => 'Version de l\'application';
  @override String get account => 'Compte';
  @override String get myData => 'Mes données';
  @override String get save => 'Enregistrer';
  @override String get currentPassword => 'Mot de passe actuel';
  @override String get newPassword => 'Nouveau mot de passe';
  @override String get confirmPassword => 'Confirmer le nouveau';
  @override String get modify => 'Modifier';
  @override String get chooseLanguage => 'Choisir la langue';
  @override String get profileUpdated => 'Profil mis à jour !';
  @override String get passwordChanged => 'Mot de passe modifié !';
  @override String get languageChanged => 'Langue changée';
  @override String get passwordMismatch => 'Les mots de passe ne correspondent pas';
  @override String get passwordTooShort => 'Minimum 8 caractères';
  @override String get wrongPassword => 'Mot de passe actuel incorrect';
  @override String get updateError => 'Erreur lors de la mise à jour';

  // Tickets
  @override String get activeTicket => 'Ticket actif';
  @override String get myTurn => 'C\'est votre tour !';
  @override String get position => 'Position';
  @override String get estimatedWait => 'Attente estimée';
  @override String get cancelTicket => 'Annuler mon ticket';
  @override String get seeQrCode => 'Voir mon QR Code';
  @override String get all => 'Tous';
  @override String get completed => 'Terminés';
  @override String get cancelled => 'Annulés';
  @override String get missed => 'Manqués';
  @override String get noTickets => 'Aucun ticket';
  @override String get takeTicket => 'Prendre un ticket';
  @override String get waiting => 'En attente';
  @override String get called => 'Appelé';

  // Branch
  @override String get queues => 'files';
  @override String get goToCounter => 'Rendez-vous au';

  // Onboarding
  @override String get skip => 'Passer';
  @override String get next => 'Suivant';
  @override String get getStarted => 'Commencer';
}
