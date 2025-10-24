// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_stat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PokemonStatModel _$PokemonStatModelFromJson(Map<String, dynamic> json) =>
    _PokemonStatModel(
      name: json['name'] as String,
      baseStat: (json['baseStat'] as num).toInt(),
    );

Map<String, dynamic> _$PokemonStatModelToJson(_PokemonStatModel instance) =>
    <String, dynamic>{'name': instance.name, 'baseStat': instance.baseStat};
