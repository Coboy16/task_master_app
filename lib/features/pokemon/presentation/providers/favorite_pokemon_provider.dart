import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/auth.dart';
import '/features/pokemon/domain/domain.dart';
import '/features/pokemon/presentation/providers/providers.dart';

part 'favorite_pokemon_provider.g.dart';

@riverpod
class FavoritePokemon extends _$FavoritePokemon {
  @override
  Future<List<Pokemon>> build() async {
    return await _loadFavorites();
  }

  Future<List<Pokemon>> _loadFavorites() async {
    final usecase = ref.read(getFavoritePokemonUsecaseProvider);
    final authState = ref.read(authProvider).value;
    final userId =
        authState?.whenOrNull(authenticated: (user) => user.id) ?? '';

    final result = await usecase(userId);

    return result.fold((failure) => [], (favorites) => favorites);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _loadFavorites());
  }

  void removePokemon(int pokemonId) {
    state.whenData((favorites) {
      final updated = favorites.where((p) => p.id != pokemonId).toList();
      state = AsyncValue.data(updated);
    });
  }
}

/// Provider para contar favoritos
@riverpod
Future<int> favoritesCount(Ref ref) async {
  final usecase = ref.watch(getFavoritesCountUsecaseProvider);
  final authState = ref.watch(authProvider).value;
  final userId = authState?.whenOrNull(authenticated: (user) => user.id) ?? '';

  final result = await usecase(userId);

  return result.fold((failure) => 0, (count) => count);
}
