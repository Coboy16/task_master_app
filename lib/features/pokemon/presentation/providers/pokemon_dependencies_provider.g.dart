// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_dependencies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider del GraphQL Client

@ProviderFor(graphqlClient)
const graphqlClientProvider = GraphqlClientProvider._();

/// Provider del GraphQL Client

final class GraphqlClientProvider
    extends $FunctionalProvider<GraphQLClient, GraphQLClient, GraphQLClient>
    with $Provider<GraphQLClient> {
  /// Provider del GraphQL Client
  const GraphqlClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'graphqlClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$graphqlClientHash();

  @$internal
  @override
  $ProviderElement<GraphQLClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GraphQLClient create(Ref ref) {
    return graphqlClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GraphQLClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GraphQLClient>(value),
    );
  }
}

String _$graphqlClientHash() => r'16fc54f5f99336032620f93235fcb5885a5f2fc2';

/// Provider del Local Datasource

@ProviderFor(pokemonLocalDatasource)
const pokemonLocalDatasourceProvider = PokemonLocalDatasourceProvider._();

/// Provider del Local Datasource

final class PokemonLocalDatasourceProvider
    extends
        $FunctionalProvider<
          PokemonLocalDatasource,
          PokemonLocalDatasource,
          PokemonLocalDatasource
        >
    with $Provider<PokemonLocalDatasource> {
  /// Provider del Local Datasource
  const PokemonLocalDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pokemonLocalDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pokemonLocalDatasourceHash();

  @$internal
  @override
  $ProviderElement<PokemonLocalDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PokemonLocalDatasource create(Ref ref) {
    return pokemonLocalDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PokemonLocalDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PokemonLocalDatasource>(value),
    );
  }
}

String _$pokemonLocalDatasourceHash() =>
    r'8abbf6c37b9ef1345fe50927af5b9fdec6429dcb';

/// Provider del Remote Datasource

@ProviderFor(pokemonRemoteDatasource)
const pokemonRemoteDatasourceProvider = PokemonRemoteDatasourceProvider._();

/// Provider del Remote Datasource

final class PokemonRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          PokemonRemoteDatasource,
          PokemonRemoteDatasource,
          PokemonRemoteDatasource
        >
    with $Provider<PokemonRemoteDatasource> {
  /// Provider del Remote Datasource
  const PokemonRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pokemonRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pokemonRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<PokemonRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PokemonRemoteDatasource create(Ref ref) {
    return pokemonRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PokemonRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PokemonRemoteDatasource>(value),
    );
  }
}

String _$pokemonRemoteDatasourceHash() =>
    r'96c6a787daf9bd1c0ab4adbfe22c1c2c224c7780';

/// Provider del Repository

@ProviderFor(pokemonRepository)
const pokemonRepositoryProvider = PokemonRepositoryProvider._();

/// Provider del Repository

final class PokemonRepositoryProvider
    extends
        $FunctionalProvider<
          PokemonRepository,
          PokemonRepository,
          PokemonRepository
        >
    with $Provider<PokemonRepository> {
  /// Provider del Repository
  const PokemonRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pokemonRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pokemonRepositoryHash();

  @$internal
  @override
  $ProviderElement<PokemonRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PokemonRepository create(Ref ref) {
    return pokemonRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PokemonRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PokemonRepository>(value),
    );
  }
}

String _$pokemonRepositoryHash() => r'964c81d30367ab31ba4bfb5692469ed41218126c';
