import 'package:flutter/material.dart';

class ContactFormViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _subject = '';
  String _message = '';
  bool _isSending = false;
  bool _formSubmitted = false;

  // Getterlar
  String get name => _name;
  String get email => _email;
  String get subject => _subject;
  String get message => _message;
  bool get isSending => _isSending;
  bool get formSubmitted => _formSubmitted;

  // Setterlar
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set subject(String value) {
    _subject = value;
    notifyListeners();
  }

  set message(String value) {
    _message = value;
    notifyListeners();
  }

  // Form doğrulama metodları
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    // Email formatı doğrulama
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  String? validateSubject(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a subject';
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your message';
    }
    if (value.length < 10) {
      return 'Message should be at least 10 characters';
    }
    return null;
  }

  // Form gönderme işlemi
  Future<bool> submitForm() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      _isSending = true;
      notifyListeners();

      // API çağrısı veya email gönderme işlemi burada yapılacak
      // Şimdilik bir gecikme simüle edelim
      await Future.delayed(const Duration(seconds: 2));

      _isSending = false;
      _formSubmitted = true;
      notifyListeners();

      return true;
    }
    return false;
  }

  void resetForm() {
    _name = '';
    _email = '';
    _subject = '';
    _message = '';
    _formSubmitted = false;
    notifyListeners();
  }
}
