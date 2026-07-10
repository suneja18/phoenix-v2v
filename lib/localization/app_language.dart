// app_language.dart
//
// Global current-language state. Any widget that wraps itself in a
// ValueListenableBuilder listening to AppLanguage.current will rebuild
// automatically when the language changes (see main.dart).

import 'package:flutter/foundation.dart';

enum AppLang { en, hi, mr }

class AppLanguage {
  static final ValueNotifier<AppLang> current = ValueNotifier(AppLang.en);
}
