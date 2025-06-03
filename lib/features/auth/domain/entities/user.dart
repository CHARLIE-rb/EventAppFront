enum Role { ceo, manager, employee, company }

class User {
  final String id;
  final int companyId;
  final String name;
  final String lastName;

  final String email;
  final String password;
  final String pin;
  final Role role;

  /// IDs de los eventos asignados (solo se usa para usuarios no-manager)
  final List<String>? registeredEventIds;

  User({
    required this.id,
    required this.companyId,
    required this.name,
    required this.lastName,
    required this.role,
    required this.pin,
    required this.email,
    required this.password,
    this.registeredEventIds = const [],
  });
}
