import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '/core/core.dart';
import '/features/auth/presentation/providers/providers.dart';
import '/features/tasks/presentation/providers/providers.dart';
import '/features/tasks/presentation/widgets/widgets.dart';

class TasksListScreen extends ConsumerStatefulWidget {
  const TasksListScreen({super.key});

  @override
  ConsumerState<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends ConsumerState<TasksListScreen> {
  Future<void> _refreshTasks() async {
    await ref.read(tasksProvider.notifier).refreshTasks();
  }

  Future<void> _toggleTask(String taskId) async {
    final success = await ref
        .read(toggleTaskControllerProvider.notifier)
        .toggleTaskCompletion(taskId);
    if (success && mounted) {
      await ref.read(tasksProvider.notifier).refreshTasks();
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final tasksState = ref.watch(tasksProvider);
    final authState = ref.watch(authProvider).value;
    final bool isGuest =
        authState?.maybeWhen(
          authenticated: (user) => user.isGuest,
          orElse: () => true,
        ) ??
        true;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TaskAppBar(
        title: 'Mis Tareas',
        actions: [
          if (!isGuest)
            IconButton(
              icon: const Icon(
                LucideIcons.refreshCw,
                color: Color(0xFF6b7280),
                size: 20,
              ),
              tooltip: 'Sincronizar',
              onPressed: () {
                ref.read(syncTasksControllerProvider.notifier).syncTasks();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Sincronizando...',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    backgroundColor: const Color(0xFF1a1a1a),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              },
            ),
          IconButton(
            icon: const Icon(
              LucideIcons.cloudDownload,
              color: Color(0xFF6b7280),
              size: 20,
            ),
            tooltip: 'Importar de API',
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Obteniendo tareas...',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: const Color(0xFF1a1a1a),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(16),
                  duration: const Duration(seconds: 30),
                ),
              );

              try {
                final success = await ref
                    .read(fetchApiTasksControllerProvider.notifier)
                    .fetchTasksFromApi();
                if (!mounted) return;

                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                if (success) {
                  await ref.read(tasksProvider.notifier).refreshTasks();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(
                              LucideIcons.circleCheck,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Tareas importadas',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: const Color(0xFF10b981),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.all(16),
                      ),
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error: $e',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: const Color(0xFFef4444),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(16),
                    ),
                  );
                }
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          tasksState.when(
            data: (state) => state.maybeWhen(
              loaded: (tasks, stats) {
                if (stats != null) {
                  return TaskStatsBar(stats: stats);
                }
                return const SizedBox.shrink();
              },
              orElse: () => const SizedBox.shrink(),
            ),
            loading: () => const SizedBox(
              height: 120,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),
          Expanded(
            child: tasksState.when(
              data: (state) => state.when(
                initial: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2800C8)),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2800C8)),
                ),
                error: (message) => Center(
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
                        message,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6b7280),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _refreshTasks,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2800C8),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Reintentar',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                loaded: (tasks, stats) {
                  if (tasks.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: _refreshTasks,
                      color: const Color(0xFF2800C8),
                      child: ListView(
                        children: const [
                          SizedBox(height: 100),
                          EmptyState(
                            message:
                                'No tienes tareas aún.\n¡Crea tu primera tarea!',
                            icon: LucideIcons.inbox,
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: _refreshTasks,
                    color: const Color(0xFF2800C8),
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 100),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return TaskItem(
                          task: task,
                          onTap: () {
                            context.push('${RouteNames.home}/${task.id}');
                          },
                          onToggle: () => _toggleTask(task.id),
                          onEdit: () {
                            context.push(
                              '${RouteNames.home}/edit',
                              extra: task,
                            );
                          },
                          onDelete: () {
                            _showDeleteConfirmation(task.id);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(color: Color(0xFF2800C8)),
              ),
              error: (e, s) => Center(
                child: Text(
                  'Error: $e',
                  style: GoogleFonts.inter(color: const Color(0xFF6b7280)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
