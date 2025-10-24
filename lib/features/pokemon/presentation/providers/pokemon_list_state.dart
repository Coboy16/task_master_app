import 'package:freezed_annotation/freezed_annotation.dart';
import '/features/pokemon/domain/domain.dart';

part 'pokemon_list_state.freezed.dart';

@freezed
abstract class PokemonListState with _$PokemonListState {
  const factory PokemonListState({
    @Default([]) List<Pokemon> pokemonList,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasMore,
    @Default(0) int currentOffset,
    String? errorMessage,
  }) = _PokemonListState;
}
