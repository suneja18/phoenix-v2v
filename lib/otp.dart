// otp.dart
//
// OTP verification screen. Accepts the emergency contact captured at
// Register so it can show "OTP sent to <name> (<phone>)". Actual SMS
// sending isn't wired up yet — this is a UI-complete placeholder that
// accepts any code for now (that logic comes in a later pass).

import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/language_switcher.dart';
import 'localization/app_language.dart';
import 'permission_screen.dart';

class OtpScreen extends StatefulWidget {
  final String contactName;
  final String contactPhone;

  const OtpScreen({
    super.key,
    this.contactName = '',
    this.contactPhone = '',
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otp = TextEditingController();

  @override
  void dispose() {
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasContact = widget.contactName.isNotEmpty;

    return ValueListenableBuilder<AppLang>(
      valueListenable: AppLanguage.current,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: AppColors.cream,
          appBar: AppBar(
            backgroundColor: AppColors.navy,
            foregroundColor: AppColors.cream,
            title: Text(tr('enter_otp')),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Center(child: LanguageSwitcher()),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (hasContact)
                  Text(
                    '${tr('otp_sent_prefix')} ${widget.contactName} (${widget.contactPhone})',
                    style: const TextStyle(
                      color: AppColors.navy,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else
                  Text(tr('enter_otp'),
                      style: const TextStyle(color: AppColors.navy)),
                const SizedBox(height: 20),
                TextField(
                  controller: otp,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: tr('enter_otp'),
                    filled: true,
                    fillColor: AppColors.lightBlue,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PermissionScreen()),
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
                  child: Text(tr('verify')),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
