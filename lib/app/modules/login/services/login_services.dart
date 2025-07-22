import 'package:http/http.dart' as http;

class LoginServices{
  void fetchLogin({required String path, required Map<String, dynamic> payload}) async {
    final response = await http.post(Uri.parse(''));
  }
}