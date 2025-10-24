import 'package:freezed_annotation/freezed_annotation.dart';
import '/features/pokemon/domain/domain.dart';

part 'pokemon_detail_state.freezed.dart';

@freezed
abstract class PokemonDetailState with _$PokemonDetailState {
  const factory PokemonDetailState({
    Pokemon? pokemon,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _PokemonDetailState;
}
