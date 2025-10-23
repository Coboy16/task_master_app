import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/core/core.dart';
import '../providers/providers.dart';

class LinkAccountScreen extends ConsumerStatefulWidget {
  final String guestUserId;
  final String guestUserName;

  const LinkAccountScreen({
    super.key,
    required this.guestUserId,
    required this.guestUserName,
  });

  @override
  ConsumerState<LinkAccountScreen> createState() => _LinkAccountScreenState();
}

class _LinkAccountScreenState extends ConsumerState<LinkAccountScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Escuchar cambios en el estado de auth GLOBAL para NAVEGAR
    ref.listen<AsyncValue<AuthState>>(authProvider, (_, state) {
      state.whenData((authState) {
        authState.when(
          initial: () {},
          loading: () {},
          authenticated: (user) {
            // Migración exitosa → Navegar a HOME
            if (mounted && !user.isGuest) {
              // Mostrar mensaje de éxito
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('¡Cuenta vinculada exitosamente!'),
                  backgroundColor: Colors.green,
                ),
              );
              context.go(RouteNames.home);
            }
          },
          unauthenticated: () {},
          error: (message) {
            // Este error es del authProvider, no de la acción de vincular.
            // Lo dejamos, aunque es poco probable.
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            }
          },
        );
      });
    });

    // Escuchar SÓLO errores del controlador de VINCULAR
    ref.listen<AsyncValue<void>>(linkAccountProvider, (_, state) {
      state.when(
        data: (_) {}, // Éxito, el authProvider de arriba navegará
        loading: () {}, // El botón se encarga
        error: (message, __) {
          // Mostrar error de la acción de vincular
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

    // Observar estado de carga del controlador de VINCULAR
    final linkAccountState = ref.watch(linkAccountProvider);
    final isLoading = linkAccountState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Vincular cuenta'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ... (El resto de tu UI no cambia) ...
                const SizedBox(height: 32),
                Icon(
                  Icons.cloud_upload_outlined,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                Text(
                  'Vincula tu cuenta',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Crea una cuenta en la nube para sincronizar tus tareas y acceder desde cualquier dispositivo.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.orange.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Usuario actual',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange.shade900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.guestUserName,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.orange.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

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
                  onSubmitted: (_) => _handleLinkAccount(),
                ),
                const SizedBox(height: 32),

                // Botón Vincular cuenta
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : _handleLinkAccount, // Actualizado
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
                          'Vincular cuenta',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
                // ... (El resto de tu UI no cambia) ...
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '¿Qué pasará?',
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '• Tus tareas se subirán a la nube\n'
                        '• Podrás acceder desde otros dispositivos\n'
                        '• Tus datos estarán sincronizados\n'
                        '• Los datos locales se eliminarán',
                        style: TextStyle(
                          color: Colors.blue.shade900,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Manejar la vinculación de cuenta
  void _handleLinkAccount() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;

      // Llamar al nuevo controlador
      ref
          .read(linkAccountProvider.notifier)
          .migrateGuestToAuth(
            guestUserId: widget.guestUserId,
            email: values['email'] as String,
            password: values['password'] as String,
          );
    }
  }
}
