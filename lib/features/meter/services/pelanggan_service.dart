import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/pelanggan_model.dart';

class PelangganService {
  static const baseUrl = 'http://10.10.16.242:8000/api';

  static Future<List<PelangganModel>> getAll() async {
    final response = await http.get(
      Uri.parse('$baseUrl/pelanggan'),
      headers: {'Accept': 'application/json'},
    );

    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('BODY: ${response.body}');

    final body = jsonDecode(response.body);

    return (body['data'] as List)
        .map((e) => PelangganModel.fromJson(e))
        .toList();
  }

  static Future<Map<String, dynamic>> getDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/pelanggan/$id'));

    return jsonDecode(response.body)['data'];
  }
}
