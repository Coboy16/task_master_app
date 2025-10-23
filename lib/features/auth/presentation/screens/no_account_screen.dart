import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../providers/providers.dart';

class NoAccountScreen extends ConsumerStatefulWidget {
  const NoAccountScreen({super.key});

  @override
  ConsumerState<NoAccountScreen> createState() => _NoAccountScreenState();
}

class _NoAccountScreenState extends ConsumerState<NoAccountScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios en el estado de auth
    ref.listen<AsyncValue<AuthState>>(authProvider, (_, state) {
      state.whenData((authState) {
        authState.when(
          initial: () {},
          loading: () {},
          authenticated: (_) {
            // Usuario invitado creado → Navegar a HOME
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
      appBar: AppBar(
        title: const Text('Continuar sin cuenta'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),

                // Ícono
                Icon(
                  Icons.person_outline,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),

                // Título
                Text(
                  'Modo Invitado',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Descripción
                Text(
                  'Usa la app sin crear cuenta. Tus datos se guardan localmente en este dispositivo.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Campo Nombre
                FormBuilderTextField(
                  name: 'name',
                  decoration: const InputDecoration(
                    labelText: '¿Cómo te llamas?',
                    hintText: 'Ingresa tu nombre',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'El nombre es requerido',
                    ),
                    FormBuilderValidators.minLength(
                      2,
                      errorText: 'El nombre debe tener al menos 2 caracteres',
                    ),
                  ]),
                  onSubmitted: (_) => _handleContinue(),
                ),
                const SizedBox(height: 32),

                // Botón Continuar
                ElevatedButton(
                  onPressed: isLoading ? null : _handleContinue,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Continuar', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 24),

                // Info adicional
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Podrás crear una cuenta más adelante para sincronizar tus tareas en la nube.',
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Link a crear cuenta
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.go(RouteNames.register),
                  child: const Text('Prefiero crear una cuenta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Manejar la creación del usuario invitado
  void _handleContinue() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;

      ref.read(authProvider.notifier).createGuestUser(values['name'] as String);
    }
  }
}
