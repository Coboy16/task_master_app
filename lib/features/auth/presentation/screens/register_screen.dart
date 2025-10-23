import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../providers/providers.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Escuchar SÓLO errores del controlador de registro
    ref.listen<AsyncValue<void>>(registerProvider, (_, state) {
      state.when(
        data: (_) {}, // Éxito, el authProvider global navegará
        loading: () {}, // El botón se encarga
        error: (message, __) {
          // Mostrar error
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      );
    });

    // Observar estado de carga del controlador de registro
    final registerState = ref.watch(registerProvider);
    final isLoading = registerState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Crear cuenta'), centerTitle: true),
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
                  'Crea tu cuenta',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Completa tus datos para registrarte',
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
                    labelText: 'Nombre',
                    hintText: 'Ingresa tu nombre completo',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'El nombre es requerido',
                    ),
                    FormBuilderValidators.minLength(
                      2,
                      errorText: 'El nombre debe tener al menos 2 caracteres',
                    ),
                  ]),
                ),
                const SizedBox(height: 16),

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
                    helperText: 'Mínimo 6 caracteres',
                  ),
                  obscureText: !_isPasswordVisible,
                  textInputAction: TextInputAction.next,
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
                ),
                const SizedBox(height: 16),

                // Campo Confirmar Password
                FormBuilderTextField(
                  name: 'confirmPassword',
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    hintText: '••••••••',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: !_isConfirmPasswordVisible,
                  textInputAction: TextInputAction.done,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Debes confirmar la contraseña',
                    ),
                    (val) {
                      if (_formKey.currentState?.fields['password']?.value !=
                          val) {
                        return 'Las contraseñas no coinciden';
                      }
                      return null;
                    },
                  ]),
                  onSubmitted: (_) => _handleRegister(),
                ),
                const SizedBox(height: 32),

                // Botón Registrarse
                ElevatedButton(
                  onPressed: isLoading ? null : _handleRegister,
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
                          'Registrarse',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
                const SizedBox(height: 24),

                // Link a iniciar sesión
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.go(RouteNames.login),
                  child: const Text('¿Ya tienes cuenta? Inicia sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Manejar el registro
  void _handleRegister() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;

      // Llamar al nuevo controlador
      ref
          .read(registerProvider.notifier)
          .registerWithEmail(
            name: values['name'] as String,
            email: values['email'] as String,
            password: values['password'] as String,
          );
    }
  }
}
