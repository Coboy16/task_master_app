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
    _setupListeners();

    final linkAccountState = ref.watch(linkAccountProvider);
    final isLoading = linkAccountState.isLoading;

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
              AuthHeader(
                title: 'Vincular cuenta',
                subtitle:
                    'Crea una cuenta en la nube para sincronizar tus tareas en todos tus dispositivos.',
                leading: const LogoWidget(
                  size: 64,
                  icon: LucideIcons.cloudUpload,
                  backgroundColor: Color(0xFFf3f4f6),
                  iconColor: Color(0xFF6b7280),
                ),
              ),
              const SizedBox(height: 32),
              _buildCurrentUserCard(),
              const SizedBox(height: 32),
              _buildLinkForm(isLoading),
            ],
          ),
        ),
      ),
    );
  }

  void _setupListeners() {
    ref.listen<AsyncValue<AuthState>>(authProvider, (_, state) {
      state.whenData((authState) {
        authState.when(
          initial: () {},
          loading: () {},
          authenticated: (user) {
            if (mounted && !user.isGuest) {
              _showSuccessSnackBar();
              context.go(RouteNames.home);
            }
          },
          unauthenticated: () {},
          error: (message) {
            if (mounted) {
              _showErrorSnackBar(message);
            }
          },
        );
      });
    });

    ref.listen<AsyncValue<void>>(linkAccountProvider, (_, state) {
      state.when(
        data: (_) {},
        loading: () {},
        error: (message, __) {
          if (mounted) {
            _showErrorSnackBar(message.toString());
          }
        },
      );
    });
  }

  Widget _buildCurrentUserCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF2800C8).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              LucideIcons.user,
              size: 24,
              color: Color(0xFF2800C8),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Usuario actual',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6b7280),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.guestUserName,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1a1a1a),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkForm(bool isLoading) {
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
          const SizedBox(height: 20),
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
            onSubmitted: (_) => _handleLinkAccount(),
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Vincular cuenta',
            onPressed: _handleLinkAccount,
            isLoading: isLoading,
          ),
          const SizedBox(height: 32),
          _buildBenefitsCard(),
        ],
      ),
    );
  }

  Widget _buildBenefitsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFf9fafb),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFe5e7eb), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                LucideIcons.sparkles,
                size: 20,
                color: Color(0xFF6b7280),
              ),
              const SizedBox(width: 8),
              Text(
                'Beneficios',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1a1a1a),
                ),
              ),
            ],
          ),
          const BenefitItem(text: 'Sincronización en la nube'),
          const BenefitItem(text: 'Acceso desde múltiples dispositivos'),
          const BenefitItem(text: 'Respaldo automático de tus tareas'),
          const BenefitItem(text: 'Migración de datos locales'),
        ],
      ),
    );
  }

  void _handleLinkAccount() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      ref
          .read(linkAccountProvider.notifier)
          .migrateGuestToAuth(
            guestUserId: widget.guestUserId,
            email: values['email'] as String,
            password: values['password'] as String,
          );
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '¡Cuenta vinculada exitosamente!',
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF10b981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
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
