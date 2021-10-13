import 'package:flutter/cupertino.dart';

class Login extends ChangeNotifier {
  bool _isLogin = true;

  bool get isLogin => _isLogin;

  set isLogin(bool newIsLogin) {
    _isLogin = newIsLogin;
    notifyListeners();
  }
}
