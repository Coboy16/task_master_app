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

String _$favoritePokemonHash() => r'06e66f2bdec44b3ba67ac60c3a8715deee4d1d7b';

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

@ProviderFor(favoritesCount)
const favoritesCountProvider = FavoritesCountProvider._();

final class FavoritesCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
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

String _$favoritesCountHash() => r'865f3f3ec57ef668b7bd6f92b10d32c8f3f1beb0';
