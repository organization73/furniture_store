import 'dart:convert';
import 'package:http/http.dart' as http;

class THttpHelper {
  static const String _baseUrl =
      "http://192.168.1.10:3000"; // Replace with your API base URL

  // Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
      String endpoint, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response> postBearerAuth(
      String endPoint, String token, Map<String, dynamic> data) async {
    return await http.post(
      Uri.parse('$_baseUrl/$endPoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }
  static Future<http.Response> deleteBearerAuth(
      String endPoint, String token, Map<String, dynamic> data) async {
    return await http.delete(
      Uri.parse('$_baseUrl/$endPoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }

  // from http response to map<string , daynamic>
  static Map<String, dynamic> responseToMap(http.Response response) {
    return _handleResponse(response);
  }

  // Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // Helper method to make a put request with bearer token
  static Future<Map<String, dynamic>> putBearerAuth(
      String endPoint, String token, Map<String, dynamic> data) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$endPoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$_baseUrl/$endpoint'));
      return _handleResponse(response);
    } catch (e) {
      rethrow;
    }
  }

  // Handle the HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
    }
  }

  static Future<Map<String, dynamic>> postWithBearAuthForGraphQLRequest(
       String token, String endPoint , String query) async {
    try {
      final respone = await http.post(
        Uri.parse('$_baseUrl/$endPoint'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'query':query,
        }),
      );

      return _handleResponse(respone);
    } catch (e) {
      rethrow;
    }
  }
}
