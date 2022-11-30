import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> getSketchDailyApi(String endpoint,
    [Map<String, String>? parameters]) async {
  const codec = JsonCodec();
  final response = await http
      .get(Uri.http('reference.sketchdaily.net:4000', endpoint, parameters));

  if (response.statusCode == 200) {
    return codec.decode(response.body);
  } else {
    throw Exception('Unexpected api status code ${response.statusCode}');
  }
}
