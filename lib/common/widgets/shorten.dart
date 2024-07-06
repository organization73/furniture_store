import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> shortenUrl(String longUrl) async {
  const String bitlyAccessToken = "e6167e8ed97e21abbb1958cbbe8f40f96f0e6d5e";
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
  print(response.statusCode);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print(response.body);
    print(jsonDecode(response.body)["link"]);

    // If the server returns a 200 OK response, parse the JSON.
    return jsonDecode(response.body)["link"];
  } else if (response.statusCode == 429) {
    throw Exception('Too many requests. Try again later.');
    // If the server did not return a 200 OK response, throw an exception.
  } else {
    throw Exception('Failed to shorten URL');
  }
}
// e6167e8ed97e21abbb1958cbbe8f40f96f0e6d5e