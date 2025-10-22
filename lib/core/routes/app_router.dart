import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/feactures.dart';

import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,

    redirect: (context, state) {
      // TODO: Implementar lógica de redirect cuando tengamos el authProvider
      // final isAuthenticated = authState.maybeWhen(
      //   authenticated: (_) => true,
      //   orElse: () => false,
      // );

      // Por ahora, no hacemos redirect
      return null;
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
    ],

    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
});
