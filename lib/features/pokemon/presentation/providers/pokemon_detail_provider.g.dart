// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PokemonDetail)
const pokemonDetailProvider = PokemonDetailFamily._();

final class PokemonDetailProvider
    extends $NotifierProvider<PokemonDetail, PokemonDetailState> {
  const PokemonDetailProvider._({
    required PokemonDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'pokemonDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pokemonDetailHash();

  @override
  String toString() {
    return r'pokemonDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PokemonDetail create() => PokemonDetail();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PokemonDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PokemonDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PokemonDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pokemonDetailHash() => r'84de2668ad8189823e23f84ffacb0f6565e75eba';

final class PokemonDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          PokemonDetail,
          PokemonDetailState,
          PokemonDetailState,
          PokemonDetailState,
          int
        > {
  const PokemonDetailFamily._()
    : super(
        retry: null,
        name: r'pokemonDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PokemonDetailProvider call(int pokemonId) =>
      PokemonDetailProvider._(argument: pokemonId, from: this);

  @override
  String toString() => r'pokemonDetailProvider';
}

abstract class _$PokemonDetail extends $Notifier<PokemonDetailState> {
  late final _$args = ref.$arg as int;
  int get pokemonId => _$args;

  PokemonDetailState build(int pokemonId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<PokemonDetailState, PokemonDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PokemonDetailState, PokemonDetailState>,
              PokemonDetailState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
