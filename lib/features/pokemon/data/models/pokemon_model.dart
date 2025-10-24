import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '/features/pokemon/data/data.dart';
import '/features/pokemon/domain/domain.dart';

part 'pokemon_model.freezed.dart';
part 'pokemon_model.g.dart';

@freezed
abstract class PokemonModel with _$PokemonModel {
  const factory PokemonModel({
    required int id,
    required String name,
    String? imageUrl,
    required List<String> types,
    int? height,
    int? weight,
    @Default([]) List<PokemonAbilityModel> abilities,
    @Default([]) List<PokemonStatModel> stats,
    @Default(false) bool isFavorite,
  }) = _PokemonModel;

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  factory PokemonModel.fromGraphQL(Map<String, dynamic> json) {
    final types =
        (json['pokemon_v2_pokemontypes'] as List?)
            ?.map((t) => t['pokemon_v2_type']?['name'] as String? ?? '')
            .where((t) => t.isNotEmpty)
            .toList() ??
        [];
    final abilities =
        (json['pokemon_v2_pokemonabilities'] as List?)
            ?.map((a) => PokemonAbilityModel.fromGraphQL(a))
            .toList() ??
        [];
    final stats =
        (json['pokemon_v2_pokemonstats'] as List?)
            ?.map((s) => PokemonStatModel.fromGraphQL(s))
            .toList() ??
        [];

    String? imageUrl;
    try {
      final spritesList = json['pokemon_v2_pokemonsprites'] as List?;
      if (spritesList != null && spritesList.isNotEmpty) {
        final spritesData = spritesList[0];
        if (spritesData is Map<String, dynamic>) {
          final spritesMap = spritesData['sprites'];

          if (spritesMap is Map<String, dynamic>) {
            imageUrl =
                spritesMap['other']?['official-artwork']?['front_default'] ??
                spritesMap['other']?['dream_world']?['front_default'] ??
                spritesMap['other']?['home']?['front_default'] ??
                spritesMap['front_default'];
          } else if (spritesMap is String && spritesMap.isNotEmpty) {
            // if (kDebugMode) {
            //   print(
            //     'Pokemon ID ${json['id']} (${json['name']}): sprites field was a String, decoding...',
            //   );
            // }
            final spritesJson = jsonDecode(spritesMap);
            imageUrl =
                spritesJson['other']?['official-artwork']?['front_default'] ??
                spritesJson['other']?['dream_world']?['front_default'] ??
                spritesJson['other']?['home']?['front_default'] ??
                spritesJson['front_default'];
          }
        }
      }

      if (kDebugMode) {
        print(
          'Pokemon ID ${json['id']} (${json['name']}): Final imageUrl: $imageUrl',
        );
      }
    } catch (e, s) {
      imageUrl = null;
      if (kDebugMode) {
        print(
          'Pokemon ID ${json['id']} (${json['name']}): Error processing sprites - $e',
        );
        print(s);
      }
    }

    return PokemonModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: imageUrl,
      types: types,
      height: json['height'],
      weight: json['weight'],
      abilities: abilities,
      stats: stats,
    );
  }

  factory PokemonModel.fromSQLite(Map<String, dynamic> map) {
    final typesString = map['types'] as String;
    final types = typesString.split(',').where((t) => t.isNotEmpty).toList();

    final abilitiesString = map['abilities'] as String?;
    final abilities = abilitiesString != null && abilitiesString.isNotEmpty
        ? (jsonDecode(abilitiesString) as List)
              .map((a) => PokemonAbilityModel.fromJson(a))
              .toList()
        : <PokemonAbilityModel>[];

    final statsString = map['stats'] as String?;
    final stats = statsString != null && statsString.isNotEmpty
        ? (jsonDecode(statsString) as List)
              .map((s) => PokemonStatModel.fromJson(s))
              .toList()
        : <PokemonStatModel>[];

    return PokemonModel(
      id: map['id'] as int,
      name: map['name'] as String,
      imageUrl: map['image_url'] as String?,
      types: types,
      height: map['height'] as int?,
      weight: map['weight'] as int?,
      abilities: abilities,
      stats: stats,
      isFavorite: true,
    );
  }

  factory PokemonModel.fromEntity(Pokemon entity) {
    return PokemonModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      types: entity.types,
      height: entity.height,
      weight: entity.weight,
      abilities: entity.abilities
          .map((a) => PokemonAbilityModel.fromEntity(a))
          .toList(),
      stats: entity.stats.map((s) => PokemonStatModel.fromEntity(s)).toList(),
      isFavorite: entity.isFavorite,
    );
  }
}

extension PokemonModelX on PokemonModel {
  Pokemon toEntity() {
    return Pokemon(
      id: id,
      name: name,
      imageUrl: imageUrl,
      types: types,
      height: height,
      weight: weight,
      abilities: abilities.map((a) => a.toEntity()).toList(),
      stats: stats.map((s) => s.toEntity()).toList(),
      isFavorite: isFavorite,
    );
  }

  Map<String, dynamic> toSQLite(String userId) {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'types': types.join(','),
      'height': height,
      'weight': weight,
      'abilities': jsonEncode(abilities.map((a) => a.toJson()).toList()),
      'stats': jsonEncode(stats.map((s) => s.toJson()).toList()),
      'user_id': userId,
      'added_at': DateTime.now().toIso8601String(),
    };
  }
}
