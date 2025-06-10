import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/domain/repositories/user_repository.dart';

class UpdateUser {
  final UserRepository userRepository;
  UpdateUser(this.userRepository);
  Future<void> call(User user) async {
    await userRepository.updateUser(user);
  }
}
