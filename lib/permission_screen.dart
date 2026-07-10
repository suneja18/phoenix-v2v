// permission_screen.dart
//
// Requests core permissions, then advances to Emergency Contacts once the
// user has actually responded to every dialog (not on a fixed timer).

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/app_language.dart';
import 'emergency_contacts_screen.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  Future<void> _handlePermissions() async {
    final statuses = await [
      Permission.location,
      Permission.microphone,
      Permission.phone,
      Permission.sms,
      Permission.notification,
    ].request();

    // Debug visibility — check Logcat/console to see exactly what was
    // granted vs denied on this run.
    statuses.forEach((permission, status) {
      debugPrint('$permission -> $status');
    });

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EmergencyContactsScreen()),
    );
  }

  @override
  void initState() {
    super.initState();
    _handlePermissions();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLang>(
      valueListenable: AppLanguage.current,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: AppColors.cream,
          appBar: AppBar(
            backgroundColor: AppColors.navy,
            foregroundColor: AppColors.cream,
            title: Text(tr('permissions_title')),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: AppColors.navy),
                  const SizedBox(height: 20),
                  Text(
                    tr('permissions_desc'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.navy, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
