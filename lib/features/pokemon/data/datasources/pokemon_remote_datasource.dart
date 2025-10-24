import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart' hide ServerException;
import '/core/core.dart';
import '/features/pokemon/data/data.dart';

abstract class PokemonRemoteDatasource {
  /// Obtener lista de pokémon con paginación
  Future<List<PokemonModel>> getPokemonList({
    required int limit,
    required int offset,
  });

  /// Obtener detalle completo de un pokémon por ID
  Future<PokemonModel> getPokemonById(int id);

  /// Buscar pokémon por nombre
  Future<List<PokemonModel>> searchPokemon(String query);
}

class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  final GraphQLClient _client;

  PokemonRemoteDatasourceImpl({required GraphQLClient client})
    : _client = client;

  @override
  Future<List<PokemonModel>> getPokemonList({
    required int limit,
    required int offset,
  }) async {
    try {
      const query = r'''
        query GetPokemonList($limit: Int!, $offset: Int!) {
          pokemon_v2_pokemon(limit: $limit, offset: $offset, order_by: {id: asc}) {
            id
            name
            height
            weight
            pokemon_v2_pokemontypes {
              pokemon_v2_type {
                name
              }
            }
            pokemon_v2_pokemonsprites {
              sprites
            }
            pokemon_v2_pokemonabilities {
              is_hidden
              ability: pokemon_v2_ability {
                name
              }
            }
            pokemon_v2_pokemonstats {
              base_stat
              stat: pokemon_v2_stat {
                name
              }
            }
          }
        }
      ''';

      final result = await _client.query(
        QueryOptions(
          document: gql(query),
          variables: {'limit': limit, 'offset': offset},
        ),
      );

      if (result.hasException) {
        if (kDebugMode) {
          print('GraphQL Error: ${result.exception}');
        }
        throw ServerException(
          result.exception?.graphqlErrors.first.message ??
              'Error al obtener pokémon',
        );
      }

      final pokemonList = result.data?['pokemon_v2_pokemon'] as List?;
      if (pokemonList == null) {
        return [];
      }

      return pokemonList
          .map((pokemon) => PokemonModel.fromGraphQL(pokemon))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error en getPokemonList: $e');
      }
      if (e is ServerException) rethrow;
      throw ServerException(
        'Error al obtener lista de pokémon: ${e.toString()}',
      );
    }
  }

  @override
  Future<PokemonModel> getPokemonById(int id) async {
    try {
      const query = r'''
        query GetPokemonById($id: Int!) {
          pokemon_v2_pokemon(where: {id: {_eq: $id}}) {
            id
            name
            height
            weight
            pokemon_v2_pokemontypes {
              pokemon_v2_type {
                name
              }
            }
            pokemon_v2_pokemonsprites {
              sprites
            }
            pokemon_v2_pokemonabilities {
              is_hidden
              ability: pokemon_v2_ability {
                name
              }
            }
            pokemon_v2_pokemonstats {
              base_stat
              stat: pokemon_v2_stat {
                name
              }
            }
          }
        }
      ''';

      final result = await _client.query(
        QueryOptions(document: gql(query), variables: {'id': id}),
      );

      if (result.hasException) {
        if (kDebugMode) {
          print('GraphQL Error: ${result.exception}');
        }
        throw ServerException(
          result.exception?.graphqlErrors.first.message ??
              'Error al obtener pokémon',
        );
      }

      final pokemonList = result.data?['pokemon_v2_pokemon'] as List?;
      if (pokemonList == null || pokemonList.isEmpty) {
        throw ServerException('Pokémon no encontrado');
      }

      return PokemonModel.fromGraphQL(pokemonList.first);
    } catch (e) {
      if (kDebugMode) {
        print('Error en getPokemonById: $e');
      }
      if (e is ServerException) rethrow;
      throw ServerException('Error al obtener pokémon: ${e.toString()}');
    }
  }

  @override
  Future<List<PokemonModel>> searchPokemon(String query) async {
    try {
      const graphqlQuery = r'''
        query SearchPokemon($query: String!) {
          pokemon_v2_pokemon(
            where: {name: {_ilike: $query}}
            limit: 20
            order_by: {id: asc}
          ) {
            id
            name
            height
            weight
            pokemon_v2_pokemontypes {
              pokemon_v2_type {
                name
              }
            }
            pokemon_v2_pokemonsprites {
              sprites
            }
            pokemon_v2_pokemonabilities {
              is_hidden
              ability: pokemon_v2_ability {
                name
              }
            }
            pokemon_v2_pokemonstats {
              base_stat
              stat: pokemon_v2_stat {
                name
              }
            }
          }
        }
      ''';

      final result = await _client.query(
        QueryOptions(
          document: gql(graphqlQuery),
          variables: {'query': '%$query%'},
        ),
      );

      if (result.hasException) {
        if (kDebugMode) {
          print('GraphQL Error: ${result.exception}');
        }
        throw ServerException(
          result.exception?.graphqlErrors.first.message ??
              'Error al buscar pokémon',
        );
      }

      final pokemonList = result.data?['pokemon_v2_pokemon'] as List?;
      if (pokemonList == null) {
        return [];
      }

      return pokemonList
          .map((pokemon) => PokemonModel.fromGraphQL(pokemon))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error en searchPokemon: $e');
      }
      if (e is ServerException) rethrow;
      throw ServerException('Error al buscar pokémon: ${e.toString()}');
    }
  }
}
