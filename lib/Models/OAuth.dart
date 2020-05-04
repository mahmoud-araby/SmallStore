import 'package:flutter/cupertino.dart';

class OAuth {
  OAuth({@required this.email, @required this.password, this.acceptTerms});
  String email;
  String password;
  bool acceptTerms = false;
}
