import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> shortenUrl(String longUrl) async {
  const String bitlyAccessToken = "YOUR_BITLY_ACCESS_TOKEN";
  const String apiUrl = "https://api-ssl.bitly.com/v4/shorten";

  var headers = {
    'Authorization': 'Bearer $bitlyAccessToken',
    'Content-Type': 'application/json',
  };

  var body = jsonEncode({
    "long_url": longUrl,
  });

  final response =
      await http.post(Uri.parse(apiUrl), headers: headers, body: body);

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON.
    return jsonDecode(response.body)["link"];
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to shorten URL');
  }
}
