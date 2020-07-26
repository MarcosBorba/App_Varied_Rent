import 'package:dio/dio.dart';
import 'package:varied_rent/models/models.dart';

class AdApiCLient {
  static const baseUrl = 'http://192.168.2.180:3000/adRoute';
  Dio dio = new Dio();
  AdApiCLient();

  Future getAdsComponents(Address address, String token, String email) async {
    final userCheckUserUrl = '$baseUrl/getAdsComponents';
    /* final ad */
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
