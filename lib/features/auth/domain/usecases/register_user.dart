import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository _repo;
  RegisterUser(this._repo);

  Future<User> call(User user) => _repo.register(user);
}
