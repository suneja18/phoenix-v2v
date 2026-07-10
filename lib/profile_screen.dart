// profile_screen.dart
//
// Basic profile placeholder — will connect to real user data once
// accounts are backed by something more than the local demo flow.

import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/language_switcher.dart';
import 'localization/app_language.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            title: Text(tr('profile')),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(child: LanguageSwitcher()),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 44,
                  backgroundColor: AppColors.lightBlue,
                  child: Icon(Icons.person, size: 48, color: AppColors.navy),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Profile details coming soon',
                  style: TextStyle(color: AppColors.navy, fontSize: 15),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
