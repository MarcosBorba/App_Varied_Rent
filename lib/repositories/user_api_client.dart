import 'package:dio/dio.dart';
import 'package:varied_rent/models/models.dart';

class UserApiClient {
  static const baseUrl = 'http://192.168.2.107:3000/userRoute';
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

  Future checkUser(User dataToCreateUser, String token) async {
    final userCheckUserUrl = '$baseUrl/check_user';
    final data = dataToCreateUser.userLogintoJson();
    try {
      await dio.post(
        userCheckUserUrl,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'x-access-token': token
        }),
      );
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

  Future updateEmailUser(String oldEmail, String newEmail,
      String newEmailConfirmed, String token) async {
    final userCheckUserUrl = '$baseUrl/update_email';
    final Map<String, String> data = {
      "oldEmail": oldEmail,
      "newEmail": newEmail,
      "newEmailConfirmed": newEmailConfirmed
    };
    try {
      await dio.put(
        userCheckUserUrl,
        data: data,
        options: Options(headers: {'x-access-token': token}),
      );
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

  Future updatePasswordUser(String userEmail, String newPassword,
      String newPasswordConfirmed, String token) async {
    final userCheckUserUrl = '$baseUrl/update_password';
    final Map<String, String> data = {
      "userEmail": userEmail,
      "newPassword": newPassword,
      "newPasswordConfirmed": newPasswordConfirmed
    };
    try {
      await dio.put(
        userCheckUserUrl,
        data: data,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
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

  Future updateUserProfile(User user, String token, String oldCpfCnpj) async {
    final userCheckUserUrl = '$baseUrl/update_profile';
    final Map<String, dynamic> jsonUserProfile = {
      "old_cpf_cnpj": oldCpfCnpj,
      "name": user.name,
      "genre": user.genre,
      "landlord_type": user.landlord_type,
      "cpf_cnpj": user.cpf_cnpj,
      "phones": {
        "telephone1": user.phones.telephone1,
        "telephone2": user.phones.telephone2,
      },
    };
    try {
      await dio.put(
        userCheckUserUrl,
        data: jsonUserProfile,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
    } catch (error) {
      print("error message: " + error.message);
      if (error is DioError) {
        if (error.response == null) {
          throw new DioError(error: "500 - Internal Server Error");
        } else {
          throw new DioError(
              error: error.response.statusCode.toString() +
                  " - " +
                  error.response.data['message']);
        }
      }
    }
  }

  Future updateUserAddress(Address address, String token, String email) async {
    final userCheckUserUrl = '$baseUrl/update_address';
    final Map<String, dynamic> jsonUserAddress = {
      "email": email,
      "country": address.country,
      "state": address.state,
      "city": address.city,
      "zip_code": address.zip_code,
      "neighborhood": address.neighborhood,
      "street": address.street,
      "number": address.number,
    };
    try {
      await dio.put(
        userCheckUserUrl,
        data: jsonUserAddress,
        options: Options(
          headers: {'x-access-token': token},
        ),
      );
    } catch (error) {
      print("error message: " + error.message);
      if (error is DioError) {
        if (error.response == null) {
          throw new DioError(error: "500 - Internal Server Error");
        } else {
          throw new DioError(
              error: error.response.statusCode.toString() +
                  " - " +
                  error.response.data['message']);
        }
      }
    }
  }
}
