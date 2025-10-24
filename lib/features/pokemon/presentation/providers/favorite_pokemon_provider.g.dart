// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_pokemon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoritePokemon)
const favoritePokemonProvider = FavoritePokemonProvider._();

final class FavoritePokemonProvider
    extends $AsyncNotifierProvider<FavoritePokemon, List<Pokemon>> {
  const FavoritePokemonProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritePokemonProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritePokemonHash();

  @$internal
  @override
  FavoritePokemon create() => FavoritePokemon();
}

String _$favoritePokemonHash() => r'11595f2ea00f26bf522009c59e0448796d954fc7';

abstract class _$FavoritePokemon extends $AsyncNotifier<List<Pokemon>> {
  FutureOr<List<Pokemon>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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

/// Provider para contar favoritos

@ProviderFor(favoritesCount)
const favoritesCountProvider = FavoritesCountProvider._();

/// Provider para contar favoritos

final class FavoritesCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Provider para contar favoritos
  const FavoritesCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return favoritesCount(ref);
  }
}

String _$favoritesCountHash() => r'11baa90f096ba0aa511c4f88bac80bc9d99bed78';
