import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class IFirebaseService {
  Future<void> initialize();
  Future<void> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  });
}

class FirebaseService extends IFirebaseService {
  static FirebaseService? _instance;

  FirebaseService._internal();
  factory FirebaseService() {
    _instance ??= FirebaseService._internal();
    return _instance!;
  }

  Future<FirebaseApp>? _app;

  @override
  Future<void> initialize() => _app ??= Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyA7NHbZIK-NHEed6SA0NP6dIboMUlx8L_c",
          authDomain: "portfolio-9e0f3.firebaseapp.com",
          projectId: "portfolio-9e0f3",
          storageBucket: "portfolio-9e0f3.appspot.com",
          messagingSenderId: "558468121651",
          appId: "1:558468121651:web:7a0f5d555b3f661864cf46",
          measurementId: "G-FN8X2ENSK2",
        ),
      );

  /// Writes to the `messages` collection. firestore.rules only allows
  /// creating documents with exactly these fields, so nothing can be read back.
  @override
  Future<void> sendContactMessage({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    await initialize();
    await FirebaseFirestore.instance.collection('messages').add({
      'name': name,
      'email': email,
      'subject': subject,
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    }).timeout(const Duration(seconds: 15));
  }
}
