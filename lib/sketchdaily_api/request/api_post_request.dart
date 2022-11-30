import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> postJsonSketchDailyApi(String endpoint, dynamic body,
    [Map<String, String>? parameters]) async {
  const codec = JsonCodec();
  final response = await http.post(
      Uri.http('reference.sketchdaily.net:4000', endpoint, parameters),
      body: codec.encode(body),
      headers: {'Content-Type': 'application/json'});

  if (response.statusCode == 200) {
    return codec.decode(response.body);
  } else if (response.statusCode == 204) {
    return null;
  } else {
    throw Exception('Unexpected api status code ${response.statusCode}');
  }
}
