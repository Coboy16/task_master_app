import 'package:freezed_annotation/freezed_annotation.dart';
import '/features/pokemon/domain/domain.dart';

part 'pokemon.freezed.dart';

@freezed
abstract class Pokemon with _$Pokemon {
  const factory Pokemon({
    required int id,
    required String name,
    String? imageUrl,
    required List<String> types,
    int? height,
    int? weight,
    @Default([]) List<PokemonAbility> abilities,
    @Default([]) List<PokemonStat> stats,
    @Default(false) bool isFavorite,
  }) = _Pokemon;
}

extension PokemonX on Pokemon {
  String get displayName {
    return name[0].toUpperCase() + name.substring(1);
  }

  String get formattedId {
    return '#${id.toString().padLeft(3, '0')}';
  }

  String get heightInMeters {
    if (height == null) return 'N/A';
    return '${(height! / 10).toStringAsFixed(1)} m';
  }

  String get weightInKg {
    if (weight == null) return 'N/A';
    return '${(weight! / 10).toStringAsFixed(1)} kg';
  }

  String get typesString {
    return types.map((t) => t[0].toUpperCase() + t.substring(1)).join(', ');
  }

  int get totalStats {
    return stats.fold(0, (sum, stat) => sum + stat.baseStat);
  }

  PokemonStat? getStatByName(String statName) {
    try {
      return stats.firstWhere((s) => s.name == statName);
    } catch (_) {
      return null;
    }
  }

  int get hp => getStatByName('hp')?.baseStat ?? 0;
  int get attack => getStatByName('attack')?.baseStat ?? 0;
  int get defense => getStatByName('defense')?.baseStat ?? 0;
  int get specialAttack => getStatByName('special-attack')?.baseStat ?? 0;
  int get specialDefense => getStatByName('special-defense')?.baseStat ?? 0;
  int get speed => getStatByName('speed')?.baseStat ?? 0;
}
