import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String message;
  final String cancelText;
  final String confirmText;
  final Color? confirmColor;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  const ConfirmationModal({
    super.key,
    required this.title,
    required this.message,
    this.cancelText = 'Cancelar',
    this.confirmText = 'Confirmar',
    this.confirmColor,
    this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1a1a1a),
              ),
            ),
            const SizedBox(height: 16.0),

            // Mensaje
            Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6b7280),
              ),
            ),
            const SizedBox(height: 24.0),

            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Botón Cancelar
                TextButton(
                  onPressed: onCancel ?? () => Navigator.of(context).pop(false),
                  child: Text(
                    cancelText,
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6b7280),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),

                // Botón Confirmar
                ElevatedButton(
                  onPressed: onConfirm ?? () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: confirmColor ?? const Color(0xFF2800C8),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: Text(
                    confirmText,
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método estático para mostrar el modal fácilmente
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String cancelText = 'Cancelar',
    String confirmText = 'Confirmar',
    Color? confirmColor,
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return ConfirmationModal(
          title: title,
          message: message,
          cancelText: cancelText,
          confirmText: confirmText,
          confirmColor: confirmColor,
          onCancel: onCancel,
          onConfirm: onConfirm,
        );
      },
    );
  }
}
