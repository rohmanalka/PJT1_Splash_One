import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config.dart';
import '../../../core/storage/app_storage.dart';

class AuthService {
  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('${Config.baseUrl}/login'),
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'password': password},
    );

    if (response.statusCode != 200) return false;

    final data = jsonDecode(response.body);

    await AppStorage.saveLogin(
      token: data['token'],
      userId: data['user']['id'],
    );

    return true;
  }
}
