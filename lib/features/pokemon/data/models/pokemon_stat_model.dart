import 'package:freezed_annotation/freezed_annotation.dart';
import '/features/pokemon/domain/domain.dart';

part 'pokemon_stat_model.freezed.dart';
part 'pokemon_stat_model.g.dart';

@freezed
abstract class PokemonStatModel with _$PokemonStatModel {
  const factory PokemonStatModel({
    required String name,
    required int baseStat,
  }) = _PokemonStatModel;

  factory PokemonStatModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatModelFromJson(json);

  factory PokemonStatModel.fromGraphQL(Map<String, dynamic> json) {
    return PokemonStatModel(
      name: json['stat']?['name'] ?? '',
      baseStat: json['base_stat'] ?? 0,
    );
  }

  factory PokemonStatModel.fromEntity(PokemonStat entity) {
    return PokemonStatModel(name: entity.name, baseStat: entity.baseStat);
  }
}

extension PokemonStatModelX on PokemonStatModel {
  PokemonStat toEntity() {
    return PokemonStat(name: name, baseStat: baseStat);
  }
}
