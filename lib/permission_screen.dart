import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'emergency_contacts_screen.dart';

class PermissionScreen extends StatefulWidget {
  @override
  _PermissionScreenState createState() => _PermissionScreenState();
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

    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EmergencyContactsScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Permissions")),
      body: Center(
        child: Text("Requesting permissions..."),
      ),
    );
  }
}