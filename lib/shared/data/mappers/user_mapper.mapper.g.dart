// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class UserMapperImpl extends UserMapper {
  UserMapperImpl() : super();

  @override
  User toUser(UserModel model) {
    final user = User(
      id: model.id,
      companyId: model.companyId,
      name: model.name,
      lastName: model.lastName,
      role: roleFromString(model.role),
      email: model.email,
    );
    return user;
  }

  @override
  UserModel toModel(User user) {
    final usermodel = UserModel(
      id: user.id,
      companyId: user.companyId,
      name: user.name,
      lastName: user.lastName,
      email: user.email,
      role: roleToString(user.role),
    );
    return usermodel;
  }
}
