import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';

class FirebaseInitializer {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      if (kDebugMode) {
        print('✅ Firebase inicializado correctamente');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error al inicializar Firebase: $e');
      }
      rethrow;
    }
  }
}
