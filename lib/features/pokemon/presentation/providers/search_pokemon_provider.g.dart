// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_pokemon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchPokemon)
const searchPokemonProvider = SearchPokemonFamily._();

final class SearchPokemonProvider
    extends $AsyncNotifierProvider<SearchPokemon, List<Pokemon>> {
  const SearchPokemonProvider._({
    required SearchPokemonFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'searchPokemonProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchPokemonHash();

  @override
  String toString() {
    return r'searchPokemonProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SearchPokemon create() => SearchPokemon();

  @override
  bool operator ==(Object other) {
    return other is SearchPokemonProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchPokemonHash() => r'f1551b7e34ec77efcf7d008814927a36d9d029d8';

final class SearchPokemonFamily extends $Family
    with
        $ClassFamilyOverride<
          SearchPokemon,
          AsyncValue<List<Pokemon>>,
          List<Pokemon>,
          FutureOr<List<Pokemon>>,
          String
        > {
  const SearchPokemonFamily._()
    : super(
        retry: null,
        name: r'searchPokemonProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  SearchPokemonProvider call(String query) =>
      SearchPokemonProvider._(argument: query, from: this);

  @override
  String toString() => r'searchPokemonProvider';
}

abstract class _$SearchPokemon extends $AsyncNotifier<List<Pokemon>> {
  late final _$args = ref.$arg as String;
  String get query => _$args;

  FutureOr<List<Pokemon>> build(String query);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<Pokemon>>, List<Pokemon>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Pokemon>>, List<Pokemon>>,
              AsyncValue<List<Pokemon>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
