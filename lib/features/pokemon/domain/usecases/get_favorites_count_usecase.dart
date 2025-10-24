import 'package:dartz/dartz.dart';
import '/core/core.dart';
import '/features/pokemon/domain/domain.dart';

class GetFavoritesCountUsecase {
  final PokemonRepository _repository;

  GetFavoritesCountUsecase(this._repository);

  Future<Either<Failure, int>> call(String userId) async {
    return await _repository.getFavoritesCount(userId);
  }
}
