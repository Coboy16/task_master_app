import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/auth.dart';
import '/features/pokemon/domain/domain.dart';
import '/features/pokemon/presentation/providers/providers.dart';

part 'toggle_favorite_controller.g.dart';

@Riverpod(keepAlive: true)
class ToggleFavoriteController extends _$ToggleFavoriteController {
  @override
  FutureOr<void> build() {}

  Future<bool> toggle(Pokemon pokemon) async {
    if (!ref.mounted) return pokemon.isFavorite;

    state = const AsyncValue.loading();
    final usecase = ref.read(toggleFavoriteUsecaseProvider);
    final authState = await ref.read(authProvider.future);

    final userId = authState.whenOrNull(authenticated: (user) => user.id) ?? '';

    if (userId.isEmpty) {
      if (!ref.mounted) return pokemon.isFavorite;
      state = AsyncValue.error('Usuario no autenticado', StackTrace.current);
      return pokemon.isFavorite;
    }

    final result = await usecase(pokemon: pokemon, userId: userId);
    if (!ref.mounted) {
      return result.fold((_) => pokemon.isFavorite, (newStatus) => newStatus);
    }

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return pokemon.isFavorite;
      },
      (newFavoriteStatus) {
        state = const AsyncValue.data(null);
        ref
            .read(pokemonListProvider.notifier)
            .updatePokemonFavoriteStatus(pokemon.id, newFavoriteStatus);

        ref.invalidate(pokemonDetailProvider(pokemon.id));
        ref.invalidate(favoritePokemonProvider);
        ref.invalidate(favoritesCountProvider);

        return newFavoriteStatus;
      },
    );
  }
}
