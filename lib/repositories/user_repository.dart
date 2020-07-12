import 'dart:async';
import 'package:meta/meta.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/user_api_client.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({@required this.userApiClient})
      : assert(userApiClient != null);

  Future<User> userLoginRepository(String email, password) async {
    final userLogin = await userApiClient.login(email, password);
    return userLogin;
  }

  Future userSignupRepository(User dataToCreateUser) async {
    await userApiClient.signup(dataToCreateUser);
  }

  Future userCheckUserRepository(User user, String token) async {
    await userApiClient.checkUser(user, token);
  }

  Future userUpdateEmailRepository(String oldEmail, String newEmail,
      String newEmailConfirmed, String token) async {
    await userApiClient.updateEmailUser(
        oldEmail, newEmail, newEmailConfirmed, token);
  }

  Future userUpdatePasswordRepository(String userEmail, String newPassword,
      String newPasswordConfirmed, String token) async {
    await userApiClient.updatePasswordUser(
        userEmail, newPassword, newPasswordConfirmed, token);
  }
}
