// language_switcher.dart
//
// Drop <LanguageSwitcher /> onto any screen to let the user change the
// app-wide language. Changing it here updates every screen using tr().

import 'package:flutter/material.dart';
import 'app_language.dart';

class LanguageSwitcher extends StatelessWidget {
  final Color activeColor;
  final Color inactiveColor;

  const LanguageSwitcher({
    super.key,
    this.activeColor = const Color(0xFF154D7B),
    this.inactiveColor = const Color(0xFFD3E1EE),
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLang>(
      valueListenable: AppLanguage.current,
      builder: (context, currentLang, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _langChip('EN', AppLang.en, currentLang),
            const SizedBox(width: 8),
            _langChip('हिं', AppLang.hi, currentLang),
            const SizedBox(width: 8),
            _langChip('मर', AppLang.mr, currentLang),
          ],
        );
      },
    );
  }

  Widget _langChip(String label, AppLang lang, AppLang current) {
    final isActive = lang == current;
    return GestureDetector(
      onTap: () => AppLanguage.current.value = lang,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? activeColor : inactiveColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : activeColor,
          ),
        ),
      ),
    );
  }
}
