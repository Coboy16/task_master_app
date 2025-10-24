import 'package:dartz/dartz.dart';
import '/core/core.dart';
import '/features/pokemon/domain/domain.dart';

class GetPokemonListUsecase {
  final PokemonRepository _repository;

  GetPokemonListUsecase(this._repository);

  Future<Either<Failure, List<Pokemon>>> call({
    required int limit,
    required int offset,
    required String userId,
  }) async {
    return await _repository.getPokemonList(
      limit: limit,
      offset: offset,
      userId: userId,
    );
  }
}
