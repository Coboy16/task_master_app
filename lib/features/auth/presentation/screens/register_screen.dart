import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '/core/core.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

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
    ref.listen<AsyncValue<void>>(registerProvider, (_, state) {
      state.when(
        data: (_) {},
        loading: () {},
        error: (message, __) {
          if (mounted) {
            _showErrorSnackBar(context, message.toString());
          }
        },
      );
    });

    final registerState = ref.watch(registerProvider);
    final isLoading = registerState.isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Color(0xFF1a1a1a)),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(
                title: 'Crear cuenta',
                subtitle: 'Completa tus datos para comenzar',
              ),
              const SizedBox(height: 40),
              _buildRegisterForm(isLoading),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm(bool isLoading) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            name: 'name',
            label: 'Nombre completo',
            hintText: 'Tu nombre',
            prefixIcon: LucideIcons.user,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: 'El nombre es requerido',
              ),
              FormBuilderValidators.minLength(
                2,
                errorText: 'Mínimo 2 caracteres',
              ),
            ]),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            name: 'email',
            label: 'Email',
            hintText: 'tu@email.com',
            prefixIcon: LucideIcons.mail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: 'El email es requerido',
              ),
              FormBuilderValidators.email(errorText: 'Email inválido'),
            ]),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            name: 'password',
            label: 'Contraseña',
            hintText: '••••••••',
            prefixIcon: LucideIcons.lock,
            obscureText: !_isPasswordVisible,
            textInputAction: TextInputAction.next,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? LucideIcons.eyeOff : LucideIcons.eye,
                size: 20,
                color: const Color(0xFF6b7280),
              ),
              onPressed: () {
                setState(() => _isPasswordVisible = !_isPasswordVisible);
              },
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: 'La contraseña es requerida',
              ),
              FormBuilderValidators.minLength(
                6,
                errorText: 'Mínimo 6 caracteres',
              ),
            ]),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            name: 'confirmPassword',
            label: 'Confirmar contraseña',
            hintText: '••••••••',
            prefixIcon: LucideIcons.lock,
            obscureText: !_isConfirmPasswordVisible,
            textInputAction: TextInputAction.done,
            suffixIcon: IconButton(
              icon: Icon(
                _isConfirmPasswordVisible
                    ? LucideIcons.eyeOff
                    : LucideIcons.eye,
                size: 20,
                color: const Color(0xFF6b7280),
              ),
              onPressed: () {
                setState(
                  () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible,
                );
              },
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: 'Confirma tu contraseña',
              ),
              (val) {
                if (_formKey.currentState?.fields['password']?.value != val) {
                  return 'Las contraseñas no coinciden';
                }
                return null;
              },
            ]),
            onSubmitted: (_) => _handleRegister(),
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Crear cuenta',
            onPressed: _handleRegister,
            isLoading: isLoading,
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: isLoading ? null : () => context.go(RouteNames.login),
              child: RichText(
                text: TextSpan(
                  text: '¿Ya tienes cuenta? ',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: const Color(0xFF6b7280),
                  ),
                  children: [
                    TextSpan(
                      text: 'Inicia sesión',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2800C8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleRegister() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      ref
          .read(registerProvider.notifier)
          .registerWithEmail(
            name: values['name'] as String,
            email: values['email'] as String,
            password: values['password'] as String,
          );
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF1a1a1a),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
