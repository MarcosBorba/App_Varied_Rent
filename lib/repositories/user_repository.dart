import 'dart:async';
import 'package:meta/meta.dart';
import 'package:varied_rent/models/models.dart';
import 'package:varied_rent/repositories/user_api_client.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({@required this.userApiClient})
      : assert(userApiClient != null);

  Future<String> userLoginRepository(String email,password) async {
    final String token = await userApiClient.login(email, password);
    return token;
  }
  Future<int> userSignupRepository(User dataToCreateUser) async {
    final int responseRequestCreateUser = await userApiClient.signup(dataToCreateUser);
    return responseRequestCreateUser;
  }
}