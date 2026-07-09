import 'package:flutter/material.dart';
import 'permission_screen.dart';

class OtpScreen extends StatelessWidget {
  final otp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP Verification")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Text("Enter OTP sent to your phone"),

            TextField(
              controller: otp,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "OTP"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PermissionScreen()),

                  );
                },
                child: Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}