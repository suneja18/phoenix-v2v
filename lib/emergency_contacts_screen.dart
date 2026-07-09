import 'package:flutter/material.dart';

class EmergencyContactsScreen extends StatefulWidget {
  @override
  _EmergencyContactsScreenState createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  List<Map<String, String>> primaryContacts = [];
  List<Map<String, String>> backupContacts = [];

  void addContact(bool isPrimary) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: phoneController, decoration: InputDecoration(labelText: "Phone")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                if (isPrimary) {
                  primaryContacts.add({
                    "name": nameController.text,
                    "phone": phoneController.text,
                  });
                } else {
                  backupContacts.add({
                    "name": nameController.text,
                    "phone": phoneController.text,
                  });
                }
              });
              Navigator.pop(context);
            },
            child: Text("Save"),
          )
        ],
      ),
    );
  }

  Widget buildList(String title, List<Map<String, String>> contacts, bool isPrimary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...contacts.map((c) => ListTile(
          title: Text(c["name"]!),
          subtitle: Text(c["phone"]!),
        )),
        ElevatedButton(
          onPressed: () => addContact(isPrimary),
          child: Text("Add Contact"),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  void saveContacts() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Contacts Saved")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Contacts"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildList("Primary Contacts", primaryContacts, true),
              buildList("Backup Contacts (Security/Warden)", backupContacts, false),
              ElevatedButton(
                onPressed: saveContacts,
                child: Text("Save All"),
              )
            ],
          ),
        ),
      ),
    );
  }
}