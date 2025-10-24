import 'package:flutter/foundation.dart';
import '/core/core.dart';
import '/features/pokemon/data/data.dart';

abstract class PokemonLocalDatasource {
  /// Obtener todos los pokémon favoritos de un usuario
  Future<List<PokemonModel>> getFavoritePokemon(String userId);

  /// Obtener un pokémon favorito por ID
  Future<PokemonModel?> getFavoritePokemonById(int id, String userId);

  /// Verificar si un pokémon es favorito
  Future<bool> isFavorite(int pokemonId, String userId);

  /// Agregar pokémon a favoritos
  Future<void> addToFavorites(PokemonModel pokemon, String userId);

  /// Eliminar pokémon de favoritos
  Future<void> removeFromFavorites(int pokemonId, String userId);

  /// Limpiar todos los favoritos de un usuario
  Future<void> clearAllFavorites(String userId);

  /// Obtener conteo de favoritos
  Future<int> getFavoritesCount(String userId);
}

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  final AppDatabase _database;

  PokemonLocalDatasourceImpl({required AppDatabase database})
    : _database = database;

  @override
  Future<List<PokemonModel>> getFavoritePokemon(String userId) async {
    try {
      final db = await _database.database;

      final results = await db.query(
        'favorite_pokemon',
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'added_at DESC',
      );

      return results.map((map) => PokemonModel.fromSQLite(map)).toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener pokémon favoritos: $e');
      }
      throw CacheException(
        'Error al obtener pokémon favoritos: ${e.toString()}',
      );
    }
  }

  @override
  Future<PokemonModel?> getFavoritePokemonById(int id, String userId) async {
    try {
      final db = await _database.database;

      final results = await db.query(
        'favorite_pokemon',
        where: 'id = ? AND user_id = ?',
        whereArgs: [id, userId],
        limit: 1,
      );

      if (results.isEmpty) return null;

      return PokemonModel.fromSQLite(results.first);
    } catch (e) {
      if (kDebugMode) {
        print('Error al obtener pokémon favorito por ID: $e');
      }
      throw CacheException(
        'Error al obtener pokémon favorito: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> isFavorite(int pokemonId, String userId) async {
    try {
      final db = await _database.database;

      final results = await db.query(
        'favorite_pokemon',
        where: 'id = ? AND user_id = ?',
        whereArgs: [pokemonId, userId],
        limit: 1,
      );

      return results.isNotEmpty;
    } catch (e) {
      if (kDebugMode) {
        print('Error al verificar favorito: $e');
      }
      return false;
    }
  }

  @override
  Future<void> addToFavorites(PokemonModel pokemon, String userId) async {
    try {
      final db = await _database.database;

      // Verificar si ya existe
      final exists = await isFavorite(pokemon.id, userId);
      if (exists) {
        if (kDebugMode) {
          print('Pokémon ya está en favoritos');
        }
        return;
      }

      await db.insert('favorite_pokemon', pokemon.toSQLite(userId));

      if (kDebugMode) {
        print('Pokémon agregado a favoritos: ${pokemon.name}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al agregar a favoritos: $e');
      }
      throw CacheException('Error al agregar a favoritos: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFromFavorites(int pokemonId, String userId) async {
    try {
      final db = await _database.database;

      final deletedRows = await db.delete(
        'favorite_pokemon',
        where: 'id = ? AND user_id = ?',
        whereArgs: [pokemonId, userId],
      );

      if (kDebugMode) {
        print('Pokémon eliminado de favoritos (rows: $deletedRows)');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al eliminar de favoritos: $e');
      }
      throw CacheException('Error al eliminar de favoritos: ${e.toString()}');
    }
  }

  @override
  Future<void> clearAllFavorites(String userId) async {
    try {
      final db = await _database.database;

      final deletedRows = await db.delete(
        'favorite_pokemon',
        where: 'user_id = ?',
        whereArgs: [userId],
      );

      if (kDebugMode) {
        print('Favoritos limpiados (rows: $deletedRows)');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al limpiar favoritos: $e');
      }
      throw CacheException('Error al limpiar favoritos: ${e.toString()}');
    }
  }

  @override
  Future<int> getFavoritesCount(String userId) async {
    try {
      final db = await _database.database;

      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM favorite_pokemon WHERE user_id = ?',
        [userId],
      );

      return result.first['count'] as int;
    } catch (e) {
      if (kDebugMode) {
        print('Error al contar favoritos: $e');
      }
      return 0;
    }
  }
}
