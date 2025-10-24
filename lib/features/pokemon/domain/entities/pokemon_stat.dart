import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_stat.freezed.dart';

@freezed
abstract class PokemonStat with _$PokemonStat {
  const factory PokemonStat({required String name, required int baseStat}) =
      _PokemonStat;
}

extension PokemonStatX on PokemonStat {
  String get displayName {
    switch (name) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'Ataque';
      case 'defense':
        return 'Defensa';
      case 'special-attack':
        return 'Ataque Esp.';
      case 'special-defense':
        return 'Defensa Esp.';
      case 'speed':
        return 'Velocidad';
      default:
        return name
            .split('-')
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' ');
    }
  }

  String get shortName {
    switch (name) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'ATK';
      case 'defense':
        return 'DEF';
      case 'special-attack':
        return 'SP.ATK';
      case 'special-defense':
        return 'SP.DEF';
      case 'speed':
        return 'SPD';
      default:
        return name.toUpperCase();
    }
  }
}
