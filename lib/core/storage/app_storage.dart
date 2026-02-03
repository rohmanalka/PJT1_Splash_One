import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveLogin({
    required String token,
    required int userId,
  }) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'user_id', value: userId.toString());
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
