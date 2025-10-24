import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/auth.dart';
import '/features/pokemon/presentation/providers/providers.dart';

part 'pokemon_list_provider.g.dart';

@riverpod
class PokemonList extends _$PokemonList {
  static const int _limit = 20;

  @override
  PokemonListState build() {
    _loadInitialPokemon();
    return const PokemonListState(hasMore: true);
  }

  Future<void> _loadInitialPokemon() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final usecase = ref.read(getPokemonListUsecaseProvider);
    final authState = ref.read(authProvider).value;
    final userId =
        authState?.whenOrNull(authenticated: (user) => user.id) ?? '';

    final result = await usecase(limit: _limit, offset: 0, userId: userId);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (pokemonList) {
        state = state.copyWith(
          isLoading: false,
          pokemonList: pokemonList,
          currentOffset: _limit,
          hasMore: pokemonList.length >= _limit,
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    final usecase = ref.read(getPokemonListUsecaseProvider);
    final authState = ref.read(authProvider).value;
    final userId =
        authState?.whenOrNull(authenticated: (user) => user.id) ?? '';

    final result = await usecase(
      limit: _limit,
      offset: state.currentOffset,
      userId: userId,
    );

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingMore: false,
          errorMessage: failure.message,
        );
      },
      (newPokemon) {
        final updatedList = [...state.pokemonList, ...newPokemon];
        state = state.copyWith(
          isLoadingMore: false,
          pokemonList: updatedList,
          currentOffset: state.currentOffset + _limit,
          hasMore: newPokemon.length >= _limit,
        );
      },
    );
  }

  Future<void> refresh() async {
    state = const PokemonListState(hasMore: true);
    await _loadInitialPokemon();
  }

  void updatePokemonFavoriteStatus(int pokemonId, bool isFavorite) {
    final updatedList = state.pokemonList.map((pokemon) {
      if (pokemon.id == pokemonId) {
        return pokemon.copyWith(isFavorite: isFavorite);
      }
      return pokemon;
    }).toList();

    state = state.copyWith(pokemonList: updatedList);
  }
}
