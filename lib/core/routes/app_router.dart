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

        authenticated: (_) {
          if (isPublicRoute) {
            return RouteNames.home;
          }
          return null;
        },

        unauthenticated: () {
          if (!isPublicRoute) {
            return RouteNames.login;
          }
          if (currentLocation == RouteNames.splash) {
            return RouteNames.login;
          }
          return null;
        },

        error: (_) {
          if (!isPublicRoute) {
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
        builder: (context, state) {
          return RegisterScreen();
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
      ),
    ],

    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Error: ${state.error}'))),
  );
});
