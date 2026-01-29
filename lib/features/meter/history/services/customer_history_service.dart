import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config.dart';
import '../models/customer_history_model.dart';

class CustomerHistoryService {
  static Future<List<CustomerHistoryModel>> fetchHistory(
    int idPelanggan,
  ) async {
    final uri = Uri.parse('${Config.baseUrl}/history/customer/$idPelanggan');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat riwayat');
    }

    final json = jsonDecode(response.body);
    return (json['data'] as List)
        .map((e) => CustomerHistoryModel.fromJson(e))
        .toList();
  }

  static Future<CustomerHistoryModel> fetchDetail(
    int idPelanggan,
    String bulan,
  ) async {
    final uri = Uri.parse(
      '${Config.baseUrl}/history/customer/$idPelanggan/$bulan',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat detail');
    }

    final json = jsonDecode(response.body);
    return CustomerHistoryModel.fromJson(json['data']);
  }
}
