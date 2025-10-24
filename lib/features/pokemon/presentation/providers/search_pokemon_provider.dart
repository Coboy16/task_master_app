import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/features/auth/auth.dart';
import '/features/pokemon/domain/domain.dart';
import '/features/pokemon/presentation/providers/providers.dart';

part 'search_pokemon_provider.g.dart';

@riverpod
class SearchPokemon extends _$SearchPokemon {
  @override
  Future<List<Pokemon>> build(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }
    return await _searchPokemon(query);
  }

  Future<List<Pokemon>> _searchPokemon(String query) async {
    final usecase = ref.read(searchPokemonUsecaseProvider);
    final authState = ref.read(authProvider).value;
    final userId =
        authState?.whenOrNull(authenticated: (user) => user.id) ?? '';

    final result = await usecase(query: query, userId: userId);

    return result.fold((failure) => [], (pokemonList) => pokemonList);
  }
}
