import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/customer_model.dart';
import '../../../../core/config.dart';

class CustomerService {
  static Future<List<CustomerModel>> getAll() async {
    print('GET ALL CUSTOMER DIPANGGIL');
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/pelanggan'),
      headers: {'Accept': 'application/json'},
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    final body = jsonDecode(response.body);

    return (body['data'] as List)
        .map((e) => CustomerModel.fromJson(e))
        .toList();
  }

  static Future<Map<String, dynamic>> getDetail(int id) async {
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/pelanggan/$id'),
    );

    return jsonDecode(response.body)['data'];
  }

  static Future<List<CustomerModel>> getByDistrik(int idDistrik) async {
    print('GET DISTRIK CUSTOMER DIPANGGIL');
    final response = await http.get(
      Uri.parse('${Config.baseUrl}/pelanggan?distrik=$idDistrik'),
      headers: {'Accept': 'application/json'},
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    final body = jsonDecode(response.body);

    return (body['data'] as List)
        .map((e) => CustomerModel.fromJson(e))
        .toList();
  }
}
