// contact_storage_service.dart
//
// Local persistence for emergency contacts using Hive.
// No code generation required — contacts are stored as plain Maps.

import 'package:hive/hive.dart';
import '../contact_model.dart';

class ContactStorageService {
  static const String boxName = 'contactsBox';

  static Future<Box> _openBox() async {
    if (Hive.isBoxOpen(boxName)) return Hive.box(boxName);
    return Hive.openBox(boxName);
  }

  /// Overwrites everything currently stored with the given list.
  static Future<void> saveContacts(List<Contact> contacts) async {
    final box = await _openBox();
    await box.clear();
    for (final c in contacts) {
      await box.add(c.toMap());
    }
  }

  static Future<List<Contact>> loadContacts() async {
    final box = await _openBox();
    return box.values
        .map((e) => Contact.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}
