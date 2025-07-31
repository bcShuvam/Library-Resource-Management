import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  static Future<dynamic> post({
    required String endpoint,
    required Map<String, dynamic> payload,
  }) async {
    try {
      Uri uri = Uri.parse(endpoint);
      debugPrint('POST: $uri');
      debugPrint('Payload: $payload');

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(payload),
      );

      debugPrint('Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body); // ✅ Decode here
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('HttpService Error: $e');
      return {"error": e.toString()};
    }
  }
}
