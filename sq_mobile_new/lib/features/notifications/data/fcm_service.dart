// lib/features/notifications/data/fcm_service.dart
// Firebase FCM — actif uniquement sur mobile (Android/iOS)
// Sur web/windows : stub no-op

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'fcm_service.g.dart';

final _log = Logger(printer: PrettyPrinter(methodCount: 0));

@riverpod
FcmService fcmService(FcmServiceRef ref) => FcmService();

class FcmService {
  Future<void> initialize(Ref ref) async {
    // Sur web ou desktop : pas de Firebase Messaging
    if (kIsWeb || !_isMobile()) {
      _log.d('[FCM] Skipped — not a mobile platform');
      return;
    }
    // Sur mobile : import dynamique pour éviter les erreurs de compilation web
    _log.d('[FCM] Initializing on mobile...');
    // Implémentation mobile dans fcm_service_mobile.dart
    // (sera activée quand google-services.json est configuré)
  }

  bool _isMobile() {
    return defaultTargetPlatform == TargetPlatform.android ||
           defaultTargetPlatform == TargetPlatform.iOS;
  }
}
