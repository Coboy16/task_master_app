// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PokemonModel _$PokemonModelFromJson(Map<String, dynamic> json) =>
    _PokemonModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
      height: (json['height'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      abilities:
          (json['abilities'] as List<dynamic>?)
              ?.map(
                (e) => PokemonAbilityModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      stats:
          (json['stats'] as List<dynamic>?)
              ?.map((e) => PokemonStatModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$PokemonModelToJson(_PokemonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'types': instance.types,
      'height': instance.height,
      'weight': instance.weight,
      'abilities': instance.abilities,
      'stats': instance.stats,
      'isFavorite': instance.isFavorite,
    };
