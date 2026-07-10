// login.dart
//
// Login screen: navy hero section with the HerGuardian logo up top, a
// language switcher, and a cream card that animates up from the bottom
// ("pop up") containing the actual email/password form.

import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'localization/translations.dart';
import 'localization/language_switcher.dart';
import 'localization/app_language.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final email = TextEditingController();
  final password = TextEditingController();

  late final AnimationController _controller;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.35),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppColors.navy),
      filled: true,
      fillColor: AppColors.lightBlue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
    final size = MediaQuery.of(context).size;

    return ValueListenableBuilder<AppLang>(
      valueListenable: AppLanguage.current,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: AppColors.navy,
          body: Stack(
            children: [
              // Hero section: logo + welcome text
              SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.06),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: LanguageSwitcher(
                          activeColor: AppColors.cream,
                          inactiveColor: Color(0x33FFFFFF),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.04),
                    Image.asset(
                      'assets/images/herguardian_logo.png',
                      width: size.width * 0.32,
                      height: size.width * 0.32,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      tr('welcome_back'),
                      style: const TextStyle(
                        color: AppColors.cream,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      tr('sign_in_subtitle'),
                      style: TextStyle(
                        color: AppColors.cream.withValues(alpha: 0.75),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Pop-up card with the actual form
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: _slideAnim,
                  child: FadeTransition(
                    opacity: _fadeAnim,
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.fromLTRB(28, 36, 28, 32),
                      decoration: const BoxDecoration(
                        color: AppColors.cream,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            tr('login'),
                            style: const TextStyle(
                              color: AppColors.navy,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 22),
                          TextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: _fieldDecoration(tr('email')),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: password,
                            obscureText: true,
                            decoration: _fieldDecoration(tr('password')),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/otp');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.navy,
                              foregroundColor: AppColors.cream,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: Text(tr('login')),
                          ),
                          const SizedBox(height: 14),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              tr('new_user_register'),
                              style: const TextStyle(color: AppColors.navy),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
