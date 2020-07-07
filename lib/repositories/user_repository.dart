import 'dart:async';
import 'package:meta/meta.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/user_api_client.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({@required this.userApiClient})
      : assert(userApiClient != null);

  Future<User> userLoginRepository(String email, password) async {
    final token = await userApiClient.login(email, password);
    return token;
  }

  Future userSignupRepository(User dataToCreateUser) async {
    return await userApiClient.signup(dataToCreateUser);
  }

  Future userCheckUserRepository(User user, String token) async {
    return await userApiClient.checkUser(user, token);
  }

  Future userUpdateEmailRepository(String oldEmail, String newEmail,
      String newEmailConfirmed, String token) async {
    return await userApiClient.updateEmailUser(
        oldEmail, newEmail, newEmailConfirmed, token);
  }
}
