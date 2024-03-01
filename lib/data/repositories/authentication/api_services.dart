import 'package:furniture_store/utils/http/http_client.dart';
import 'package:get/get.dart';

class HttpService extends GetxService {
  static HttpService get instance => Get.find();

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    return THttpHelper.post('auth/login', {
      "email": email,
      "password": password,
    });
  }

  Future getProduct(String email, String password) async {
    return THttpHelper.post('graphql', {
      "query":
          "query { product(id: \"65d88dce88520bc98eef2974\") { _id  images{imageurl} rate details { wood cloth condition color delevary negotiable modefiable } } }"
    });
  }

  Future<void> signUpUser(String firstName, String lastName,
      String username, String phoneNum, String email, String password) async {
     THttpHelper.put('auth/signup', {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "confirmPassword": phoneNum,
      "email": email,
      "password": password
    });
  }

  Future<Map<String, dynamic>> senEmailVerification(String email) async {
    return THttpHelper.post('auth/re-verify-email', {"email": email});
  }

  Future<Map<String, dynamic>> checkIsConfirmed(String email) async {
    return THttpHelper.post('auth/is-confirmed', {"email": email});
  }

  Future<Map<String, dynamic>> sendPasswordResetEmail(String email) async {
    return THttpHelper.post('auth/reset-password-email', {"email": email});
  }
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);

  @override
  String toString() => 'HttpException: $message, Status Code: $statusCode';
}
