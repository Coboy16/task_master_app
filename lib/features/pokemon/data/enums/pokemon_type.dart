import 'package:flutter/material.dart';

enum PokemonType {
  normal,
  fire,
  water,
  electric,
  grass,
  ice,
  fighting,
  poison,
  ground,
  flying,
  psychic,
  bug,
  rock,
  ghost,
  dragon,
  dark,
  steel,
  fairy;

  String get displayName {
    switch (this) {
      case PokemonType.normal:
        return 'Normal';
      case PokemonType.fire:
        return 'Fuego';
      case PokemonType.water:
        return 'Agua';
      case PokemonType.electric:
        return 'Eléctrico';
      case PokemonType.grass:
        return 'Planta';
      case PokemonType.ice:
        return 'Hielo';
      case PokemonType.fighting:
        return 'Lucha';
      case PokemonType.poison:
        return 'Veneno';
      case PokemonType.ground:
        return 'Tierra';
      case PokemonType.flying:
        return 'Volador';
      case PokemonType.psychic:
        return 'Psíquico';
      case PokemonType.bug:
        return 'Bicho';
      case PokemonType.rock:
        return 'Roca';
      case PokemonType.ghost:
        return 'Fantasma';
      case PokemonType.dragon:
        return 'Dragón';
      case PokemonType.dark:
        return 'Siniestro';
      case PokemonType.steel:
        return 'Acero';
      case PokemonType.fairy:
        return 'Hada';
    }
  }

  Color get color {
    switch (this) {
      case PokemonType.normal:
        return const Color(0xFFA8A878);
      case PokemonType.fire:
        return const Color(0xFFF08030);
      case PokemonType.water:
        return const Color(0xFF6890F0);
      case PokemonType.electric:
        return const Color(0xFFF8D030);
      case PokemonType.grass:
        return const Color(0xFF78C850);
      case PokemonType.ice:
        return const Color(0xFF98D8D8);
      case PokemonType.fighting:
        return const Color(0xFFC03028);
      case PokemonType.poison:
        return const Color(0xFFA040A0);
      case PokemonType.ground:
        return const Color(0xFFE0C068);
      case PokemonType.flying:
        return const Color(0xFFA890F0);
      case PokemonType.psychic:
        return const Color(0xFFF85888);
      case PokemonType.bug:
        return const Color(0xFFA8B820);
      case PokemonType.rock:
        return const Color(0xFFB8A038);
      case PokemonType.ghost:
        return const Color(0xFF705898);
      case PokemonType.dragon:
        return const Color(0xFF7038F8);
      case PokemonType.dark:
        return const Color(0xFF705848);
      case PokemonType.steel:
        return const Color(0xFFB8B8D0);
      case PokemonType.fairy:
        return const Color(0xFFEE99AC);
    }
  }

  static PokemonType fromString(String type) {
    return PokemonType.values.firstWhere(
      (e) => e.name.toLowerCase() == type.toLowerCase(),
      orElse: () => PokemonType.normal,
    );
  }
}
