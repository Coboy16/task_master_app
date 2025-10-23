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
        id: _uuid.v4(),
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
      throw AuthException(FirebaseError.getAuthErrorMessage(e.code), e.code);
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
      // 1. Crear usuario en Firebase Auth
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw AuthException('No se pudo crear el usuario en Firebase');
      }

      final now = DateTime.now();

      // 2. Crear documento del usuario en Firestore
      final userData = {
        'name': name,
        'email': email,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      };

      await _firestore.collection('users').doc(firebaseUser.uid).set(userData);

      // 3. Crear tarea de bienvenida
      await _createWelcomeTask(firebaseUser.uid);

      if (kDebugMode) {
        print('Usuario registrado exitosamente: ${firebaseUser.uid}');
      }

      // 4. Retornar modelo de usuario
      return UserModel(
        id: _uuid.v4(),
        email: email,
        name: name,
        isGuest: false,
        firebaseUid: firebaseUser.uid,
        createdAt: now.toIso8601String(),
        updatedAt: now.toIso8601String(),
        synced: true,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Firebase Auth Error: ${e.code} - ${e.message}');
      }
      throw AuthException(e.message ?? 'Error al crear la cuenta');
    } catch (e) {
      if (kDebugMode) {
        print('Error al registrar usuario: $e');
      }
      throw AuthException('Error al registrar usuario: ${e.toString()}');
    }
  }

  Future<void> _createWelcomeTask(String firebaseUserId) async {
    try {
      final now = DateTime.now();
      final taskId = _uuid.v4();

      final welcomeTask = {
        'id': taskId,
        'title': '¡Bienvenido a TaskMaster Pro!',
        'description':
            'Esta es tu primera tarea. Puedes editarla o eliminarla cuando quieras. ¡Empieza a organizar tus tareas ahora!',
        'isCompleted': false,
        'priority': 'media',
        'source': 'firebase',
        'userId': firebaseUserId,
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
        'deleted': false,
      };

      await _firestore.collection('tasks').doc(taskId).set(welcomeTask);

      if (kDebugMode) {
        print('Tarea de bienvenida creada: $taskId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al crear tarea de bienvenida: $e');
      }
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
}
