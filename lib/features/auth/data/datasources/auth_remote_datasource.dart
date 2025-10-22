import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '/core/core.dart';
import '/features/auth/data/data.dart';

abstract class AuthRemoteDatasource {
  /// Login con Firebase Auth
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });

  /// Registro con Firebase Auth
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String name,
  });

  /// Obtener usuario desde Firestore
  Future<UserModel?> getUserFromFirestore(String firebaseUid);

  /// Guardar usuario en Firestore
  Future<void> saveUserToFirestore(UserModel user);

  /// Actualizar usuario en Firestore
  Future<void> updateUserInFirestore(UserModel user);

  /// Cerrar sesión en Firebase
  Future<void> logout();

  /// Obtener usuario actual de Firebase Auth
  firebase_auth.User? getCurrentFirebaseUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final Uuid _uuid;

  AuthRemoteDatasourceImpl({
    required firebase_auth.FirebaseAuth firebaseAuth,
    required FirebaseFirestore firestore,
    Uuid? uuid,
  }) : _firebaseAuth = firebaseAuth,
       _firestore = firestore,
       _uuid = uuid ?? const Uuid();

  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // Login en Firebase Auth
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw AuthException('No se pudo obtener el usuario de Firebase');
      }

      // Obtener datos desde Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!userDoc.exists) {
        throw AuthException('Usuario no encontrado en Firestore');
      }

      final data = userDoc.data()!;

      return UserModel(
        id: _uuid.v4(), // ID local único
        email: firebaseUser.email,
        name: data['name'] as String,
        isGuest: false,
        firebaseUid: firebaseUser.uid,
        createdAt: (data['createdAt'] as Timestamp).toDate().toIso8601String(),
        updatedAt: (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
        synced: true,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Error: ${e.code} - ${e.message}');
      }
      throw AuthException(_getAuthErrorMessage(e.code), e.code);
    } catch (e) {
      if (kDebugMode) {
        print('Error en login: $e');
      }
      throw AuthException('Error al iniciar sesión: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> registerWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Registrar en Firebase Auth
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw AuthException('No se pudo crear el usuario en Firebase');
      }

      final now = DateTime.now();

      // Crear modelo de usuario
      final user = UserModel(
        id: _uuid.v4(), // ID local único
        email: email,
        name: name,
        isGuest: false,
        firebaseUid: firebaseUser.uid,
        createdAt: now.toIso8601String(),
        updatedAt: now.toIso8601String(),
        synced: true,
      );

      // Guardar en Firestore
      await _firestore.collection('users').doc(firebaseUser.uid).set({
        'email': email,
        'name': name,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      });

      // Actualizar displayName en Firebase Auth
      await firebaseUser.updateDisplayName(name);

      if (kDebugMode) {
        print('Usuario registrado: ${firebaseUser.uid}');
      }

      return user;
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Error: ${e.code} - ${e.message}');
      }
      throw AuthException(_getAuthErrorMessage(e.code), e.code);
    } catch (e) {
      if (kDebugMode) {
        print('Error en registro: $e');
      }
      throw AuthException('Error al registrar usuario: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getUserFromFirestore(String firebaseUid) async {
    try {
      final userDoc = await _firestore
          .collection('users')
          .doc(firebaseUid)
          .get();

      if (!userDoc.exists) {
        return null;
      }

      final data = userDoc.data()!;

      return UserModel(
        id: _uuid.v4(),
        email: data['email'] as String?,
        name: data['name'] as String,
        isGuest: false,
        firebaseUid: firebaseUid,
        createdAt: (data['createdAt'] as Timestamp).toDate().toIso8601String(),
        updatedAt: (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
        synced: true,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener usuario de Firestore: $e');
      }
      throw ServerException('Error al obtener usuario: ${e.toString()}');
    }
  }

  @override
  Future<void> saveUserToFirestore(UserModel user) async {
    try {
      if (user.firebaseUid == null) {
        throw AuthException('Usuario no tiene firebaseUid');
      }

      await _firestore.collection('users').doc(user.firebaseUid).set({
        'email': user.email,
        'name': user.name,
        'createdAt': Timestamp.fromDate(DateTime.parse(user.createdAt)),
        'updatedAt': Timestamp.fromDate(DateTime.parse(user.updatedAt)),
      });

      if (kDebugMode) {
        print('Usuario guardado en Firestore: ${user.firebaseUid}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al guardar en Firestore: $e');
      }
      throw ServerException('Error al guardar usuario: ${e.toString()}');
    }
  }

  @override
  Future<void> updateUserInFirestore(UserModel user) async {
    try {
      if (user.firebaseUid == null) {
        throw AuthException('Usuario no tiene firebaseUid');
      }

      await _firestore.collection('users').doc(user.firebaseUid).update({
        'name': user.name,
        'updatedAt': Timestamp.fromDate(DateTime.parse(user.updatedAt)),
      });

      if (kDebugMode) {
        print('Usuario actualizado en Firestore: ${user.firebaseUid}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al actualizar en Firestore: $e');
      }
      throw ServerException('Error al actualizar usuario: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      if (kDebugMode) {
        print('Sesión cerrada en Firebase');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al cerrar sesión: $e');
      }
      throw AuthException('Error al cerrar sesión: ${e.toString()}');
    }
  }

  @override
  firebase_auth.User? getCurrentFirebaseUser() {
    return _firebaseAuth.currentUser;
  }

  // Helper para mensajes de error en español
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No existe una cuenta con este email';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'email-already-in-use':
        return 'Este email ya está registrado';
      case 'invalid-email':
        return 'Email inválido';
      case 'weak-password':
        return 'La contraseña es muy débil';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde';
      case 'network-request-failed':
        return 'Error de conexión. Verifica tu internet';
      default:
        return 'Error de autenticación';
    }
  }
}
