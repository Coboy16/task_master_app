import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '/features/auth/presentation/providers/providers.dart';

class TaskAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final bool showAvatar;
  final List<Widget>? actions;

  const TaskAppBar({
    super.key,
    required this.title,
    this.showAvatar = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider).value;

    final userName =
        authState?.maybeWhen(
          authenticated: (user) => user.name,
          orElse: () => 'Usuario',
        ) ??
        'Usuario';

    final userInitial = userName.isNotEmpty ? userName[0].toUpperCase() : 'U';

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF1a1a1a),
        ),
      ),
      leading: showAvatar
          ? Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () {
                  // Navegar al perfil o mostrar menú
                },
                child: CircleAvatar(
                  backgroundColor: const Color(0xFF2800C8),
                  child: Text(
                    userInitial,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          : null,
      actions: actions,
    );
  }
}
