import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/config.dart';

class InputService {
  static Future<String?> submitBacaMeter({
    required int idPelanggan,
    required DateTime bulan,
    required int volume,
    required String photoPath,
  }) async {
    final uri = Uri.parse('${Config.baseUrl}/input');

    final request = http.MultipartRequest('POST', uri);

    request.fields['id_pelanggan'] = idPelanggan.toString();
    request.fields['bulan'] =
        '${bulan.year}-${bulan.month.toString().padLeft(2, '0')}-01';
    request.fields['volume'] = volume.toString();
    request.files.add(await http.MultipartFile.fromPath('foto', photoPath));

    final response = await request.send();
    final body = await response.stream.bytesToString();

    // debugPrint('STATUS: ${response.statusCode}');
    // debugPrint('BODY: $body');

    final json = body.isNotEmpty ? jsonDecode(body) : null;

    if (response.statusCode == 201) {
      return null;
    }

    return json?['message'] ?? 'Terjadi kesalahan';
  }
}
