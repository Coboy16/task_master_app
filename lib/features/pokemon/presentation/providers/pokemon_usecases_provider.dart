import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/pokemon/domain/domain.dart';
import '/features/pokemon/presentation/providers/providers.dart';

part 'pokemon_usecases_provider.g.dart';

/// Provider para GetPokemonListUsecase
@riverpod
GetPokemonListUsecase getPokemonListUsecase(Ref ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return GetPokemonListUsecase(repository);
}

/// Provider para GetPokemonByIdUsecase
@riverpod
GetPokemonByIdUsecase getPokemonByIdUsecase(Ref ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return GetPokemonByIdUsecase(repository);
}

/// Provider para SearchPokemonUsecase
@riverpod
SearchPokemonUsecase searchPokemonUsecase(Ref ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return SearchPokemonUsecase(repository);
}

/// Provider para GetFavoritePokemonUsecase
@riverpod
GetFavoritePokemonUsecase getFavoritePokemonUsecase(Ref ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return GetFavoritePokemonUsecase(repository);
}

/// Provider para AddToFavoritesUsecase
@riverpod
AddToFavoritesUsecase addToFavoritesUsecase(Ref ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return AddToFavoritesUsecase(repository);
}

/// Provider para RemoveFromFavoritesUsecase
@riverpod
RemoveFromFavoritesUsecase removeFromFavoritesUsecase(Ref ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return RemoveFromFavoritesUsecase(repository);
}

/// Provider para ToggleFavoriteUsecase
@riverpod
ToggleFavoriteUsecase toggleFavoriteUsecase(Ref ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return ToggleFavoriteUsecase(repository);
}

/// Provider para GetFavoritesCountUsecase
@riverpod
GetFavoritesCountUsecase getFavoritesCountUsecase(Ref ref) {
  final repository = ref.watch(pokemonRepositoryProvider);
  return GetFavoritesCountUsecase(repository);
}
