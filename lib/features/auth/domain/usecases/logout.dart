import 'package:flutterv1/features/auth/domain/repositories/auth_repository.dart';

class Logout {
  final AuthRepository authRepository;

  Logout(this.authRepository);

  Future<void> call() async {
    await authRepository.logout();
  }
}
