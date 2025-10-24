import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

import '/features/pokemon/data/data.dart';
import '/features/pokemon/domain/domain.dart';
import '/features/pokemon/presentation/widgets/widgets.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final primaryType = pokemon.types.isNotEmpty
        ? PokemonType.fromString(pokemon.types.first)
        : PokemonType.normal;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                primaryType.color.withOpacity(0.1),
                primaryType.color.withOpacity(0.05),
              ],
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Imagen
                    Expanded(
                      child: Center(
                        child: Hero(
                          tag: 'pokemon-${pokemon.id}',
                          child: pokemon.imageUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: pokemon.imageUrl!,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                        Icons.catching_pokemon,
                                        size: 80,
                                        color: Colors.grey,
                                      ),
                                )
                              : const Icon(
                                  Icons.catching_pokemon,
                                  size: 80,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // ID
                    Text(
                      pokemon.formattedId,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Nombre
                    Text(
                      pokemon.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1a1a1a),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Tipos
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: pokemon.types
                          .map((type) => PokemonTypeBadge(type: type))
                          .toList(),
                    ),
                  ],
                ),
              ),
              // Botón de favorito
              Positioned(
                top: 4,
                right: 4,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onFavoriteToggle,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        pokemon.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: pokemon.isFavorite
                            ? Colors.red
                            : Colors.grey[600],
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
