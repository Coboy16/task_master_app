import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/features/pokemon/data/data.dart';

class PokemonTypeBadge extends StatelessWidget {
  final String type;
  final bool isLarge;

  const PokemonTypeBadge({super.key, required this.type, this.isLarge = false});

  @override
  Widget build(BuildContext context) {
    final pokemonType = PokemonType.fromString(type);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 12 : 8,
        vertical: isLarge ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: pokemonType.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: pokemonType.color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        pokemonType.displayName,
        style: GoogleFonts.inter(
          fontSize: isLarge ? 13 : 11,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
