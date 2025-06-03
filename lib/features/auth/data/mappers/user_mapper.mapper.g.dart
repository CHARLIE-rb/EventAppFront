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
      role: model.role,
      pin: model.pin,
      email: model.email,
      password: model.password,
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
      password: user.password,
      pin: user.pin,
      role: user.role,
    );
    return usermodel;
  }
}
