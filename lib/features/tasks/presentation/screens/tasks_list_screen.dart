import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/core.dart';

import '/features/auth/presentation/providers/providers.dart';
import '/features/tasks/presentation/providers/providers.dart';

class TasksListScreen extends ConsumerStatefulWidget {
  const TasksListScreen({super.key});

  @override
  ConsumerState<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends ConsumerState<TasksListScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshTasks() async {
    await ref.read(tasksProvider.notifier).refreshTasks();
  }

  Future<void> _toggleTask(String taskId) async {
    await ref
        .read(toggleTaskControllerProvider.notifier)
        .toggleTaskCompletion(taskId);
    if (mounted) {
      ref.read(tasksProvider.notifier).refreshTasks();
    }
  }

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
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
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
      appBar: AppBar(
        title: const Text('Mis Tareas'),
        actions: [
          // Botón de Sincronización (solo para usuarios NO invitados)
          if (!isGuest)
            IconButton(
              icon: const Icon(Icons.sync),
              tooltip: 'Sincronizar tareas',
              onPressed: () {
                ref.read(syncTasksControllerProvider.notifier).syncTasks();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text('Sincronizando...')),
                  );
              },
            ),

          // Botón de Traer de API
          IconButton(
            icon: const Icon(Icons.cloud_download_outlined),
            tooltip: 'Traer de API (Demo)',
            onPressed: () {
              ref
                  .read(fetchApiTasksControllerProvider.notifier)
                  .fetchTasksFromApi();
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Obteniendo tareas de API...')),
                );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // TODO: Implementar TaskFilterTabs()
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey.shade100,
            child: const Center(child: Text('Placeholder: TaskFilterTabs')),
          ),

          // TODO: Implementar TaskStatsBar()
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.blue.shade50,
            child: const Center(child: Text('Placeholder: TaskStatsBar')),
          ),

          // Lista de tareas
          Expanded(
            child: tasksState.when(
              data: (state) => state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (message) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                      const SizedBox(height: 16),
                      Text(message),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _refreshTasks,
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
                loaded: (tasks, stats) {
                  if (tasks.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: _refreshTasks,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No tienes tareas por aquí.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: _refreshTasks,
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        // TODO: Reemplazar con SwipeableTaskItem
                        return ListTile(
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Text(
                            task.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (val) {
                              // Call the async helper function
                              _toggleTask(task.id);
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () => _showDeleteConfirmation(task.id),
                          ),
                          onTap: () {
                            // Navegar a detalle
                            context.push('${RouteNames.home}/${task.id}');
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error al cargar: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a crear tarea
          context.push('${RouteNames.home}/new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
