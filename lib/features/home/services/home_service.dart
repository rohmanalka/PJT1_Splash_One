import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config.dart';

class HomeService {
  static Future<Map<String, dynamic>> getDashboard() async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/home'),
      headers: {'Accept': 'application/json'},
    );

    return jsonDecode(response.body)['data'];
  }
}
