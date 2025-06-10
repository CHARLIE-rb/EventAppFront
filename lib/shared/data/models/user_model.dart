// lib/features/auth/data/models/user_model.dart

class UserModel {
  final String id, name, lastName, email, password, pin;
  final int companyId;
  final List<String> eventsIds;
  final String role;

  UserModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.lastName,
    required this.email,
    this.password = '',
    this.pin = '',
    this.eventsIds = const [],
    required this.role,
  });
  UserModel.vacio()
    : id = '',
      companyId = 0,
      name = '',
      lastName = '',
      email = '',
      password = '',
      pin = '',
      eventsIds = const [],
      role = '';
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    companyId: json['company_id'] as int,
    name: json['name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    pin: json['pin'] as String,
    eventsIds:
        (json['events_ids'] as List<dynamic>).map((e) => e as String).toList(),
    role: json['role'] as String,
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'company_id': companyId,
    'name': name,
    'last_name': lastName,
    'email': email,
    'password': password,
    'pin': pin,
    'events_ids': eventsIds,
    'role': role.toString().split('.').last,
  };
}
