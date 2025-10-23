import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/core.dart';
import '/features/auth/data/data.dart';

abstract class AuthLocalDatasource {
  /// Crear usuario invitado en SQLite
  Future<UserModel> createGuestUser(String name);

  /// Obtener usuario por ID desde SQLite
  Future<UserModel?> getUserById(String userId);

  /// Obtener usuario actual desde SharedPreferences + SQLite
  Future<UserModel?> getCurrentUser();

  /// Guardar usuario en SQLite
  Future<void> saveUser(UserModel user);

  /// Actualizar usuario en SQLite
  Future<void> updateUser(UserModel user);

  /// Guardar ID de usuario actual en SharedPreferences
  Future<void> saveCurrentUserId(String userId);

  /// Obtener ID de usuario actual desde SharedPreferences
  Future<String?> getCurrentUserId();

  /// Guardar token de invitado en SharedPreferences
  Future<void> saveGuestToken(String token);

  /// Obtener token de invitado desde SharedPreferences
  Future<String?> getGuestToken();

  /// Limpiar sesión (logout)
  Future<void> clearSession();

  /// Verificar si hay sesión activa
  Future<bool> hasActiveSession();

  /// Obtener acceso a la base de datos
  Future<Database> get database;
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final AppDatabase _database;
  final SharedPreferences _prefs;
  final Uuid _uuid;

  AuthLocalDatasourceImpl({
    required AppDatabase database,
    required SharedPreferences prefs,
    Uuid? uuid,
  }) : _database = database,
       _prefs = prefs,
       _uuid = uuid ?? const Uuid();

  @override
  Future<Database> get database async => await _database.database;

  @override
  Future<UserModel> createGuestUser(String name) async {
    try {
      final db = await _database.database;

      // Generar ID único y token
      final userId = _uuid.v4();
      final guestToken = _uuid.v4();
      final now = DateTime.now().toIso8601String();

      final user = UserModel(
        id: userId,
        name: name,
        isGuest: true,
        guestToken: guestToken,
        createdAt: now,
        updatedAt: now,
        synced: false,
      );

      // Guardar en SQLite
      await db.insert(
        'users',
        user.toSQLite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Guardar en SharedPreferences
      await saveCurrentUserId(userId);
      await saveGuestToken(guestToken);
      await _prefs.setBool(StorageKeys.isGuest, true);

      if (kDebugMode) {
        print('Usuario invitado creado: $userId');
      }

      return user;
    } catch (e) {
      if (kDebugMode) {
        print('Error al crear usuario invitado: $e');
      }
      throw CacheException('Error al crear usuario invitado: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getUserById(String userId) async {
    try {
      final db = await _database.database;

      final results = await db.query(
        'users',
        where: 'id = ?',
        whereArgs: [userId],
        limit: 1,
      );

      if (results.isEmpty) {
        return null;
      }

      return UserModel.fromSQLite(results.first);
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener usuario: $e');
      }
      throw CacheException('Error al obtener usuario: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final userId = await getCurrentUserId();

      if (userId == null) {
        return null;
      }

      return await getUserById(userId);
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener usuario actual: $e');
      }
      throw CacheException('Error al obtener usuario actual: ${e.toString()}');
    }
  }

  @override
  Future<void> saveUser(UserModel user) async {
    try {
      final db = await _database.database;

      await db.insert(
        'users',
        user.toSQLite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await saveCurrentUserId(user.id);

      if (kDebugMode) {
        print('Usuario guardado: ${user.id}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al guardar usuario: $e');
      }
      throw CacheException('Error al guardar usuario: ${e.toString()}');
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    try {
      final db = await _database.database;

      final updatedUser = user.copyWith(
        updatedAt: DateTime.now().toIso8601String(),
      );

      await db.update(
        'users',
        updatedUser.toSQLite(),
        where: 'id = ?',
        whereArgs: [user.id],
      );

      if (kDebugMode) {
        print('Usuario actualizado: ${user.id}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al actualizar usuario: $e');
      }
      throw CacheException('Error al actualizar usuario: ${e.toString()}');
    }
  }

  @override
  Future<void> saveCurrentUserId(String userId) async {
    await _prefs.setString(StorageKeys.currentUserId, userId);
  }

  @override
  Future<String?> getCurrentUserId() async {
    return _prefs.getString(StorageKeys.currentUserId);
  }

  @override
  Future<void> saveGuestToken(String token) async {
    await _prefs.setString(StorageKeys.guestToken, token);
  }

  @override
  Future<String?> getGuestToken() async {
    return _prefs.getString(StorageKeys.guestToken);
  }

  @override
  Future<void> clearSession() async {
    await _prefs.remove(StorageKeys.currentUserId);
    await _prefs.remove(StorageKeys.guestToken);
    await _prefs.remove(StorageKeys.isGuest);
    await _prefs.remove(StorageKeys.userEmail);

    if (kDebugMode) {
      print('Sesión limpiada');
    }
  }

  @override
  Future<bool> hasActiveSession() async {
    final userId = await getCurrentUserId();
    return userId != null;
  }
}
