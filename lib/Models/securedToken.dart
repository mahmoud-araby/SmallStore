import '../config.dart';

SecuredToken securedToken;

class SecuredToken {
  String _email;
  String _idToken;

  SecuredToken.fromJson(Map<String, dynamic> response) {
    _idToken = response['idToken'];
    _email = response['email'];
  }

  String getToken() {
    return tokenSecure + _idToken;
  }
}
