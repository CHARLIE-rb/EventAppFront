import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/domain/repositories/user_repository.dart';

class CreateUser {
  final UserRepository userRepository;
  CreateUser(this.userRepository);
  Future<void> call(User user) async {
    await userRepository.createUser(user);
  }
}
