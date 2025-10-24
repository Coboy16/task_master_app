import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '/features/pokemon/data/data.dart';
import '/features/pokemon/presentation/providers/providers.dart';
import '/features/pokemon/presentation/widgets/widgets.dart';

import '/features/pokemon/domain/domain.dart';

class PokemonDetailScreen extends ConsumerStatefulWidget {
  final int pokemonId;

  const PokemonDetailScreen({super.key, required this.pokemonId});

  @override
  ConsumerState<PokemonDetailScreen> createState() =>
      _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends ConsumerState<PokemonDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        ref
            .read(pokemonDetailProvider(widget.pokemonId).notifier)
            .loadPokemonDetail();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pokemonDetailProvider(widget.pokemonId));

    return Scaffold(
      body: state.isLoading && state.pokemon == null
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? PokemonErrorWidget(
              message: state.errorMessage!,
              onRetry: () {
                ref
                    .read(pokemonDetailProvider(widget.pokemonId).notifier)
                    .reload();
              },
            )
          : state.pokemon != null
          ? _buildDetail(context, ref, state.pokemon!)
          : const Center(child: Text('Pokémon no encontrado')),
    );
  }

  Widget _buildDetail(BuildContext context, WidgetRef ref, Pokemon pokemon) {
    final primaryType = pokemon.types.isNotEmpty
        ? PokemonType.fromString(pokemon.types.first)
        : PokemonType.normal;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: primaryType.color,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(
                pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () async {
                final newStatus = await ref
                    .read(toggleFavoriteControllerProvider.notifier)
                    .toggle(pokemon);
                ref
                    .read(pokemonDetailProvider(widget.pokemonId).notifier)
                    .updateFavoriteStatus(newStatus);
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    primaryType.color,
                    primaryType.color.withOpacity(0.8),
                  ],
                ),
              ),
              child: Center(
                child: Hero(
                  tag: 'pokemon-${widget.pokemonId}',
                  child: pokemon.imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: pokemon.imageUrl!,
                          height: 200,
                          fit: BoxFit.contain,
                        )
                      : const Icon(
                          Icons.catching_pokemon,
                          size: 200,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ),
        ),

        // Contenido
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ID y Nombre
                  Row(
                    children: [
                      Text(
                        // AHORA ESTA LÍNEA FUNCIONARÁ
                        pokemon.formattedId,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          pokemon.displayName,
                          style: GoogleFonts.inter(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1a1a1a),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tipos
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: pokemon.types
                        .map<Widget>(
                          (type) => PokemonTypeBadge(type: type, isLarge: true),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 32),

                  // Información física
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard(
                          'Altura',
                          pokemon.heightInMeters,
                          LucideIcons.ruler,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoCard(
                          'Peso',
                          pokemon.weightInKg,
                          LucideIcons.weight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Habilidades
                  if (pokemon.abilities.isNotEmpty) ...[
                    Text(
                      'Habilidades',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1a1a1a),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: pokemon.abilities.map<Widget>((ability) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: primaryType.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: primaryType.color.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                ability.displayName,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryType.color,
                                ),
                              ),
                              if (ability.isHidden) ...[
                                const SizedBox(width: 4),
                                Icon(
                                  LucideIcons.eyeOff,
                                  size: 14,
                                  color: primaryType.color,
                                ),
                              ],
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // Estadísticas
                  if (pokemon.stats.isNotEmpty) ...[
                    Text(
                      'Estadísticas Base',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1a1a1a),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...pokemon.stats.map((stat) {
                      return PokemonStatBar(
                        stat: stat,
                        color: primaryType.color,
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: primaryType.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1a1a1a),
                            ),
                          ),
                          Text(
                            pokemon.totalStats.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: primaryType.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFfafafa),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFe5e7eb)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: const Color(0xFF2800C8)),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1a1a1a),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6b7280),
            ),
          ),
        ],
      ),
    );
  }
}
