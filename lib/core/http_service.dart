import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:library_resource_management/app/utils/snackbar_utils.dart';
import '../app/utils/secure_storage_utils.dart';

class HttpService {
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };

  // 🔐 Retrieve token from secure storage
  static Future<String> getToken() async {
    SecureStorageResponse storedToken = await SecureStorageUtils.readFSS(
      SecureStorageUtils.token,
    );
    debugPrint('Stored Token: ${storedToken.value}');
    return storedToken.value;
  }

  // 🧱 Build headers with Authorization
  static Future<Map<String, String>> buildHeaders() async {
    final token = await getToken();
    final Map<String, String> headers = Map.from(defaultHeaders);
    if (token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // 📥 POST request
  static Future<dynamic> post({
    required String endpoint,
    required Map<String, dynamic> payload,
    BuildContext? context,
  }) async {
    try {
      debugPrint(endpoint);
      debugPrint('payload: $payload');
      final headers = await buildHeaders();
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(payload),
      );
      return _handleResponse(response, context);
    } catch (e) {
      debugPrint('POST Error: $e');
      return {"error": e.toString()};
    }
  }

  static Future<dynamic> postFilesRequest({
    required String endpoint,
    required Map<String, dynamic> payload,
    BuildContext? context,
    String name = '',
    File? selectedImage,
  }) async {
    try {
      debugPrint(endpoint);
      debugPrint('payload: $payload');
      final headers = await buildHeaders();
      print(headers);
      final request = http.MultipartRequest('POST', Uri.parse(endpoint));

      // Add fields
      payload.forEach((key, value) {
        request.fields[key] = value;
      });

      // Only add file if imagePath is not empty
      if (selectedImage != null && selectedImage.path.isNotEmpty) {
        request.files.add(
          await http.MultipartFile.fromPath(
            name,
            selectedImage.path,
            filename: selectedImage.path,
          ),
        );
      }

      request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response, context);
    } catch (e) {
      debugPrint('POST Error: $e');
      return {"error": e.toString()};
    }
  }

  // 📤 PUT request
  static Future<dynamic> put({
    required String endpoint,
    required Map<String, dynamic> payload,
    BuildContext? context,
  }) async {
    try {
      debugPrint(endpoint);
      debugPrint('payload: $payload');
      final headers = await buildHeaders();
      final response = await http.put(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(payload),
      );
      return _handleResponse(response, context);
    } catch (e) {
      debugPrint('PUT Error: $e');
      return {"error": e.toString()};
    }
  }

  // 🛠 PATCH request
  static Future<dynamic> patch({
    required String endpoint,
    required Map<String, dynamic> payload,
    BuildContext? context,
  }) async {
    try {
      debugPrint(endpoint);
      debugPrint('payload: $payload');
      final headers = await buildHeaders();
      final response = await http.patch(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(payload),
      );
      return _handleResponse(response, context);
    } catch (e) {
      debugPrint('PATCH Error: $e');
      return {"error": e.toString()};
    }
  }

  // 🗑 DELETE request
  static Future<dynamic> delete({
    required String endpoint,
    BuildContext? context,
  }) async {
    try {
      debugPrint(endpoint);
      final headers = await buildHeaders();
      final response = await http.delete(Uri.parse(endpoint), headers: headers);
      return _handleResponse(response, context);
    } catch (e) {
      debugPrint('DELETE Error: $e');
      return {"error": e.toString()};
    }
  }

  // 📥 GET request
  static Future<dynamic> get({
    required String endpoint,
    BuildContext? context,
  }) async {
    try {
      debugPrint(endpoint);
      final headers = await buildHeaders();
      final response = await http.get(Uri.parse(endpoint), headers: headers);
      return _handleResponse(response, context);
    } catch (e) {
      debugPrint('GET Error: $e');
      return {"error": e.toString()};
    }
  }

  // 🔁 Common response handler
  static Future<dynamic> _handleResponse(
    http.Response response,
    BuildContext? context,
  ) async {
    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    if (response.statusCode == 403) {
      if (context != null) {
        SnackBarUtils.showErrorSnackbar(
          context,
          message: "Session expired, please log in again",
        );
        // TODO: Implement logout and redirect logic
      }
      return {"error": jsonDecode(response.body)['message']};
    }

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      debugPrint("Request failed with status: ${response.statusCode}");
      return {
        "error": "Request failed",
        "status": response.statusCode,
        "body": response.body,
      };
    }
  }
}
