// lib/features/ticket/presentation/screens/qr_code_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smartqueue/core/theme/app_theme.dart';
import 'package:smartqueue/features/ticket/presentation/providers/ticket_provider.dart';

class QrCodeScreen extends ConsumerWidget {
  const QrCodeScreen({super.key, required this.ticketId});
  final String ticketId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketAsync = ref.watch(ticketStreamProvider(ticketId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => context.pop()),
      ),
      body: ticketAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:   (e, _) => Center(child: Text(e.toString())),
        data:    (ticket) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                'Présentez ce code à l\'agent\nou à la borne de l\'établissement.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5)),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(
                    color: AppColors.accent.withOpacity(.15),
                    blurRadius: 40, offset: const Offset(0, 8))]),
                child: QrImageView(
                  data: '${ticket.id}|${ticket.code}',
                  version: QrVersions.auto, size: 220,
                  backgroundColor: Colors.white,
                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square, color: Color(0xFF0A0D14)),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square, color: Color(0xFF0A0D14)),
                ),
              ).animate()
                .scale(begin: const Offset(.85,.85), duration: 500.ms, curve: Curves.easeOutBack)
                .fadeIn(),
              const SizedBox(height: 28),
              Text(ticket.code, style: const TextStyle(
                fontSize: 36, fontWeight: FontWeight.w700,
                color: AppColors.accent, letterSpacing: 2))
                .animate(delay: 200.ms).fadeIn(),
              const SizedBox(height: 6),
              Text(ticket.service.name,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14))
                .animate(delay: 250.ms).fadeIn(),
              const SizedBox(height: 4),
              Text(ticket.branch.name,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 12))
                .animate(delay: 280.ms).fadeIn(),
              const SizedBox(height: 40),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(minimumSize: const Size(200, 44)),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: ticket.code));
                  HapticFeedback.lightImpact();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Code copié !'), duration: Duration(seconds: 2)));
                },
                icon: const Icon(Icons.copy_outlined, size: 16),
                label: const Text('Copier le code'),
              ).animate(delay: 320.ms).fadeIn(),
            ]),
          ),
        ),
      ),
    );
  }
}
