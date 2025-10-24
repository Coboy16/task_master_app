import 'package:dartz/dartz.dart';
import '/core/core.dart';
import '/features/pokemon/domain/domain.dart';

class SearchPokemonUsecase {
  final PokemonRepository _repository;

  SearchPokemonUsecase(this._repository);

  Future<Either<Failure, List<Pokemon>>> call({
    required String query,
    required String userId,
  }) async {
    if (query.trim().isEmpty) {
      return const Right([]);
    }

    return await _repository.searchPokemon(
      query: query.trim().toLowerCase(),
      userId: userId,
    );
  }
}
