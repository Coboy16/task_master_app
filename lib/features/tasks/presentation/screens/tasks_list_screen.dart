import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '/core/core.dart';
import '/shared/shared.dart';
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

  Future<void> _toggleTask(String taskId, bool wasCompleted) async {
    final success = await ref
        .read(toggleTaskControllerProvider.notifier)
        .toggleTaskCompletion(taskId);
    if (success && mounted) {
      await ref.read(tasksProvider.notifier).refreshTasks();

      if (!wasCompleted) {
        toastification.show(
          context: context,
          type: ToastificationType.success,
          style: ToastificationStyle.fillColored,
          title: Text(
            'Tarea completada',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          description: Text(
            'La tarea se ha marcado como completada',
            style: GoogleFonts.inter(),
          ),
          alignment: Alignment.topRight,
          autoCloseDuration: const Duration(seconds: 3),
          borderRadius: BorderRadius.circular(12),
          boxShadow: lowModeShadow,
          showProgressBar: true,
          closeButtonShowType: CloseButtonShowType.onHover,
          closeOnClick: false,
          pauseOnHover: true,
          dragToClose: true,
        );
      }
    }
  }

  void _showDeleteConfirmation(String taskId) async {
    final result = await ConfirmationModal.show(
      context,
      title: 'Eliminar Tarea',
      message: '¿Estás seguro de que deseas eliminar esta tarea?',
      cancelText: 'Cancelar',
      confirmText: 'Eliminar',
      confirmColor: const Color(0xFFef4444),
    );

    if (result == true && mounted) {
      final success = await ref
          .read(deleteTaskControllerProvider.notifier)
          .deleteTask(taskId);
      if (success && mounted) {
        ref.read(tasksProvider.notifier).refreshTasks();
      }
    }
  }

  void _showImportConfirmation() async {
    final result = await ConfirmationModal.show(
      context,
      title: 'Importar Tareas',
      message:
          '¿Deseas importar tareas desde la API?\nEsto agregará nuevas tareas a tu lista.',
      cancelText: 'Cancelar',
      confirmText: 'Importar',
    );

    if (result == true && mounted) {
      _importTasksFromApi();
    }
  }

  Future<void> _importTasksFromApi() async {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.fillColored,
      title: Text(
        'Importando tareas...',
        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
      description: Text(
        'Obteniendo tareas desde la API',
        style: GoogleFonts.inter(),
      ),
      alignment: Alignment.topRight,
      autoCloseDuration: const Duration(seconds: 30),
      borderRadius: BorderRadius.circular(12),
      boxShadow: lowModeShadow,
      showProgressBar: true,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: false,
      pauseOnHover: true,
      dragToClose: true,
    );

    try {
      final success = await ref
          .read(fetchApiTasksControllerProvider.notifier)
          .fetchTasksFromApi();

      if (!mounted) return;

      toastification.dismissAll();

      if (success) {
        await ref.read(tasksProvider.notifier).refreshTasks();
        if (mounted) {
          toastification.show(
            context: context,
            type: ToastificationType.success,
            style: ToastificationStyle.fillColored,
            title: Text(
              'Tareas importadas',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            description: Text(
              'Las tareas se han importado correctamente',
              style: GoogleFonts.inter(),
            ),
            alignment: Alignment.topRight,
            autoCloseDuration: const Duration(seconds: 3),
            borderRadius: BorderRadius.circular(12),
            boxShadow: lowModeShadow,
            showProgressBar: true,
            closeButtonShowType: CloseButtonShowType.onHover,
            closeOnClick: false,
            pauseOnHover: true,
            dragToClose: true,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        toastification.dismissAll();
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          title: Text(
            'Error al importar',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          description: Text(
            'No se pudieron importar las tareas: $e',
            style: GoogleFonts.inter(),
          ),
          alignment: Alignment.topRight,
          autoCloseDuration: const Duration(seconds: 5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: lowModeShadow,
          showProgressBar: true,
          closeButtonShowType: CloseButtonShowType.onHover,
          closeOnClick: false,
          pauseOnHover: true,
          dragToClose: true,
        );
      }
    }
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

                toastification.show(
                  context: context,
                  type: ToastificationType.info,
                  style: ToastificationStyle.fillColored,
                  title: Text(
                    'Sincronizando...',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  description: Text(
                    'Actualizando tus tareas',
                    style: GoogleFonts.inter(),
                  ),
                  alignment: Alignment.topRight,
                  autoCloseDuration: const Duration(seconds: 3),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: lowModeShadow,
                  showProgressBar: true,
                  closeButtonShowType: CloseButtonShowType.onHover,
                  closeOnClick: false,
                  pauseOnHover: true,
                  dragToClose: true,
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
            onPressed: _showImportConfirmation,
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
                          onToggle: () =>
                              _toggleTask(task.id, task.isCompleted),
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
