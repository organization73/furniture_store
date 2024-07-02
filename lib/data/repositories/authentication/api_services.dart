import 'dart:convert';
import 'package:decordash/features/product/model/product_model.dart';
import 'package:decordash/utils/graphql/querys.dart';
import 'package:decordash/utils/http/http_client.dart';
import 'package:decordash/utils/logging/logger.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HttpService extends GetxService {
  static HttpService get instance => Get.find();

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      return THttpHelper.post('auth/login', {
        "email": email,
        "password": password,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<List<dynamic>> getProducts(int page, String token) async {
    String query = Querys.productsQuery(page);
    var response = await THttpHelper.postWithBearAuthForGraphQLRequest(
        token, 'graphql', query);
    print(response);
    return response['data']['products']['products'];
  }

  Future<void> addProduct(ProductModel product) async {
    var m = {
      "title": product.productName,
      "price": product.productPrice,
      "description": product.productDetails.productDesc,
      "images": product.productDetails.productListImages,
      "details": {
        "wood": product.productDetails.productSpecs['ablakash'],
        "abalakach":"your ablakash here",
        "cloth": product.productDetails.productSpecs['fabric type'],
        "condition": product.productDetails.condition,
        "color": product.productDetails.color,
        "delevary": product.productDetails.productStats.delivery,
        "negotiable": product.productDetails.productStats.negotiable,
        "modefiable": product.productDetails.productStats.modifiable,
      }
    };
    print('--------------');
    print(m);
    String t = GetStorage().read('token');
    await THttpHelper.postBearerAuth('product/create-product', t, m);
  }

  // Future getProduct() async {
  //   try {
  //     return THttpHelper.post('graphql', {
  //       "query":
  //           "query { product(id: \"65d88dce88520bc98eef2974\") { _id  images{imageurl} rate details { wood cloth condition color delevary negotiable modefiable } } }"
  //     });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  Future<List<dynamic>> getUsers(int page) async {
    String query = Querys.UsersQuery(page);
    var response = await THttpHelper.postWithBearAuthForGraphQLRequest(
        "${GetStorage().read("token")}", 'graphql', query);
    return response['data']['users'];
  }

  Future<List<dynamic>> getProductOfUser(String id) async {
    String query = Querys.getProductOfUser(id);
    var response = await THttpHelper.postWithBearAuthForGraphQLRequest(
        "${GetStorage().read("token")}", 'graphql', query);
    LoggerHelper.error(
        response['data']['usersProducts']['products'].toString());

    return response['data']['usersProducts']['products'];
  }

  // Future<Map<String, dynamic>> getUsers(
  //      Map<String, dynamic> data) async {
  //   try {
  //     var response = await THttpHelper.postBearerAuth('graphql', "${GetStorage().read('token')}", data);
  //     var r = THttpHelper.responseToMap(response);
  //     // r.forEach((key, value) {
  //     //   LoggerHelper.info("key : $key , value : $value");
  //     // });
  //     return r;
  //   } catch (e) {
  //     return {};
  //   }
  // }

// method to change user avater
  Future<http.Response> changeUserAvatar(
      String token, Map<String, dynamic> data) async {
    try {
      return THttpHelper.postBearerAuth('user/assign-image', token, data);
    } catch (e) {
      rethrow;
    }
  }

// method to create product
  static Future<http.Response> apiCreatePoduct(
      String token, Map<String, dynamic> data) async {
    return await THttpHelper.postBearerAuth(
        "product/create-product", token, data);
  }

  Future<void> signUpUser(String firstName, String lastName, String username,
      String phoneNum, String email, String password) async {
    try {
      const uri = 'https://furniture-store-4qhc.onrender.com/auth/signup';
      final response = await http.put(
        Uri.parse(uri),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "firstName": firstName,
          "lastName": lastName,
          "username": username,
          "email": email,
          "password": password,
          "confirmPassword": phoneNum
        }),
      );
      // LoggerHelper.info('Response body: ${response.body}');
      if (response.statusCode == 200) {
        LoggerHelper.info('Request succeeded');
      } else {
        LoggerHelper.error(
            'Request failed with status: ${response.statusCode}');
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (err) {
      LoggerHelper.error('Error sending request: $err');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> senEmailVerification(String email) async {
    try {
      return THttpHelper.post('auth/re-verify-email', {"email": email});
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> checkIsConfirmed(String email) async {
    try {
      return THttpHelper.post('auth/is-confirmed', {"email": email});
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> sendPasswordResetEmail(String email) async {
    try {
      return THttpHelper.post('auth/reset-password-email', {"email": email});
    } catch (e) {
      rethrow;
    }
  }

// chat
  Future<Map<String, dynamic>> accessRoom(String userId) async {
    try {
      var response = await THttpHelper.postBearerAuth(
          "chat/access-room", GetStorage().read("token"), {"userId": userId});
      var r = json.decode(response.body);
      return r;
    } catch (e) {
      return {};
    }
  }

  Future<Map<String, dynamic>> sendMessage() async {
    try {
      var response = await THttpHelper.postBearerAuth(
          "chat/message",
          GetStorage().read("token"),
          {"roomId": "66280d8658b8eb2765b7cc12", "content": "Hello Wrold!"});
      var r = json.decode(response.body);
      return r;
    } catch (e) {
      return {};
    }
  }
}

class HttpException implements Exception {
  final String message;
  final int statusCode;

  HttpException(this.message, this.statusCode);

  @override
  String toString() => 'HttpException: $message, Status Code: $statusCode';
}
