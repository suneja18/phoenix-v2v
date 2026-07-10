import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'emergency_contacts_screen.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  Future<void> requestPermissions() async {
    await [
      Permission.location,
      Permission.microphone,
      Permission.phone,
      Permission.sms,
      Permission.notification,
    ].request();
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmergencyContactsScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Permissions")),
      body: const Center(
        child: Text("Requesting permissions..."),
      ),
    );
  }
}
