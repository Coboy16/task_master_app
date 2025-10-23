import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/feactures.dart';

import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,

    // Redirect automático basado en estado de autenticación
    redirect: (context, state) {
      final authState = ref.read(authProvider).value;

      // Rutas públicas (permitidas sin autenticación)
      final publicRoutes = [
        RouteNames.splash,
        RouteNames.login,
        RouteNames.register,
        RouteNames.noAccount,
      ];

      final currentLocation = state.matchedLocation;
      final isPublicRoute = publicRoutes.contains(currentLocation);

      return authState?.when(
        initial: () => null, // Permitir navegación inicial
        loading: () => null, // No redirigir mientras carga
        authenticated: (_) {
          // Usuario autenticado intentando acceder a rutas públicas → HOME
          if (isPublicRoute && currentLocation != RouteNames.splash) {
            return RouteNames.home;
          }
          return null; // Permitir acceso a rutas protegidas
        },
        unauthenticated: () {
          // Usuario no autenticado intentando acceder a rutas protegidas → LOGIN
          if (!isPublicRoute) {
            return RouteNames.login;
          }
          return null; // Permitir acceso a rutas públicas
        },
        error: (_) {
          // En caso de error, redirigir a LOGIN
          if (!isPublicRoute) {
            return RouteNames.login;
          }
          return null;
        },
      );
    },

    routes: [
      // ==================== AUTH ROUTES ====================
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
        builder: (context, state) {
          // Obtener guestUserId si viene de migración
          final guestUserId = state.uri.queryParameters['guestUserId'];
          return RegisterScreen(guestUserId: guestUserId);
        },
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
          // Obtener parámetros del usuario guest
          final guestUserId = state.uri.queryParameters['guestUserId'] ?? '';
          final guestUserName =
              state.uri.queryParameters['guestUserName'] ?? '';

          return LinkAccountScreen(
            guestUserId: guestUserId,
            guestUserName: guestUserName,
          );
        },
      ),

      // ==================== MAIN APP ROUTES ====================
      GoRoute(
        path: RouteNames.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // TODO: Agregar más rutas cuando estén implementadas
    ],

    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
});
