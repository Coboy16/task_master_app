import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/auth.dart';
import '/features/pokemon/domain/domain.dart';
import '/features/pokemon/presentation/providers/providers.dart';

part 'favorite_pokemon_provider.g.dart';

@riverpod
class FavoritePokemon extends _$FavoritePokemon {
  @override
  Future<List<Pokemon>> build() async {
    final usecase = ref.read(getFavoritePokemonUsecaseProvider);
    final authState = await ref.read(authProvider.future);

    final userId = authState.whenOrNull(authenticated: (user) => user.id) ?? '';

    if (userId.isEmpty) {
      return [];
    }

    final result = await usecase(userId);

    return result.fold((failure) => [], (favorites) => favorites);
  }

  Future<void> _loadFavorites() async {
    final usecase = ref.read(getFavoritePokemonUsecaseProvider);
    final authState = await ref.read(authProvider.future);
    final userId = authState.whenOrNull(authenticated: (user) => user.id) ?? '';

    if (userId.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    final result = await usecase(userId);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (favorites) => state = AsyncValue.data(favorites),
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _loadFavorites();
  }

  void removePokemon(int pokemonId) {
    state.whenData((favorites) {
      final updated = favorites.where((p) => p.id != pokemonId).toList();
      state = AsyncValue.data(updated);
    });
  }
}

@riverpod
Future<int> favoritesCount(Ref ref) async {
  final usecase = ref.watch(getFavoritesCountUsecaseProvider);

  final authState = await ref.watch(authProvider.future);

  final userId = authState.whenOrNull(authenticated: (user) => user.id) ?? '';

  if (userId.isEmpty) {
    return 0;
  }

  final result = await usecase(userId);
  return result.fold((failure) => 0, (count) => count);
}
