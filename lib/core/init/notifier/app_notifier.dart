import 'package:flutter/material.dart';

class AppNotifier extends ChangeNotifier {
  bool _isHover = false;
  bool get isHover => _isHover;

  void setHover(bool value) {
    if (_isHover == value) return;
    _isHover = value;
    notifyListeners();
  }
}
