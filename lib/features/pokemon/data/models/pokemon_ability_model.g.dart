// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_ability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PokemonAbilityModel _$PokemonAbilityModelFromJson(Map<String, dynamic> json) =>
    _PokemonAbilityModel(
      name: json['name'] as String,
      isHidden: json['isHidden'] as bool? ?? false,
    );

Map<String, dynamic> _$PokemonAbilityModelToJson(
  _PokemonAbilityModel instance,
) => <String, dynamic>{'name': instance.name, 'isHidden': instance.isHidden};
