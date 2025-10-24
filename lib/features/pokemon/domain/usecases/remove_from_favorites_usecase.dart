import 'package:dartz/dartz.dart';
import '/core/core.dart';
import '/features/pokemon/domain/domain.dart';

class RemoveFromFavoritesUsecase {
  final PokemonRepository _repository;

  RemoveFromFavoritesUsecase(this._repository);

  Future<Either<Failure, Unit>> call({
    required int pokemonId,
    required String userId,
  }) async {
    return await _repository.removeFromFavorites(
      pokemonId: pokemonId,
      userId: userId,
    );
  }
}
