import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '/core/core.dart';
import '/features/tasks/data/data.dart';
import '/features/tasks/domain/domain.dart';
import '/features/tasks/presentation/providers/providers.dart';

class TaskDetailScreen extends ConsumerStatefulWidget {
  final String taskId;
  const TaskDetailScreen({super.key, required this.taskId});

  @override
  ConsumerState<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends ConsumerState<TaskDetailScreen> {
  void _showDeleteConfirmation(String taskId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Eliminar Tarea',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1a1a1a),
          ),
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar esta tarea?',
          style: GoogleFonts.inter(color: const Color(0xFF6b7280)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6b7280),
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(deleteTaskControllerProvider.notifier)
                  .deleteTask(taskId);
              if (success && mounted) {
                ref.read(tasksProvider.notifier).refreshTasks();
                context.pop();
              }
            },
            child: Text(
              'Eliminar',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: const Color(0xFFef4444),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleStatus(TaskEntitie task) async {
    final success = await ref
        .read(toggleTaskControllerProvider.notifier)
        .toggleTaskCompletion(task.id);

    if (success && mounted) {
      await ref.read(tasksProvider.notifier).refreshTasks();
      ref.invalidate(taskDetailProvider(widget.taskId));
    }
  }

  void _editTask(TaskEntitie task) {
    context.push('${RouteNames.home}/edit', extra: task);
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMM y, h:mm a', 'es').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final taskAsync = ref.watch(taskDetailProvider(widget.taskId));

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
          'Detalle',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1a1a1a),
          ),
        ),
        actions: [
          taskAsync.when(
            data: (task) {
              if (task == null) return const SizedBox.shrink();
              return Row(
                children: [
                  if (task.source != TaskSource.api)
                    IconButton(
                      icon: const Icon(
                        LucideIcons.pencilLine,
                        color: Color(0xFF6b7280),
                        size: 20,
                      ),
                      onPressed: () => _editTask(task),
                    ),
                  IconButton(
                    icon: const Icon(
                      LucideIcons.trash2,
                      color: Color(0xFFef4444),
                      size: 20,
                    ),
                    onPressed: () => _showDeleteConfirmation(task.id),
                  ),
                  const SizedBox(width: 8),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: taskAsync.when(
        data: (task) {
          if (task == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    LucideIcons.searchX,
                    size: 64,
                    color: Color(0xFF9ca3af),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tarea no encontrada',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6b7280),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2800C8),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Volver',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Estado
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: task.isCompleted
                            ? const Color(0xFF10b981).withOpacity(0.1)
                            : const Color(0xFFf59e0b).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        task.isCompleted
                            ? LucideIcons.circleCheck
                            : LucideIcons.clock,
                        color: task.isCompleted
                            ? const Color(0xFF10b981)
                            : const Color(0xFFf59e0b),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      task.isCompleted ? 'Completada' : 'Pendiente',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: task.isCompleted
                            ? const Color(0xFF10b981)
                            : const Color(0xFFf59e0b),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Título
                Text(
                  task.title,
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1a1a1a),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 24),

                // Chips info
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(
                      icon: LucideIcons.flag,
                      label: task.priorityText,
                      color: Color(task.priorityColor),
                    ),
                    _InfoChip(
                      icon: task.source == TaskSource.api
                          ? LucideIcons.cloud
                          : task.source == TaskSource.firebase
                          ? LucideIcons.cloudCheck
                          : LucideIcons.smartphone,
                      label: task.sourceText,
                      color: const Color(0xFF6b7280),
                    ),
                    if (task.source != TaskSource.api)
                      _InfoChip(
                        icon: task.synced
                            ? LucideIcons.circleCheck
                            : LucideIcons.clock,
                        label: task.synced ? 'Sincronizado' : 'Pendiente',
                        color: task.synced
                            ? const Color(0xFF10b981)
                            : const Color(0xFFf59e0b),
                      ),
                  ],
                ),
                const SizedBox(height: 32),

                // Descripción
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFf9fafb),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFe5e7eb),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            LucideIcons.textAlignStart,
                            size: 18,
                            color: Color(0xFF6b7280),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Descripción',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1a1a1a),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        task.description.isEmpty
                            ? 'Sin descripción'
                            : task.description,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: task.description.isEmpty
                              ? const Color(0xFF9ca3af)
                              : const Color(0xFF4b5563),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Fechas
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFf9fafb),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFe5e7eb),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      _DateRow(
                        icon: LucideIcons.calendar,
                        label: 'Creada',
                        date: _formatDate(task.createdAt),
                      ),
                      const SizedBox(height: 16),
                      _DateRow(
                        icon: LucideIcons.clock,
                        label: 'Actualizada',
                        date: _formatDate(task.updatedAt),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Botón acción
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => _toggleStatus(task),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: task.isCompleted
                          ? const Color(0xFFf59e0b)
                          : const Color(0xFF10b981),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          task.isCompleted
                              ? LucideIcons.rotateCcw
                              : LucideIcons.circleCheck,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          task.isCompleted
                              ? 'Marcar como pendiente'
                              : 'Marcar como completada',
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
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Color(0xFF2800C8)),
        ),
        error: (e, s) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.circleAlert,
                color: Color(0xFFef4444),
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Error al cargar',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1a1a1a),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                e.toString(),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFF6b7280),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2800C8),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Volver',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String date;

  const _DateRow({required this.icon, required this.label, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF6b7280)),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9ca3af),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              date,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4b5563),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
