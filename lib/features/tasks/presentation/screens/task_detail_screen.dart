import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '/core/core.dart';
import '/features/tasks/domain/domain.dart';
import '/features/tasks/presentation/providers/providers.dart';
import '/features/tasks/data/data.dart';

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
        title: const Text('Eliminar Tarea'),
        content: const Text('¿Estás seguro de que deseas eliminar esta tarea?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
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
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
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
      // Refrescar el detalle
      ref.invalidate(taskDetailProvider(widget.taskId));
    }
  }

  void _editTask(TaskEntitie task) {
    context.push('${RouteNames.home}/edit', extra: task);
  }

  String _formatDate(DateTime date) {
    return DateFormat.yMd().add_jm().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final taskAsync = ref.watch(taskDetailProvider(widget.taskId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Tarea'),
        actions: [
          taskAsync.when(
            data: (task) {
              if (task == null) return const SizedBox.shrink();
              return Row(
                children: [
                  if (task.source != TaskSource.api)
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      tooltip: 'Editar',
                      onPressed: () => _editTask(task),
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Eliminar',
                    onPressed: () => _showDeleteConfirmation(task.id),
                  ),
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
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('Tarea no encontrada'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Volver'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  task.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    Chip(
                      label: Text(
                        task.isCompleted ? 'Completada' : 'Pendiente',
                      ),
                      backgroundColor: task.isCompleted
                          ? Colors.green.shade100
                          : Colors.amber.shade100,
                    ),
                    Chip(
                      label: Text('Prioridad: ${task.priorityText}'),
                      backgroundColor: Color(
                        task.priorityColor,
                      ).withOpacity(0.2),
                    ),
                    Chip(
                      label: Text('Origen: ${task.sourceText}'),
                      avatar: Icon(
                        task.source == TaskSource.api
                            ? Icons.cloud_queue
                            : task.source == TaskSource.firebase
                            ? Icons.cloud_done
                            : Icons.smartphone,
                        size: 16,
                      ),
                    ),
                    if (task.source != TaskSource.api)
                      Chip(
                        label: Text(
                          task.synced
                              ? 'Sincronizado'
                              : 'Pendiente de sincronizar',
                        ),
                        avatar: Icon(
                          task.synced
                              ? Icons.sync_rounded
                              : Icons.sync_problem_rounded,
                          size: 16,
                          color: task.synced ? Colors.green : Colors.orange,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 24),

                Text(
                  'Descripción',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  task.description.isEmpty
                      ? '(Sin descripción)'
                      : task.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Divider(height: 32),

                Text('Creada: ${_formatDate(task.createdAt)}'),
                const SizedBox(height: 8),
                Text('Actualizada: ${_formatDate(task.updatedAt)}'),
                const SizedBox(height: 32),

                ElevatedButton.icon(
                  onPressed: () => _toggleStatus(task),
                  icon: Icon(
                    task.isCompleted
                        ? Icons.arrow_back_rounded
                        : Icons.check_circle_outline,
                  ),
                  label: Text(
                    task.isCompleted
                        ? 'Marcar como pendiente'
                        : 'Marcar como completada',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: task.isCompleted
                        ? Colors.grey.shade300
                        : Colors.green.shade600,
                    foregroundColor: task.isCompleted
                        ? Colors.black87
                        : Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text('Error al cargar la tarea: $e'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
