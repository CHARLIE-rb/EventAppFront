import 'package:flutterv1/shared/domain/entities/user.dart';
import 'package:flutterv1/shared/domain/repositories/user_repository.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';

class GetCurrentUser {
  final SessionRepository _sessionRepo;
  final UserRepository _userRepo;
  GetCurrentUser(this._sessionRepo, this._userRepo);
  Future<User?> call() async {
    final username = _sessionRepo.getCurrentUsername();
    if (username != null) {
      final user = _userRepo.getUserByUsername(username);
      return user;
    } else {
      return null;
    }
  }
}
