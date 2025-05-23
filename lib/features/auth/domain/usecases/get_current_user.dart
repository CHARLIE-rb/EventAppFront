// lib/features/auth/domain/usecases/get_current_user.dart

import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository _repo;
  GetCurrentUser(this._repo);
  User? call() => _repo.getCurrentUser();
}
