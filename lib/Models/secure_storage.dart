import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:googleapis_auth/auth.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();

  Future saveCredentials(AccessToken token, String refershToken) async {
    await storage.write(key: 'type', value: token.type);
    await storage.write(key: 'data', value: token.data);
    await storage.write(key: 'expiry', value: token.expiry.toIso8601String());
    await storage.write(key: 'refreshToken', value: refershToken);
  }

  Future<Map<String, dynamic>> getCredentials() async {
    final result = await storage.readAll();
    if (result.length == 0) return null;
    return result;
  }

  Future clearStorage() {
    return storage.deleteAll();
  }
}
