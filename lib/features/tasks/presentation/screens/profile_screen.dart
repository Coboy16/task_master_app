import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:task_master/shared/shared.dart';

import '/features/auth/presentation/providers/providers.dart';
import '/features/auth/domain/domain.dart';
import '/core/core.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).value;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Color(0xFF1a1a1a)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Perfil',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1a1a1a),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              LucideIcons.logOut,
              color: Color(0xFFef4444),
              size: 20,
            ),
            tooltip: 'Cerrar sesión',
            onPressed: () async {
              _showLogoutDialog(context, ref);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: authState == null
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF2800C8)),
            )
          : authState.maybeWhen(
              authenticated: (user) => _buildProfile(context, ref, user),
              orElse: () => const Center(
                child: CircularProgressIndicator(color: Color(0xFF2800C8)),
              ),
            ),
    );
  }

  Widget _buildProfile(BuildContext context, WidgetRef ref, User user) {
    final userInitial = user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          Hero(
            tag: 'profile-avatar',
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2800C8), Color(0xFF1a0080)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2800C8).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  userInitial,
                  style: GoogleFonts.inter(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          Text(
            user.name,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1a1a1a),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          if (user.email != null && user.email!.isNotEmpty)
            Text(
              user.email!,
              style: GoogleFonts.inter(
                fontSize: 15,
                color: const Color(0xFF6b7280),
              ),
              textAlign: TextAlign.center,
            ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: user.isGuest
                  ? const Color(0xFFf59e0b).withOpacity(0.1)
                  : const Color(0xFF10b981).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: user.isGuest
                    ? const Color(0xFFf59e0b)
                    : const Color(0xFF10b981),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  user.isGuest
                      ? LucideIcons.smartphone
                      : LucideIcons.cloudCheck,
                  size: 16,
                  color: user.isGuest
                      ? const Color(0xFFf59e0b)
                      : const Color(0xFF10b981),
                ),
                const SizedBox(width: 8),
                Text(
                  user.isGuest ? 'Cuenta Local' : 'Cuenta en la Nube',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: user.isGuest
                        ? const Color(0xFFf59e0b)
                        : const Color(0xFF10b981),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          if (user.isGuest)
            _buildGuestSection(context, user)
          else
            _buildAuthSection(context),

          const SizedBox(height: 32),

          _buildOptionsSection(context, ref, user),
        ],
      ),
    );
  }

  Widget _buildGuestSection(BuildContext context, User user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFfef3c7),
            const Color(0xFFfde68a).withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFf59e0b).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.cloudOff,
              size: 40,
              color: Color(0xFFf59e0b),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Modo Local',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF78350f),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tus tareas solo están guardadas en este dispositivo',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF92400e),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                context.push(
                  Uri(
                    path: RouteNames.linkAccount,
                    queryParameters: {
                      'guestUserId': user.id,
                      'guestUserName': user.name,
                    },
                  ).toString(),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFf59e0b),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(LucideIcons.cloudUpload, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Vincular con la Nube',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFd1fae5),
            const Color(0xFFa7f3d0).withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF10b981).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.cloudCheck,
              size: 40,
              color: Color(0xFF10b981),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '¡Todo Sincronizado!',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF065f46),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tus tareas están seguras en la nube y disponibles en todos tus dispositivos',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFF047857),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsSection(BuildContext context, WidgetRef ref, User user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Configuración',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1a1a1a),
          ),
        ),
        const SizedBox(height: 16),

        _OptionTile(
          icon: LucideIcons.user,
          title: 'Información de cuenta',
          subtitle: user.isGuest ? 'Cuenta local' : 'Cuenta vinculada',
          onTap: () {},
        ),

        const SizedBox(height: 8),

        _OptionTile(
          icon: LucideIcons.hash,
          title: 'ID de Usuario',
          subtitle: user.id.length > 20
              ? '${user.id.substring(0, 20)}...'
              : user.id,
          onTap: () {
            _showInfoDialog(context, 'ID de Usuario', user.id);
          },
        ),

        const SizedBox(height: 8),

        _OptionTile(
          icon: LucideIcons.logOut,
          title: 'Cerrar Sesión',
          subtitle: 'Salir de tu cuenta',
          iconColor: const Color(0xFFef4444),
          titleColor: const Color(0xFFef4444),
          onTap: () {
            _showLogoutDialog(context, ref);
          },
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) async {
    final result = await ConfirmationModal.show(
      context,
      title: 'Cerrar Sesión',
      message: '¿Estás seguro de que deseas cerrar sesión?',
      cancelText: 'Cancelar',
      confirmText: 'Cerrar Sesión',
      confirmColor: const Color(0xFFef4444),
    );

    if (result == true) {
      await ref.read(authProvider.notifier).logout();
    }
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1a1a1a),
          ),
        ),
        content: SelectableText(
          content,
          style: GoogleFonts.inter(
            color: const Color(0xFF6b7280),
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cerrar',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2800C8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? titleColor;

  const _OptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFfafafa),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFe5e7eb), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (iconColor ?? const Color(0xFF2800C8)).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: iconColor ?? const Color(0xFF2800C8),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: titleColor ?? const Color(0xFF1a1a1a),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: const Color(0xFF6b7280),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: Color(0xFF9ca3af),
            ),
          ],
        ),
      ),
    );
  }
}
