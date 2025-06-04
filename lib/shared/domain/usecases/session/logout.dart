import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class Logout {
  final SessionRepository sessionRepository;

  Logout(this.sessionRepository);

  Future<void> call() async {
    await sessionRepository.clearSession();
  }
}
