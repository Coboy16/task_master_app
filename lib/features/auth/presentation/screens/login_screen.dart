import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../providers/providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios en el estado de auth
    ref.listen<AsyncValue<AuthState>>(authProvider, (_, state) {
      state.whenData((authState) {
        authState.when(
          initial: () {},
          loading: () {},
          authenticated: (_) {
            // Login exitoso → Navegar a HOME
            if (mounted) {
              context.go(RouteNames.home);
            }
          },
          unauthenticated: () {},
          error: (message) {
            // Mostrar error
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            }
          },
        );
      });
    });

    // Verificar si está en loading
    final authState = ref.watch(authProvider).value;
    final isLoading =
        authState?.maybeWhen(loading: () => true, orElse: () => false) ?? false;

    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),

                // Título
                Text(
                  'Bienvenido de nuevo',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Ingresa tus credenciales para continuar',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Campo Email
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'ejemplo@email.com',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'El email es requerido',
                    ),
                    FormBuilderValidators.email(errorText: 'Email inválido'),
                  ]),
                ),
                const SizedBox(height: 16),

                // Campo Password
                FormBuilderTextField(
                  name: 'password',
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: !_isPasswordVisible,
                  textInputAction: TextInputAction.done,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'La contraseña es requerida',
                    ),
                    FormBuilderValidators.minLength(
                      6,
                      errorText:
                          'La contraseña debe tener al menos 6 caracteres',
                    ),
                  ]),
                  onSubmitted: (_) => _handleLogin(),
                ),
                const SizedBox(height: 24),

                // Botón Iniciar sesión
                ElevatedButton(
                  onPressed: isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Iniciar sesión',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
                const SizedBox(height: 16),

                // Divider con "O"
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'O',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),

                // Link a crear cuenta
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.push(RouteNames.register),
                  child: const Text('¿No tienes cuenta? Regístrate'),
                ),
                const SizedBox(height: 8),

                // Link a continuar sin cuenta
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.push(RouteNames.noAccount),
                  child: Text(
                    'Continuar sin cuenta',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Manejar el login
  void _handleLogin() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;

      ref
          .read(authProvider.notifier)
          .loginWithEmail(
            email: values['email'] as String,
            password: values['password'] as String,
          );
    }
  }
}
