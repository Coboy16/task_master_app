import 'package:freezed_annotation/freezed_annotation.dart';
import '/features/pokemon/domain/domain.dart';

part 'pokemon_ability_model.freezed.dart';
part 'pokemon_ability_model.g.dart';

@freezed
abstract class PokemonAbilityModel with _$PokemonAbilityModel {
  const factory PokemonAbilityModel({
    required String name,
    @Default(false) bool isHidden,
  }) = _PokemonAbilityModel;

  factory PokemonAbilityModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonAbilityModelFromJson(json);

  factory PokemonAbilityModel.fromGraphQL(Map<String, dynamic> json) {
    return PokemonAbilityModel(
      name: json['ability']?['name'] ?? '',
      isHidden: json['is_hidden'] ?? false,
    );
  }

  factory PokemonAbilityModel.fromEntity(PokemonAbility entity) {
    return PokemonAbilityModel(name: entity.name, isHidden: entity.isHidden);
  }
}

extension PokemonAbilityModelX on PokemonAbilityModel {
  PokemonAbility toEntity() {
    return PokemonAbility(name: name, isHidden: isHidden);
  }
}
