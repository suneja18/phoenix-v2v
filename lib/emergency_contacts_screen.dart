// emergency_contacts_screen.dart
//
// Add/remove primary + backup emergency contacts, persisted locally via Hive
// (works offline — see services/contact_storage_service.dart).

import 'package:flutter/material.dart';
import 'contact_model.dart';
import 'services/contact_storage_service.dart';
import 'theme/app_colors.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() =>
      _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  List<Contact> primaryContacts = [];
  List<Contact> backupContacts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedContacts();
  }

  Future<void> _loadSavedContacts() async {
    final all = await ContactStorageService.loadContacts();
    setState(() {
      primaryContacts = all.where((c) => c.isPrimary).toList();
      backupContacts = all.where((c) => !c.isPrimary).toList();
      _loading = false;
    });
  }

  void addContact(bool isPrimary) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isPrimary ? "Add Primary Contact" : "Add Backup Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty ||
                  phoneController.text.trim().isEmpty) {
                Navigator.pop(context);
                return;
              }
              setState(() {
                final contact = Contact(
                  name: nameController.text.trim(),
                  phone: phoneController.text.trim(),
                  isPrimary: isPrimary,
                );
                if (isPrimary) {
                  primaryContacts.add(contact);
                } else {
                  backupContacts.add(contact);
                }
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void removeContact(bool isPrimary, int index) {
    setState(() {
      if (isPrimary) {
        primaryContacts.removeAt(index);
      } else {
        backupContacts.removeAt(index);
      }
    });
  }

  Widget buildList(String title, List<Contact> contacts, bool isPrimary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 8),
        ...contacts.asMap().entries.map((entry) {
          final i = entry.key;
          final c = entry.value;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(c.name,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(c.phone),
              trailing: IconButton(
                icon: const Icon(Icons.close, color: AppColors.navy),
                onPressed: () => removeContact(isPrimary, i),
              ),
            ),
          );
        }),
        OutlinedButton.icon(
          onPressed: () => addContact(isPrimary),
          icon: const Icon(Icons.add, color: AppColors.navy),
          label: const Text("Add Contact",
              style: TextStyle(color: AppColors.navy)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.navy),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Future<void> saveAll() async {
    final all = [...primaryContacts, ...backupContacts];
    await ContactStorageService.saveContacts(all);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Contacts saved")),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.navy)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: AppColors.cream,
        title: const Text("Emergency Contacts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildList("Primary Contacts", primaryContacts, true),
              buildList(
                  "Backup Contacts (Security/Warden)", backupContacts, false),
              ElevatedButton(
                onPressed: saveAll,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  foregroundColor: AppColors.cream,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text("Save All"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
