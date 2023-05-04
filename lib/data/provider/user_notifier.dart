import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  dynamic userData;

  updateUserData(dynamic _userData) {
    userData = _userData;
    notifyListeners();
  }
}
