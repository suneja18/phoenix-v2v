import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'otp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/otp': (context) => OtpScreen(),
      },
    );
  }
}