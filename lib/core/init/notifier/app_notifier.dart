import 'package:flutter/material.dart';

class AppNotifier extends ChangeNotifier {
  bool _isHover = false;
  bool get isHover => _isHover;

  void toggleHover() {
    _isHover = !_isHover;
    notifyListeners();
  }
}
