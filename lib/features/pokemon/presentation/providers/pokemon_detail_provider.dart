import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/auth.dart';
import '/features/pokemon/presentation/providers/providers.dart';

part 'pokemon_detail_provider.g.dart';

@riverpod
class PokemonDetail extends _$PokemonDetail {
  @override
  PokemonDetailState build(int pokemonId) {
    _loadPokemonDetail();
    return const PokemonDetailState();
  }

  Future<void> _loadPokemonDetail() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final usecase = ref.read(getPokemonByIdUsecaseProvider);
    final authState = ref.read(authProvider).value;
    final userId =
        authState?.whenOrNull(authenticated: (user) => user.id) ?? '';

    final result = await usecase(id: pokemonId, userId: userId);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
      (pokemon) {
        state = state.copyWith(isLoading: false, pokemon: pokemon);
      },
    );
  }

  Future<void> reload() async {
    await _loadPokemonDetail();
  }

  void updateFavoriteStatus(bool isFavorite) {
    if (state.pokemon != null) {
      state = state.copyWith(
        pokemon: state.pokemon!.copyWith(isFavorite: isFavorite),
      );
    }
  }
}
