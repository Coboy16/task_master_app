import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/core.dart';

import '/features/auth/presentation/providers/providers.dart';
import '/features/tasks/presentation/providers/providers.dart';
// Importamos los nuevos widgets
import '/features/tasks/presentation/widgets/widgets.dart';

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

  // Este método ahora será llamado por el callback de TaskItem
  Future<void> _toggleTask(String taskId) async {
    final success = await ref
        .read(toggleTaskControllerProvider.notifier)
        .toggleTaskCompletion(taskId);
    if (success && mounted) {
      await ref.read(tasksProvider.notifier).refreshTasks();
    }
  }

  // Este método también será llamado por el callback de TaskItem
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
          IconButton(
            icon: const Icon(Icons.cloud_download_outlined),
            tooltip: 'Traer de API (Demo)',
            onPressed: () async {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Row(
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text('Obteniendo tareas de API...'),
                      ],
                    ),
                    duration: Duration(seconds: 30),
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
                      const SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.white),
                            SizedBox(width: 16),
                            Text('✓ Tareas obtenidas exitosamente'),
                          ],
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                } else {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.error, color: Colors.white),
                            SizedBox(width: 16),
                            Text('✗ Error al obtener tareas'),
                          ],
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text('Error: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                }
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. REEMPLAZAMOS LOS PLACEHOLDERS POR EL WIDGET DE STATS
          tasksState.when(
            data: (state) => state.maybeWhen(
              loaded: (tasks, stats) {
                // Mostramos la barra de stats si existen
                if (stats != null) {
                  return TaskStatsBar(stats: stats);
                }
                return const SizedBox.shrink();
              },
              orElse: () => const SizedBox.shrink(),
            ),
            loading: () => const SizedBox(
              height: 80, // Altura similar a la barra de stats
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // 2. EL RESTO DEL BODY SE MANTIENE IGUAL
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
                      child: ListView(
                        children: const [
                          SizedBox(height: 100),
                          Center(
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
                        ],
                      ),
                    );
                  }

                  // 3. USAMOS EL NUEVO WIDGET TaskItem EN LUGAR DEL ListTile
                  return RefreshIndicator(
                    onRefresh: _refreshTasks,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        bottom: 80,
                      ), // Espacio para el FAB
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        // Usamos el nuevo widget y le pasamos los callbacks
                        return TaskItem(
                          task: task,
                          onTap: () {
                            context.push('${RouteNames.home}/${task.id}');
                          },
                          onToggle: () => _toggleTask(task.id),
                          onEdit: () {
                            // Navegamos a la pantalla de edición
                            context.push(
                              '${RouteNames.home}/edit',
                              extra: task,
                            );
                          },
                          onDelete: () {
                            // Mostramos el diálogo de confirmación
                            _showDeleteConfirmation(task.id);
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
          context.push('${RouteNames.home}/new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
