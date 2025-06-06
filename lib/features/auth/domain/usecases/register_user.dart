import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository _repo;
  RegisterUser(this._repo);

  Future<bool> call(User user) async => _repo.register(user);
}
