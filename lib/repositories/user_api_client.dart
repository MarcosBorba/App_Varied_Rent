import 'package:dio/dio.dart';
import 'package:varied_rent/models/models.dart';

class UserApiClient {
  static const baseUrl = 'http://192.168.2.109:3000/userRoute';
  Dio dio = new Dio();

  UserApiClient();

  Future<User> login(String email, password) async {
    final userLoginUrl = '$baseUrl/login';
    final user = User.login(email, password);
    final data = user.userLogintoJson();
    Response<Map> userLoginResponse;
    try {
      userLoginResponse = await dio.post(userLoginUrl, data: data);
    } catch (e) {
      if (e is DioError) {
        if (e.response == null) {
          throw new DioError(error: "500 - Internal Server Error");
        } else {
          throw new DioError(
              error: e.response.statusCode.toString() +
                  " - " +
                  e.response.data['message']);
        }
      }
    }
    User userLoginSuccess = new User();
    userLoginSuccess =
        userLoginSuccess.fromJsonSharedPrefenrence(userLoginResponse.data);
    return userLoginSuccess;
  }

  Future signup(User dataToCreateUser) async {
    final userSignupUrl = '$baseUrl/signup';
    final profileInstance = dataToCreateUser;
    final instantiatedUser = User(
        name: profileInstance.name,
        genre: profileInstance.genre,
        landlord_type: profileInstance.landlord_type,
        cpf_cnpj: profileInstance.cpf_cnpj,
        email: profileInstance.email,
        phones: profileInstance.phones,
        address: profileInstance.address,
        password: profileInstance.password);
    final Map<String, dynamic> profileInstanceToJson =
        instantiatedUser.toJson();

    try {
      await dio.post(userSignupUrl, data: profileInstanceToJson);
    } catch (e) {
      if (e is DioError) {
        if (e.response == null) {
          throw new DioError(error: "500 - Internal Server Error");
        } else {
          throw new DioError(
              error: e.response.statusCode.toString() +
                  " - " +
                  e.response.data['message']);
        }
      }
    }
  }
}
