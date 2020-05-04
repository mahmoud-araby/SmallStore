import 'package:scoped_model/scoped_model.dart';

import 'OAuth.dart';

enum OAuthType { login, signUp }

class OAuthModel extends Model {
  OAuth user = OAuth();
  OAuthType oAuthType = OAuthType.login;

  oAuthenticate() {}
}
