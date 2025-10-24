import 'package:dartz/dartz.dart';
import '/core/core.dart';
import '/features/pokemon/domain/domain.dart';

class GetFavoritePokemonUsecase {
  final PokemonRepository _repository;

  GetFavoritePokemonUsecase(this._repository);

  Future<Either<Failure, List<Pokemon>>> call(String userId) async {
    return await _repository.getFavoritePokemon(userId);
  }
}
