import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageResponse {
  final String value;

  SecureStorageResponse({required this.value});
}

class SecureStorageUtils {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  //// General keys
  static const String token = 'token';

  static Future<void> writeFSS(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  static Future<SecureStorageResponse> readFSS(String key) async {
    String value = await _storage.read(key: key) ?? '';
    return SecureStorageResponse(value: value);
  }

  static Future<void> deleteFSS(String key) async {
    await _storage.delete(key: key);
  }
}