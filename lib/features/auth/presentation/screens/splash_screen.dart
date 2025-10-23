import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../providers/providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  /// Verificar estado de autenticación al iniciar
  Future<void> _checkAuthStatus() async {
    // Esperar mínimo 2 segundos para mejor UX
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      await ref.read(authProvider.notifier).checkAuthStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios en el estado de auth
    ref.listen<AsyncValue<AuthState>>(authProvider, (_, state) {
      state.whenData((authState) {
        authState.when(
          initial: () {}, // No hacer nada
          loading: () {}, // Mostrar loading
          authenticated: (_) {
            // Usuario autenticado → Navegar a HOME
            if (mounted) {
              context.go(RouteNames.home);
            }
          },
          unauthenticated: () {
            // Sin sesión → Navegar a LOGIN
            if (mounted) {
              context.go(RouteNames.login);
            }
          },
          error: (message) {
            // En caso de error, ir a LOGIN
            if (mounted) {
              context.go(RouteNames.login);
            }
          },
        );
      });
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo o ícono de la app
            Icon(
              Icons.task_alt,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 24),

            // Nombre de la app
            Text(
              'TaskMaster Pro',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Tagline
            Text(
              'Organiza tus tareas',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 48),

            // Loading indicator
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
