// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartqueue/core/l10n/app_localizations.dart';
import 'package:smartqueue/core/router/app_router.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/profile/presentation/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const ProviderScope(child: SmartQueueApp()));
}

class SmartQueueApp extends ConsumerWidget {
  const SmartQueueApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router   = ref.watch(appRouterProvider);
    final langCode = ref.watch(languageProvider);

    return MaterialApp.router(
      title: 'SmartQueue',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      routerConfig: router,

      // Localizations
      locale: Locale(langCode),
      supportedLocales: const [
        Locale('fr'),
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // RTL pour l'arabe
      builder: (context, child) {
        return Directionality(
          textDirection: langCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}
