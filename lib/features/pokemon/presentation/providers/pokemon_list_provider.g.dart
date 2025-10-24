// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PokemonList)
const pokemonListProvider = PokemonListProvider._();

final class PokemonListProvider
    extends $NotifierProvider<PokemonList, PokemonListState> {
  const PokemonListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pokemonListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pokemonListHash();

  @$internal
  @override
  PokemonList create() => PokemonList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PokemonListState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PokemonListState>(value),
    );
  }
}

String _$pokemonListHash() => r'b00b563e97bfdb2220e5fd8b895df199d193801b';

abstract class _$PokemonList extends $Notifier<PokemonListState> {
  PokemonListState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PokemonListState, PokemonListState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PokemonListState, PokemonListState>,
              PokemonListState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
