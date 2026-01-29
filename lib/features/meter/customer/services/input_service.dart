import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/config.dart';

class InputService {
  static Future<String?> submitBacaMeter({
    required int idPelanggan,
    required DateTime bulan,
    required int volume,
    required String photoPath,
  }) async {
    final uri = Uri.parse('${Config.baseUrl}/input');

    final request = http.MultipartRequest('POST', uri)
      ..headers['Accept'] = 'application/json'
      ..fields['id_pelanggan'] = idPelanggan.toString()
      ..fields['bulan'] =
          '${bulan.year}-${bulan.month.toString().padLeft(2, '0')}-01'
      ..fields['volume'] = volume.toString()
      ..files.add(await http.MultipartFile.fromPath('foto', photoPath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      return null;
    }

    if (response.body.isNotEmpty) {
      final json = jsonDecode(response.body);
      return json['message'] ?? 'Gagal menyimpan';
    }

    return 'Terjadi kesalahan';
  }
}
