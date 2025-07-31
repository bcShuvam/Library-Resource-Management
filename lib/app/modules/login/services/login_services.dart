import 'package:flutter/foundation.dart';
import 'package:library_resource_management/app/modules/login/models/auth_model.dart';
import 'package:library_resource_management/app/modules/login/models/auth_response_model.dart';
import 'package:library_resource_management/core/http_service.dart';
import 'package:library_resource_management/core/end_points.dart';

class LoginServices {
  static Future<AuthResponseModel?> fetchLogin(AuthModel payload) async {
    try {
      final response = await HttpService.post(
        endpoint: EndPoints.auth,
        payload: payload.toJson(),
      );

      if (response != null && response is Map<String, dynamic>) {
        return AuthResponseModel.fromJson(response);
      } else {
        debugPrint('Invalid login response: $response');
        return null;
      }
    } catch (e) {
      debugPrint('LoginServices Error: $e');
      return null;
    }
  }
}
