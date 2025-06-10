import 'package:events_app/shared/domain/entities/user.dart';
import 'package:events_app/shared/domain/repositories/user_repository.dart';

class GetUsersByIds {
  final UserRepository _userRepository;
  GetUsersByIds(this._userRepository);
  Future<List<User>?> call(List<String> userIds) async {
    if (userIds.isEmpty) {
      return [];
    }
    return await _userRepository.getUsersByIds(userIds);
  }
}
