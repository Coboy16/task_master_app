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
    ref.listen<AsyncValue<void>>(loginProvider, (_, state) {
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

    final loginState = ref.watch(loginProvider);
    final isLoading = loginState.isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              AuthHeader(
                title: 'Bienvenido',
                subtitle: 'Ingresa a tu cuenta para continuar',
                leading: const LogoWidget(size: 56),
              ),
              const SizedBox(height: 48),
              _buildLoginForm(isLoading),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(bool isLoading) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
          const SizedBox(height: 24),
          CustomTextField(
            name: 'password',
            label: 'Contraseña',
            hintText: '••••••••',
            prefixIcon: LucideIcons.lock,
            obscureText: !_isPasswordVisible,
            textInputAction: TextInputAction.done,
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
            onSubmitted: (_) => _handleLogin(),
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Iniciar sesión',
            onPressed: _handleLogin,
            isLoading: isLoading,
          ),
          const SizedBox(height: 24),
          _buildDivider(),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Crear cuenta',
            type: ButtonType.secondary,
            onPressed: isLoading
                ? null
                : () => context.push(RouteNames.register),
          ),
          const SizedBox(height: 16),
          Center(
            child: CustomButton(
              text: 'Continuar sin cuenta',
              type: ButtonType.text,
              onPressed: isLoading
                  ? null
                  : () => context.push(RouteNames.noAccount),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFe5e7eb), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'o',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: const Color(0xFF9ca3af),
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFe5e7eb), thickness: 1)),
      ],
    );
  }

  void _handleLogin() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      ref
          .read(loginProvider.notifier)
          .loginWithEmail(
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
