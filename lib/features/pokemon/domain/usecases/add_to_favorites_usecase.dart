import 'package:dartz/dartz.dart';
import '/core/core.dart';
import '/features/pokemon/domain/domain.dart';

class AddToFavoritesUsecase {
  final PokemonRepository _repository;

  AddToFavoritesUsecase(this._repository);

  Future<Either<Failure, Unit>> call({
    required Pokemon pokemon,
    required String userId,
  }) async {
    return await _repository.addToFavorites(pokemon: pokemon, userId: userId);
  }
}
