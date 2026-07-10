// contact_model.dart
//
// Simple Contact model. Stored in Hive as a plain Map (no code generation
// needed) via toMap() / fromMap().

class Contact {
  final String name;
  final String phone;
  final bool isPrimary;

  Contact({
    required this.name,
    required this.phone,
    required this.isPrimary,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'phone': phone,
    'isPrimary': isPrimary,
  };

  factory Contact.fromMap(Map map) => Contact(
    name: map['name'] as String? ?? '',
    phone: map['phone'] as String? ?? '',
    isPrimary: map['isPrimary'] as bool? ?? false,
  );
}
