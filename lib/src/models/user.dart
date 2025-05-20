import 'role.dart';

class User {
  final String id;
  final String name;
  final String lastName;

  final Role role;
  final String email;
  final String password;
  final String pin;

  /// IDs de los eventos asignados (solo se usa para usuarios no-manager)
  final List<String>? registeredEventIds;

  User({
    required this.id,
    required this.name,
    required this.lastName,
    required this.role,
    required this.pin,
    required this.email,
    required this.password,
    this.registeredEventIds = const [],
  });
}
