import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/auth.dart';
import '/features/pokemon/domain/domain.dart';
import '/features/pokemon/presentation/providers/providers.dart';

part 'toggle_favorite_controller.g.dart';

@riverpod
class ToggleFavoriteController extends _$ToggleFavoriteController {
  @override
  FutureOr<void> build() {}

  Future<bool> toggle(Pokemon pokemon) async {
    state = const AsyncValue.loading();

    final usecase = ref.read(toggleFavoriteUsecaseProvider);
    final authState = ref.read(authProvider).value;
    final userId =
        authState?.whenOrNull(authenticated: (user) => user.id) ?? '';

    final result = await usecase(pokemon: pokemon, userId: userId);

    return result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return pokemon.isFavorite; // Mantener estado actual en caso de error
      },
      (newFavoriteStatus) {
        state = const AsyncValue.data(null);

        // Actualizar el estado en los diferentes providers
        ref
            .read(pokemonListProvider.notifier)
            .updatePokemonFavoriteStatus(pokemon.id, newFavoriteStatus);

        // Si existe un provider de detalle activo para este pokemon, actualizarlo
        ref.invalidate(pokemonDetailProvider(pokemon.id));

        // Refrescar la lista de favoritos
        ref.invalidate(favoritePokemonProvider);
        ref.invalidate(favoritesCountProvider);

        return newFavoriteStatus;
      },
    );
  }
}
