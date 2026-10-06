import 'package:flutter/material.dart';
import 'package:portfolio/core/init/service/firebase_service.dart';

class ContactFormViewModel extends ChangeNotifier {
  // Keep in sync with firestore.rules.
  static const maxNameLength = 100;
  static const maxEmailLength = 200;
  static const maxSubjectLength = 150;
  static const maxMessageLength = 5000;

  final formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _subject = '';
  String _message = '';
  bool _isSending = false;
  bool _formSubmitted = false;
  String? _errorMessage;
  final IFirebaseService _firebaseService;

  ContactFormViewModel({IFirebaseService? firebaseService}) : _firebaseService = firebaseService ?? FirebaseService();

  // Getterlar
  String get name => _name;
  String get email => _email;
  String get subject => _subject;
  String get message => _message;
  bool get isSending => _isSending;
  bool get formSubmitted => _formSubmitted;
  String? get errorMessage => _errorMessage;

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
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.length > maxNameLength) {
      return 'Name should be at most $maxNameLength characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }

    // Email formatı doğrulama
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    if (value.length > maxEmailLength) {
      return 'Email should be at most $maxEmailLength characters';
    }

    return null;
  }

  String? validateSubject(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a subject';
    }
    if (value.length > maxSubjectLength) {
      return 'Subject should be at most $maxSubjectLength characters';
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your message';
    }
    if (value.trim().length < 10) {
      return 'Message should be at least 10 characters';
    }
    if (value.length > maxMessageLength) {
      return 'Message should be at most $maxMessageLength characters';
    }
    return null;
  }

  // Form gönderme işlemi
  Future<bool> submitForm() async {
    if (!(formKey.currentState?.validate() ?? false)) return false;
    formKey.currentState?.save();

    _isSending = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _firebaseService.sendContactMessage(
        name: _name.trim(),
        email: _email.trim(),
        subject: _subject.trim(),
        message: _message.trim(),
      );
      _formSubmitted = true;
    } catch (_) {
      _errorMessage = 'Your message could not be sent. Please try again in a moment.';
    } finally {
      _isSending = false;
      notifyListeners();
    }
    return _formSubmitted;
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
