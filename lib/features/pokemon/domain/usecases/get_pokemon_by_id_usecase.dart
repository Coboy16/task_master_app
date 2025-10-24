import 'package:dartz/dartz.dart';
import '/core/core.dart';
import '/features/pokemon/domain/domain.dart';

class GetPokemonByIdUsecase {
  final PokemonRepository _repository;

  GetPokemonByIdUsecase(this._repository);

  Future<Either<Failure, Pokemon>> call({
    required int id,
    required String userId,
  }) async {
    return await _repository.getPokemonById(id: id, userId: userId);
  }
}
