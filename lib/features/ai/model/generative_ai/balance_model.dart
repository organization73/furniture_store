// model/balance_model.dart
import 'package:decordashapp/common/widgets/loaders/loaders.dart';
import 'package:decordashapp/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BalanceModel {
  Future<double> fetchBalance() async {
    final url = Uri.parse('https://api.stability.ai/v1/user/balance');
    final headers = {
      'Authorization': aiAPIKey,
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['credits'].toDouble();
      } else {
        throw Exception('Failed to load balance');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
          title: 'ohSnap'.tr, message: 'Something went wrong');
      rethrow;
    }
  }
}
