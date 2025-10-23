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

class NoAccountScreen extends ConsumerStatefulWidget {
  const NoAccountScreen({super.key});

  @override
  ConsumerState<NoAccountScreen> createState() => _NoAccountScreenState();
}

class _NoAccountScreenState extends ConsumerState<NoAccountScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(guestProvider, (_, state) {
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

    final guestState = ref.watch(guestProvider);
    final isLoading = guestState.isLoading;

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
                title: 'Modo invitado',
                subtitle:
                    'Usa la app sin crear una cuenta. Tus datos se guardarán localmente en este dispositivo.',
                leading: const LogoWidget(
                  size: 64,
                  icon: LucideIcons.circleUser,
                  backgroundColor: Color(0xFFf3f4f6),
                  iconColor: Color(0xFF6b7280),
                ),
              ),
              const SizedBox(height: 40),
              _buildGuestForm(isLoading),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuestForm(bool isLoading) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            name: 'name',
            label: '¿Cómo te llamas?',
            hintText: 'Tu nombre',
            prefixIcon: LucideIcons.user,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: 'El nombre es requerido',
              ),
              FormBuilderValidators.minLength(
                2,
                errorText: 'Mínimo 2 caracteres',
              ),
            ]),
            onSubmitted: (_) => _handleContinue(),
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Continuar',
            onPressed: _handleContinue,
            isLoading: isLoading,
          ),
          const SizedBox(height: 32),
          const InfoCard(
            icon: LucideIcons.info,
            text:
                'Podrás crear una cuenta más adelante para sincronizar tus tareas en la nube.',
          ),
          const SizedBox(height: 24),
          Center(
            child: CustomButton(
              text: 'Prefiero crear una cuenta',
              type: ButtonType.text,
              onPressed: isLoading
                  ? null
                  : () => context.go(RouteNames.register),
            ),
          ),
        ],
      ),
    );
  }

  void _handleContinue() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      ref
          .read(guestProvider.notifier)
          .createGuestUser(values['name'] as String);
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
