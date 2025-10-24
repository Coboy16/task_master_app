import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/core/core.dart';
import '/features/pokemon/data/data.dart';
import '/features/pokemon/domain/domain.dart';

part 'pokemon_dependencies_provider.g.dart';

/// Provider del GraphQL Client
@riverpod
GraphQLClient graphqlClient(Ref ref) {
  final httpLink = HttpLink('https://beta.pokeapi.co/graphql/v1beta');

  return GraphQLClient(link: httpLink, cache: GraphQLCache());
}

/// Provider del Local Datasource
@riverpod
PokemonLocalDatasource pokemonLocalDatasource(Ref ref) {
  final database = AppDatabase.instance;
  return PokemonLocalDatasourceImpl(database: database);
}

/// Provider del Remote Datasource
@riverpod
PokemonRemoteDatasource pokemonRemoteDatasource(Ref ref) {
  final client = ref.watch(graphqlClientProvider);
  return PokemonRemoteDatasourceImpl(client: client);
}

/// Provider del Repository
@riverpod
PokemonRepository pokemonRepository(Ref ref) {
  final localDatasource = ref.watch(pokemonLocalDatasourceProvider);
  final remoteDatasource = ref.watch(pokemonRemoteDatasourceProvider);

  return PokemonRepositoryImpl(
    localDatasource: localDatasource,
    remoteDatasource: remoteDatasource,
  );
}
