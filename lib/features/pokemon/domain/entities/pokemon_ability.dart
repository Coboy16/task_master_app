import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_ability.freezed.dart';

@freezed
abstract class PokemonAbility with _$PokemonAbility {
  const factory PokemonAbility({
    required String name,
    @Default(false) bool isHidden,
  }) = _PokemonAbility;
}

extension PokemonAbilityX on PokemonAbility {
  String get displayName {
    return name
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
