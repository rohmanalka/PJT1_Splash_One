import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config.dart';

class HistoryService {
  static Future<List<dynamic>> getToday() async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/history/daily'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['data'];
    } else {
      throw Exception('Gagal memuat history');
    }
  }
}
