import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/feactures.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authStateAsync = ref.watch(authProvider);

  return GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,

    redirect: (context, state) {
      final authState = authStateAsync.asData?.value;
      final currentLocation = state.matchedLocation;

      final isStarting =
          authState == null ||
          authState.maybeWhen(
            initial: () => true,
            loading: () => true,
            orElse: () => false,
          );

      if (isStarting) {
        if (currentLocation == RouteNames.splash) {
          return null;
        }
        return RouteNames.splash;
      }

      final publicRoutes = [
        RouteNames.splash,
        RouteNames.login,
        RouteNames.register,
        RouteNames.noAccount,
      ];

      final isPublicRoute = publicRoutes.contains(currentLocation);

      return authState.when(
        initial: () => RouteNames.splash,
        loading: () => RouteNames.splash,

        authenticated: (user) {
          if (user.isGuest && currentLocation == RouteNames.linkAccount) {
            return null;
          }

          if (!user.isGuest && currentLocation == RouteNames.linkAccount) {
            return RouteNames.home;
          }

          if (isPublicRoute && currentLocation != RouteNames.splash) {
            return RouteNames.home;
          }

          if (currentLocation == RouteNames.splash) {
            return RouteNames.home;
          }

          return null;
        },

        unauthenticated: () {
          if (currentLocation == RouteNames.linkAccount) {
            return RouteNames.login;
          }

          if (!isPublicRoute && currentLocation != RouteNames.splash) {
            return RouteNames.login;
          }

          if (currentLocation == RouteNames.splash) {
            return RouteNames.login;
          }

          return null;
        },

        error: (_) {
          if (!isPublicRoute && currentLocation != RouteNames.splash) {
            return RouteNames.login;
          }
          if (currentLocation == RouteNames.splash) {
            return RouteNames.login;
          }
          return null;
        },
      );
    },

    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteNames.noAccount,
        name: 'noAccount',
        builder: (context, state) => const NoAccountScreen(),
      ),
      GoRoute(
        path: RouteNames.linkAccount,
        name: 'linkAccount',
        builder: (context, state) {
          final guestUserId = state.uri.queryParameters['guestUserId'] ?? '';
          final guestUserName =
              state.uri.queryParameters['guestUserName'] ?? '';
          return LinkAccountScreen(
            guestUserId: guestUserId,
            guestUserName: guestUserName,
          );
        },
      ),

      GoRoute(
        path: RouteNames.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const ProfileScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position:
                            Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeInOut,
                              ),
                            ),
                        child: child,
                      );
                    },
              );
            },
          ),

          GoRoute(
            path: 'new',
            name: 'newTask',
            builder: (context, state) => const TaskFormScreen(),
          ),

          GoRoute(
            path: 'edit',
            name: 'editTask',
            builder: (context, state) {
              final task = state.extra as TaskEntitie?;
              return TaskFormScreen(initialTask: task);
            },
          ),

          GoRoute(
            path: ':taskId',
            name: 'taskDetail',
            builder: (context, state) {
              final taskId = state.pathParameters['taskId'] ?? '';
              return TaskDetailScreen(taskId: taskId);
            },
          ),

          GoRoute(
            path: 'pokemon/favorites',
            name: 'pokemonFavorites',
            builder: (context, state) => const FavoritePokemonScreen(),
          ),
          GoRoute(
            path: 'pokemon/detail/:id',
            name: 'pokemonDetail',
            builder: (context, state) {
              final pokemonId =
                  int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
              return PokemonDetailScreen(pokemonId: pokemonId);
            },
          ),
        ],
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Ruta no encontrada: ${state.error}')),
    ),
  );
});
