import 'package:dartz/dartz.dart';
import '/core/core.dart';
import '/features/pokemon/domain/domain.dart';

abstract class PokemonRepository {
  /// Obtener lista de pokémon con paginación
  Future<Either<Failure, List<Pokemon>>> getPokemonList({
    required int limit,
    required int offset,
    required String userId,
  });

  /// Obtener detalle de un pokémon por ID
  Future<Either<Failure, Pokemon>> getPokemonById({
    required int id,
    required String userId,
  });

  /// Buscar pokémon por nombre
  Future<Either<Failure, List<Pokemon>>> searchPokemon({
    required String query,
    required String userId,
  });

  /// Obtener pokémon favoritos del usuario
  Future<Either<Failure, List<Pokemon>>> getFavoritePokemon(String userId);

  /// Verificar si un pokémon es favorito
  Future<Either<Failure, bool>> isFavorite({
    required int pokemonId,
    required String userId,
  });

  /// Agregar pokémon a favoritos
  Future<Either<Failure, Unit>> addToFavorites({
    required Pokemon pokemon,
    required String userId,
  });

  /// Eliminar pokémon de favoritos
  Future<Either<Failure, Unit>> removeFromFavorites({
    required int pokemonId,
    required String userId,
  });

  /// Obtener conteo de favoritos
  Future<Either<Failure, int>> getFavoritesCount(String userId);
}
