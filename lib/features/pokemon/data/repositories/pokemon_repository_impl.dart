import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '/core/core.dart';
import '/features/pokemon/data/data.dart';
import '/features/pokemon/domain/domain.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonLocalDatasource _localDatasource;
  final PokemonRemoteDatasource _remoteDatasource;

  PokemonRepositoryImpl({
    required PokemonLocalDatasource localDatasource,
    required PokemonRemoteDatasource remoteDatasource,
  }) : _localDatasource = localDatasource,
       _remoteDatasource = remoteDatasource;

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemonList({
    required int limit,
    required int offset,
    required String userId,
  }) async {
    try {
      final pokemonModels = await _remoteDatasource.getPokemonList(
        limit: limit,
        offset: offset,
      );

      // Verificar cuáles son favoritos
      final pokemonWithFavorites = await Future.wait(
        pokemonModels.map((model) async {
          final isFav = await _localDatasource.isFavorite(model.id, userId);
          return model.copyWith(isFavorite: isFav);
        }),
      );

      final entities = pokemonWithFavorites.map((m) => m.toEntity()).toList();

      return Right(entities);
    } on ServerException catch (e) {
      if (kDebugMode) {
        print('ServerException: ${e.message}');
      }
      return Left(ServerFailure());
    } on CacheException catch (e) {
      if (kDebugMode) {
        print('CacheException: ${e.message}');
      }
      return Left(CacheFailure());
    } catch (e) {
      if (kDebugMode) {
        print('Error desconocido: $e');
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Pokemon>> getPokemonById({
    required int id,
    required String userId,
  }) async {
    try {
      final pokemonModel = await _remoteDatasource.getPokemonById(id);
      final isFav = await _localDatasource.isFavorite(id, userId);
      final modelWithFavorite = pokemonModel.copyWith(isFavorite: isFav);

      return Right(modelWithFavorite.toEntity());
    } on ServerException catch (e) {
      if (kDebugMode) {
        print('ServerException: ${e.message}');
      }
      return Left(ServerFailure());
    } on CacheException catch (e) {
      if (kDebugMode) {
        print('CacheException: ${e.message}');
      }
      return Left(CacheFailure());
    } catch (e) {
      if (kDebugMode) {
        print('Error desconocido: $e');
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> searchPokemon({
    required String query,
    required String userId,
  }) async {
    try {
      final pokemonModels = await _remoteDatasource.searchPokemon(query);

      // Verificar cuáles son favoritos
      final pokemonWithFavorites = await Future.wait(
        pokemonModels.map((model) async {
          final isFav = await _localDatasource.isFavorite(model.id, userId);
          return model.copyWith(isFavorite: isFav);
        }),
      );

      final entities = pokemonWithFavorites.map((m) => m.toEntity()).toList();

      return Right(entities);
    } on ServerException catch (e) {
      if (kDebugMode) {
        print('ServerException: ${e.message}');
      }
      return Left(ServerFailure());
    } on CacheException catch (e) {
      if (kDebugMode) {
        print('CacheException: ${e.message}');
      }
      return Left(CacheFailure());
    } catch (e) {
      if (kDebugMode) {
        print('Error desconocido: $e');
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pokemon>>> getFavoritePokemon(
    String userId,
  ) async {
    try {
      final pokemonModels = await _localDatasource.getFavoritePokemon(userId);
      final entities = pokemonModels.map((m) => m.toEntity()).toList();

      return Right(entities);
    } on CacheException catch (e) {
      if (kDebugMode) {
        print('CacheException: ${e.message}');
      }
      return Left(CacheFailure());
    } catch (e) {
      if (kDebugMode) {
        print('Error desconocido: $e');
      }
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite({
    required int pokemonId,
    required String userId,
  }) async {
    try {
      final isFav = await _localDatasource.isFavorite(pokemonId, userId);
      return Right(isFav);
    } on CacheException catch (e) {
      if (kDebugMode) {
        print('CacheException: ${e.message}');
      }
      return Left(CacheFailure());
    } catch (e) {
      if (kDebugMode) {
        print('Error desconocido: $e');
      }
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addToFavorites({
    required Pokemon pokemon,
    required String userId,
  }) async {
    try {
      final model = PokemonModel.fromEntity(pokemon);
      await _localDatasource.addToFavorites(model, userId);
      return const Right(unit);
    } on CacheException catch (e) {
      if (kDebugMode) {
        print('CacheException: ${e.message}');
      }
      return Left(CacheFailure());
    } catch (e) {
      if (kDebugMode) {
        print('Error desconocido: $e');
      }
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromFavorites({
    required int pokemonId,
    required String userId,
  }) async {
    try {
      await _localDatasource.removeFromFavorites(pokemonId, userId);
      return const Right(unit);
    } on CacheException catch (e) {
      if (kDebugMode) {
        print('CacheException: ${e.message}');
      }
      return Left(CacheFailure());
    } catch (e) {
      if (kDebugMode) {
        print('Error desconocido: $e');
      }
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> getFavoritesCount(String userId) async {
    try {
      final count = await _localDatasource.getFavoritesCount(userId);
      return Right(count);
    } on CacheException catch (e) {
      if (kDebugMode) {
        print('CacheException: ${e.message}');
      }
      return Left(CacheFailure());
    } catch (e) {
      if (kDebugMode) {
        print('Error desconocido: $e');
      }
      return Left(CacheFailure());
    }
  }
}
