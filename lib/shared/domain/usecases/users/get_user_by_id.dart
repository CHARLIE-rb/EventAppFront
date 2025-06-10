import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/domain/repositories/user_repository.dart';

class GetUserById {
  final UserRepository _userRepository;

  GetUserById(this._userRepository);

  Future<User?> call(String userId) async {
    return _userRepository.getUserById(userId);
  }
}
