// lib/features/auth/data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel {
  final String id, name, lastName, email, password, pin;
  final int companyId;
  final Role role;

  UserModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.lastName,
    required this.email,
    required this.password,
    required this.pin,
    required this.role,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    companyId: json['company_id'] as int,
    name: json['name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String,
    password: json['password'] as String,
    pin: json['pin'] as String,
    role: Role.values.firstWhere((e) => e.toString() == 'Role.${json['role']}'),
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'company_id': companyId,
    'name': name,
    'last_name': lastName,
    'email': email,
    'password': password,
    'pin': pin,
    'role': role.toString().split('.').last,
  };
}
