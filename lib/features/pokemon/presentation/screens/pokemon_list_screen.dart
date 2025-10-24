import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';

import '/features/pokemon/presentation/providers/providers.dart';
import '/features/pokemon/presentation/widgets/widgets.dart';

class PokemonListScreen extends ConsumerStatefulWidget {
  const PokemonListScreen({super.key});

  @override
  ConsumerState<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends ConsumerState<PokemonListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Future.microtask(() {
      if (mounted) {
        ref.read(pokemonListProvider.notifier).loadInitialPokemon();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isSearching) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = ref.read(pokemonListProvider);
      if (!state.isLoadingMore && state.hasMore) {
        ref.read(pokemonListProvider.notifier).loadMore();
      }
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        // Cuando se cancela la búsqueda, invalidamos con cadena vacía para limpiar resultados
        ref.invalidate(searchPokemonProvider(''));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(pokemonListProvider);
    final favoritesCount = ref.watch(favoritesCountProvider);
    final currentSearchQuery = _searchController.text;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Buscar Pokémon...',
                  hintStyle: GoogleFonts.inter(color: Colors.grey[400]),
                  border: InputBorder.none,
                ),
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: const Color(0xFF1a1a1a),
                ),
                onChanged: (value) {
                  ref.invalidate(searchPokemonProvider(value));
                  setState(() {});
                },
              )
            : Text(
                'Pokédex',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1a1a1a),
                ),
              ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isSearching ? LucideIcons.x : LucideIcons.search,
              color: const Color(0xFF2800C8),
            ),
            onPressed: _toggleSearch,
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(LucideIcons.heart, color: Color(0xFF2800C8)),
                onPressed: () {
                  context.push('/home/pokemon/favorites');
                },
              ),
              if (favoritesCount.value != null && favoritesCount.value! > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${favoritesCount.value}',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: _isSearching
          ? _buildSearchResults(currentSearchQuery)
          : _buildPokemonList(state),
    );
  }

  Widget _buildSearchResults(String searchQuery) {
    if (searchQuery.trim().isEmpty) {
      return const PokemonEmptyState(
        title: 'Busca un Pokémon',
        message: 'Escribe el nombre de un Pokémon para empezar',
        icon: LucideIcons.search,
      );
    }

    final searchResults = ref.watch(searchPokemonProvider(searchQuery));
    return searchResults.when(
      data: (pokemonList) {
        if (pokemonList.isEmpty) {
          return const PokemonEmptyState(
            title: 'No se encontraron Pokémon',
            message: 'Intenta con otro nombre',
            icon: LucideIcons.search,
          );
        }

        // Muestra los resultados
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: pokemonList.length,
          itemBuilder: (context, index) {
            final pokemon = pokemonList[index];

            return PokemonCard(
              pokemon: pokemon,
              onTap: () {
                context.push('/home/pokemon/detail/${pokemon.id}');
              },
              onFavoriteToggle: () async {
                await ref
                    .read(toggleFavoriteControllerProvider.notifier)
                    .toggle(pokemon);
              },
            );
          },
        );
      },
      loading: () => const PokemonLoadingShimmer(),
      error: (error, stack) => PokemonErrorWidget(
        message: 'Error al buscar: ${error.toString()}',
        onRetry: () {
          ref.invalidate(searchPokemonProvider(searchQuery));
        },
      ),
    );
  }

  Widget _buildPokemonList(PokemonListState state) {
    if (state.isLoading && state.pokemonList.isEmpty) {
      return const PokemonLoadingShimmer();
    }

    if (state.errorMessage != null && state.pokemonList.isEmpty) {
      return PokemonErrorWidget(
        message: state.errorMessage!,
        onRetry: () {
          ref.read(pokemonListProvider.notifier).refresh();
        },
      );
    }

    if (!state.isLoading && state.pokemonList.isEmpty) {
      return const PokemonEmptyState(
        title: 'No hay Pokémon',
        message: 'No se pudieron cargar los Pokémon iniciales.',
        icon: LucideIcons.serverOff,
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(pokemonListProvider.notifier).refresh();
      },
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: state.pokemonList.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.pokemonList.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final pokemon = state.pokemonList[index];

          return PokemonCard(
            pokemon: pokemon,
            onTap: () {
              context.push('/home/pokemon/detail/${pokemon.id}');
            },
            onFavoriteToggle: () async {
              await ref
                  .read(toggleFavoriteControllerProvider.notifier)
                  .toggle(pokemon);
            },
          );
        },
      ),
    );
  }
}
