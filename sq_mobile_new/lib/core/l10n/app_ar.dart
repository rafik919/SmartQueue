// lib/core/l10n/app_ar.dart
import 'app_localizations.dart';

class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr() : super('ar');

  @override String get appName => 'سمارت كيو';
  @override String get hello => 'مرحباً';
  @override String get whereToGo => 'إلى أين تريد الذهاب؟';
  @override String get search => 'بحث';
  @override String get searchHint => 'بنك، مستشفى، مدينة...';
  @override String get myEstablishments => 'مؤسساتي';
  @override String get results => 'النتائج';
  @override String get noFavorites => 'لا توجد مفضلة.\nابحث عن مؤسسة لإضافتها.';
  @override String get noResults => 'لم يتم العثور على مؤسسة.';
  @override String get open => 'مفتوح';
  @override String get closed => 'مغلق';

  // Auth
  @override String get login => 'تسجيل الدخول';
  @override String get register => 'إنشاء حساب';
  @override String get logout => 'تسجيل الخروج';
  @override String get email => 'البريد الإلكتروني';
  @override String get password => 'كلمة المرور';
  @override String get firstName => 'الاسم الأول';
  @override String get lastName => 'اللقب';
  @override String get phone => 'الهاتف';
  @override String get continueAsGuest => 'المتابعة كضيف';
  @override String get guestMode => 'وضع الضيف';
  @override String get limitedFeatures => 'ميزات محدودة';
  @override String get leaveGuestMode => 'الخروج من وضع الضيف';

  // Profile
  @override String get myProfile => 'ملفي الشخصي';
  @override String get editProfile => 'تعديل الملف الشخصي';
  @override String get changePassword => 'تغيير كلمة المرور';
  @override String get language => 'اللغة';
  @override String get myTickets => 'تذاكري';
  @override String get favoriteEstablishments => 'المؤسسات المفضلة';
  @override String get about => 'حول التطبيق';
  @override String get appVersion => 'إصدار التطبيق';
  @override String get account => 'الحساب';
  @override String get myData => 'بياناتي';
  @override String get save => 'حفظ';
  @override String get currentPassword => 'كلمة المرور الحالية';
  @override String get newPassword => 'كلمة المرور الجديدة';
  @override String get confirmPassword => 'تأكيد كلمة المرور';
  @override String get modify => 'تعديل';
  @override String get chooseLanguage => 'اختر اللغة';
  @override String get profileUpdated => 'تم تحديث الملف الشخصي!';
  @override String get passwordChanged => 'تم تغيير كلمة المرور!';
  @override String get languageChanged => 'تم تغيير اللغة';
  @override String get passwordMismatch => 'كلمتا المرور غير متطابقتين';
  @override String get passwordTooShort => '8 أحرف على الأقل';
  @override String get wrongPassword => 'كلمة المرور الحالية غير صحيحة';
  @override String get updateError => 'خطأ أثناء التحديث';

  // Tickets
  @override String get activeTicket => 'تذكرة نشطة';
  @override String get myTurn => 'حان دورك!';
  @override String get position => 'الموضع';
  @override String get estimatedWait => 'وقت الانتظار المقدر';
  @override String get cancelTicket => 'إلغاء التذكرة';
  @override String get seeQrCode => 'عرض رمز QR';
  @override String get all => 'الكل';
  @override String get completed => 'المكتملة';
  @override String get cancelled => 'الملغاة';
  @override String get missed => 'الفائتة';
  @override String get noTickets => 'لا توجد تذاكر';
  @override String get takeTicket => 'أخذ تذكرة';
  @override String get waiting => 'في الانتظار';
  @override String get called => 'تم الاستدعاء';

  // Branch
  @override String get queues => 'طوابير';
  @override String get goToCounter => 'توجه إلى';

  // Onboarding
  @override String get skip => 'تخطي';
  @override String get next => 'التالي';
  @override String get getStarted => 'ابدأ';
}
