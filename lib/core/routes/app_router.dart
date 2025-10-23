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
        RouteNames.linkAccount,
      ];
      final isPublicRoute = publicRoutes.contains(currentLocation);

      return authState.when(
        initial: () => RouteNames.splash,
        loading: () => RouteNames.splash,

        authenticated: (_) {
          // Si está autenticado y en una ruta pública (que no sea splash)
          if (isPublicRoute && currentLocation != RouteNames.splash) {
            return RouteNames.home;
          }
          // Si está autenticado y en splash, llévalo a home
          if (currentLocation == RouteNames.splash) {
            return RouteNames.home;
          }
          // En cualquier otro caso (ya en home o subrutas), déjalo estar
          return null;
        },

        unauthenticated: () {
          // Si no está autenticado y está en una ruta protegida
          if (!isPublicRoute && currentLocation != RouteNames.splash) {
            return RouteNames.login;
          }
          // Si no está autenticado y está en splash (después de cargar), llévalo a login
          if (currentLocation == RouteNames.splash) {
            return RouteNames.login;
          }
          // En cualquier otro caso (ya en login, register, etc.), déjalo estar
          return null;
        },

        error: (_) {
          // Si hay error, tratar como no autenticado
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
        ],
      ),
    ],

    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Ruta no encontrada: ${state.error}')),
    ),
  );
});
