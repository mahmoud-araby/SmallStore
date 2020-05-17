import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class SecuredToken extends Model {
  SharedPreferences _sharedPreferences;

  String _email;
  String _idToken;
  bool isUserLogged = false;

  SecuredToken() {
    _getData();
  }

  String getToken() {
    return tokenSecure + _idToken;
  }

  _storeData() async {
    _sharedPreferences.setStringList("Token", [_idToken, _email]);
    print(_idToken);
  }

  _getData() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    List<String> restoredData = _sharedPreferences.getStringList("Token");
    if (restoredData != null) {
      isUserLogged = true;
      notifyListeners();
      _idToken = restoredData[0];
      _email = restoredData[1];
      print(_idToken);
    }
  }

  updateToken(Map<String, dynamic> response) {
    _idToken = response['idToken'];
    _email = response['email'];
    _storeData();
  }

  deleteToken() {
    _sharedPreferences.remove("Token");
  }
}
