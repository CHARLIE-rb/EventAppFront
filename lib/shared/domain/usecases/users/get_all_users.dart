import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/domain/repositories/user_repository.dart';

class GetAllUsers {
  final UserRepository _userRepository;
  GetAllUsers(this._userRepository);
  Future<List<User>> call() async {
    return _userRepository.getAllUsers();
  }
}
