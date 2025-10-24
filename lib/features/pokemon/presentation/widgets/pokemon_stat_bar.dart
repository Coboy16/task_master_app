import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/features/pokemon/domain/domain.dart';

class PokemonStatBar extends StatelessWidget {
  final PokemonStat stat;
  final Color color;

  const PokemonStatBar({
    super.key,
    required this.stat,
    this.color = const Color(0xFF2800C8),
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (stat.baseStat / 255).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Nombre de la estadística
          SizedBox(
            width: 80,
            child: Text(
              stat.shortName,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6b7280),
              ),
            ),
          ),
          // Valor
          SizedBox(
            width: 40,
            child: Text(
              stat.baseStat.toString(),
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1a1a1a),
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 12),
          // Barra de progreso
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: color.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
