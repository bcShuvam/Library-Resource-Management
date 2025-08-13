import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:library_resource_management/app/modules/login/models/auth_model.dart';
import 'package:library_resource_management/app/modules/login/models/auth_response_model.dart';
import 'package:library_resource_management/app/utils/snackbar_utils.dart';
import 'package:library_resource_management/core/http_service.dart';
import 'package:library_resource_management/core/end_points.dart';

class LoginServices {
  static Future<AuthResponseModel?> fetchLogin({
    required AuthModel payload,
    BuildContext? context,
  }) async {
    try {
      final response = await HttpService.post(
        endpoint: EndPoints.auth,
        payload: payload.toJson(),
        context: context, // Pass context to handle 403/session expiry
      );

      if(response.containsKey('error')){
        SnackBarUtils.showErrorSnackbar(context!, message: response['error']);
      }
      if (response != null && response is Map<String, dynamic> && response.containsKey('token')) {
        return AuthResponseModel.fromJson(response);
      } else {
        debugPrint('Login failed or malformed response: $response');
        return null;
      }
    } catch (e) {
      debugPrint('LoginServices Error: $e');
      return null;
    }
  }
}
