import 'package:flutterv1/features/auth/domain/entities/user.dart';
import 'package:flutterv1/shared/domain/repositories/session_repository.dart';
import 'package:flutterv1/shared/domain/repositories/user_repository.dart';

class GetCurrentUser {
  final SessionRepository _repo;
  final UserRepository _userRepo;
  GetCurrentUser(this._repo, this._userRepo);
  Future<User?> call() async {
    final userId = await _repo.getCurrentUserId();
    final user = _userRepo.getUserById(userId);
    return user;
  }
}
