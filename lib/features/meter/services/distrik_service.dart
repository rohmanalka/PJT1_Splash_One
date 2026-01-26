import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/distrik_model.dart';
import '../../../core/config.dart';

class DistrikService {
  static Future<List<DistrikModel>> getDistrik({int? parentId}) async {
    final uri = parentId == null
        ? Uri.parse('${Config.baseUrl}/distrik-petugas')
        : Uri.parse('${Config.baseUrl}/distrik-petugas?parent_id=$parentId');

    final response = await http.get(uri);

    debugPrint('STATUS: ${response.statusCode}');
    debugPrint('BODY: ${response.body}');

    final body = jsonDecode(response.body);

    return (body['data'] as List).map((e) => DistrikModel.fromJson(e)).toList();
  }
}
