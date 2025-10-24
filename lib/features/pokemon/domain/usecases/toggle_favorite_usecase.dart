import 'package:dartz/dartz.dart';
import '/core/core.dart';
import '/features/pokemon/domain/domain.dart';

class ToggleFavoriteUsecase {
  final PokemonRepository _repository;

  ToggleFavoriteUsecase(this._repository);

  Future<Either<Failure, bool>> call({
    required Pokemon pokemon,
    required String userId,
  }) async {
    final isFavoriteResult = await _repository.isFavorite(
      pokemonId: pokemon.id,
      userId: userId,
    );

    return isFavoriteResult.fold((failure) => Left(failure), (
      isFavorite,
    ) async {
      if (isFavorite) {
        final result = await _repository.removeFromFavorites(
          pokemonId: pokemon.id,
          userId: userId,
        );
        return result.fold(
          (failure) => Left(failure),
          (_) => const Right(false),
        );
      } else {
        final result = await _repository.addToFavorites(
          pokemon: pokemon,
          userId: userId,
        );
        return result.fold(
          (failure) => Left(failure),
          (_) => const Right(true),
        );
      }
    });
  }
}
