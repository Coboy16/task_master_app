import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/auth.dart';
import '/features/pokemon/presentation/providers/providers.dart';

part 'pokemon_detail_provider.g.dart';

@riverpod
class PokemonDetail extends _$PokemonDetail {
  @override
  PokemonDetailState build(int pokemonId) {
    return const PokemonDetailState();
  }

  Future<void> loadPokemonDetail() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, errorMessage: null);
    final usecase = ref.read(getPokemonByIdUsecaseProvider);
    final authState = await ref.read(authProvider.future);

    final userId = authState.whenOrNull(authenticated: (user) => user.id) ?? '';

    if (userId.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Usuario no encontrado",
      );
      return;
    }

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
    await loadPokemonDetail();
  }

  void updateFavoriteStatus(bool isFavorite) {
    if (state.pokemon != null) {
      state = state.copyWith(
        pokemon: state.pokemon!.copyWith(isFavorite: isFavorite),
      );
    }
  }
}
