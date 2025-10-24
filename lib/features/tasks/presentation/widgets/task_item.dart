import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_master/features/tasks/domain/domain.dart';

// Asegúrate de tener este import para AsyncCallback
import 'package:flutter/foundation.dart';

class TaskItem extends StatelessWidget {
  final TaskEntitie task;
  final AsyncCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  // Método para mostrar el BottomSheet (sin cambios)
  void _showTaskOptionsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit_outlined),
              title: const Text('Editar Tarea'),
              onTap: () {
                Navigator.pop(context);
                onEdit();
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline, color: Colors.red.shade700),
              title: Text(
                'Eliminar Tarea',
                style: TextStyle(color: Colors.red.shade700),
              ),
              onTap: () {
                Navigator.pop(context);
                onDelete();
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool isCompleted = task.isCompleted;

    return Dismissible(
      key: ValueKey(task.id),

      // LÓGICA DE CONFIRMACIÓN ACTUALIZADA
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // --- ACCIÓN: MARCAR COMO COMPLETADA ---
          // Si ya está completada, no hagas nada
          if (task.isCompleted) return false;

          // Si está pendiente, llama al toggle para completarla
          await onToggle();
          return false; // Previene que se elimine
        } else if (direction == DismissDirection.endToStart) {
          // --- ACCIÓN: MARCAR COMO PENDIENTE (INCOMPLETA) ---
          // Si ya está pendiente, no hagas nada
          if (!task.isCompleted) return false;

          // Si está completada, llama al toggle para marcarla pendiente
          await onToggle();
          return false; // Previene que se elimine
        }
        return false;
      },

      // FONDO DERECHA (Swipe ->)
      // Siempre verde para "Completar"
      background: Container(
        color: Colors.green.shade700,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerLeft,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Completar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      // FONDO IZQUIERDA (Swipe <-)
      // Siempre naranja para "Marcar Pendiente"
      secondaryBackground: Container(
        color: Colors.orange.shade700,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Marcar Pendiente',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.pending_actions_rounded, color: Colors.white),
          ],
        ),
      ),

      // CONTENIDO DE LA TARJETA (Sin cambios)
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        elevation: 2,
        child: ListTile(
          onTap: onTap,
          leading: Checkbox(
            value: isCompleted,
            onChanged: (val) {
              onToggle();
            },
          ),
          title: Text(
            task.title,
            style: textTheme.titleMedium?.copyWith(
              decoration: isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: isCompleted ? Colors.grey.shade600 : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                Icon(Icons.flag, color: Color(task.priorityColor), size: 14),
                const SizedBox(width: 4),
                Text(
                  task.priorityText,
                  style: textTheme.bodySmall?.copyWith(
                    color: Color(task.priorityColor),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('  •  '),
                Text(
                  DateFormat.yMd().format(task.createdAt),
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              if (task.isFromApi) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Las tareas de la API no se pueden editar o eliminar',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                return;
              }
              _showTaskOptionsBottomSheet(context);
            },
          ),
        ),
      ),
    );
  }
}
