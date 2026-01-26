import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pelanggan_model.dart';
import '../../../core/config.dart';

class PelangganService {
  static Future<List<PelangganModel>> getAll() async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/pelanggan'),
      headers: {'Accept': 'application/json'},
    );

    // debugPrint('STATUS: ${response.statusCode}');
    // debugPrint('BODY: ${response.body}');

    final body = jsonDecode(response.body);

    return (body['data'] as List)
        .map((e) => PelangganModel.fromJson(e))
        .toList();
  }

  static Future<Map<String, dynamic>> getDetail(int id) async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/pelanggan/$id'),
    );

    return jsonDecode(response.body)['data'];
  }

  static Future<List<PelangganModel>> getByDistrik(int idDistrik) async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/pelanggan?distrik=$idDistrik'),
      headers: {'Accept': 'application/json'},
    );

    final body = jsonDecode(response.body);

    return (body['data'] as List)
        .map((e) => PelangganModel.fromJson(e))
        .toList();
  }
}
