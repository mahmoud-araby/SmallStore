mixin Validators {
  String emailValidator(String value) {
    if (value.contains('@')) {
      return null;
    }
    return 'Enter valid Email';
  }

  String passwordValidator(String value) {
    if (value.length > 6) {
      return null;
    }
    return 'Password Should be 6 char long';
  }
}
