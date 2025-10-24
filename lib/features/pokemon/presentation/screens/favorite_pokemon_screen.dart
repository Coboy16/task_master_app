import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '/features/pokemon/presentation/providers/providers.dart';
import '/features/pokemon/presentation/widgets/widgets.dart';

class FavoritePokemonScreen extends ConsumerWidget {
  const FavoritePokemonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoritePokemonProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoritos',
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1a1a1a),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Color(0xFF1a1a1a)),
          onPressed: () => context.pop(),
        ),
      ),
      body: favoritesAsync.when(
        data: (favorites) {
          if (favorites.isEmpty) {
            return PokemonEmptyState(
              title: 'No tienes favoritos',
              message:
                  'Agrega Pokémon a tus favoritos desde la lista principal',
              icon: LucideIcons.heart,
              actionLabel: 'Explorar Pokémon',
              onAction: () => context.pop(),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(favoritePokemonProvider.notifier).refresh();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final pokemon = favorites[index];
                return PokemonCard(
                  pokemon: pokemon,
                  onTap: () {
                    context.push('/pokemon/detail/${pokemon.id}');
                  },
                  onFavoriteToggle: () async {
                    final newStatus = await ref
                        .read(toggleFavoriteControllerProvider.notifier)
                        .toggle(pokemon);

                    if (!newStatus) {
                      // Si se quitó de favoritos, removerlo de la lista
                      ref
                          .read(favoritePokemonProvider.notifier)
                          .removePokemon(pokemon.id);

                      // Mostrar snackbar
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${pokemon.name} eliminado de favoritos',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            backgroundColor: const Color(0xFF1a1a1a),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.all(16),
                          ),
                        );
                      }
                    }
                  },
                );
              },
            ),
          );
        },
        loading: () => const PokemonLoadingShimmer(),
        error: (error, stack) => PokemonErrorWidget(
          message: 'Error al cargar favoritos',
          onRetry: () {
            ref.invalidate(favoritePokemonProvider);
          },
        ),
      ),
    );
  }
}
