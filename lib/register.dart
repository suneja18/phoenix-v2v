// register.dart
//
// Registration now also collects the primary emergency contact right away.
// That contact's name/phone is passed to OtpScreen, which "sends" the OTP to
// them (simulated) as a consent-style verification step, and gets auto-saved
// into Emergency Contacts once verified.

import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/language_switcher.dart';
import 'localization/app_language.dart';
import 'otp.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final contactName = TextEditingController();
  final contactPhone = TextEditingController();

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.navy),
      filled: true,
      fillColor: AppColors.lightBlue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.navy, width: 1.6),
      ),
    );
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
            title: Text(tr('create_account')),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(child: LanguageSwitcher()),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: name,
                    decoration: _fieldDecoration(tr('name')),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: email,
                    decoration: _fieldDecoration(tr('email')),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: _fieldDecoration(tr('password')),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    tr('emergency_contact_name'),
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: contactName,
                    decoration: _fieldDecoration(tr('emergency_contact_name')),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: contactPhone,
                    keyboardType: TextInputType.phone,
                    decoration: _fieldDecoration(tr('emergency_contact_phone')),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OtpScreen(
                            contactName: contactName.text.trim(),
                            contactPhone: contactPhone.text.trim(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.navy,
                      foregroundColor: AppColors.cream,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(tr('register_button')),
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
