import 'package:flutter/material.dart';

import 'package:lucide_icons_flutter/lucide_icons.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;

  const LogoWidget({
    super.key,
    this.size = 56,
    this.icon,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFF2800C8),
        borderRadius: BorderRadius.circular(size * 0.28),
      ),
      child: Icon(
        icon ?? LucideIcons.circleCheck,
        size: size * 0.57,
        color: iconColor ?? Colors.white,
      ),
    );
  }
}
