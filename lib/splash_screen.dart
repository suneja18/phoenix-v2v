// splash_screen.dart
//
// HerGuardian splash screen — shows the real logo (assets/images/herguardian_logo.png)
// with a 2-second scale/fade entrance plus a radar "ping" ring animation that
// echoes the concentric rings already in the logo mark. Auto-navigates to
// LoginScreen when done.
//
// Setup:
// 1. Place herguardian_logo.png in assets/images/
// 2. Confirm pubspec.yaml has:
//      flutter:
//        assets:
//          - assets/images/herguardian_logo.png
// 3. Set this as your app's home / initial route instead of LoginScreen,
//    and navigate onward from onFinished (see main.dart wiring below).

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'login.dart';

const double kSplashDuration = 2.0; // seconds, total

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 150), () {
          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final logoSize = size.width * 0.55;

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.navy,
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final t = _controller.value * kSplashDuration;

              // Logo entrance: scale 0.75 -> 1.0 and fade in, 0.0s - 0.7s
              final entranceP = Curves.easeOutCubic.transform(
                (t / 0.7).clamp(0.0, 1.0),
              );
              final scale = 0.75 + 0.25 * entranceP;
              final opacity = entranceP;

              return SizedBox(
                width: logoSize,
                height: logoSize,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Radar ping rings, looping every ~1s within the 2s window
                    ..._buildPingRings(t, logoSize),

                    // The actual logo
                    Opacity(
                      opacity: opacity,
                      child: Transform.scale(
                        scale: scale,
                        child: Image.asset(
                          'assets/images/herguardian_logo.png',
                          width: logoSize,
                          height: logoSize,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPingRings(double t, double logoSize) {
    // Two staggered pings, each ~1s, expanding + fading, starting after the
    // logo has begun appearing so it reads as "the badge is transmitting."
    const pingStarts = [0.35, 0.95];
    const pingDuration = 0.9;

    return pingStarts.map((start) {
      if (t < start) return const SizedBox.shrink();
      final p = ((t - start) / pingDuration).clamp(0.0, 1.0);
      if (p >= 1.0) return const SizedBox.shrink();

      final eased = Curves.easeOut.transform(p);
      final ringSize = logoSize * (0.62 + 0.55 * eased);
      final opacity = (1 - eased) * 0.5;

      return Container(
        width: ringSize,
        height: ringSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.lightBlue.withValues(alpha: opacity),
            width: 2,
          ),
        ),
      );
    }).toList();
  }
}
