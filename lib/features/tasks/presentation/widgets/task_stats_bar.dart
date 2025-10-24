import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_master/features/tasks/data/data.dart';
import 'package:task_master/features/tasks/domain/domain.dart';
import 'package:task_master/features/tasks/presentation/providers/providers.dart';

class TaskStatsBar extends ConsumerWidget {
  final TaskStats stats;

  const TaskStatsBar({super.key, required this.stats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observamos el filtro actual para saber cuál tarjeta está activa
    final activeFilter = ref.watch(taskFilterProvider).filterType;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              title: 'Todas',
              count: stats.total,
              color: Colors.blue,
              icon: Icons.all_inbox_rounded,
              isActive: activeFilter == TaskFilterType.all,
              onTap: () {
                // Cambiamos el filtro a 'all'
                ref
                    .read(taskFilterProvider.notifier)
                    .setFilterType(TaskFilterType.all);
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              title: 'Pendientes',
              count: stats.pending,
              color: Colors.orange,
              icon: Icons.pending_actions_rounded,
              isActive: activeFilter == TaskFilterType.pending,
              onTap: () {
                // Cambiamos el filtro a 'pending'
                ref
                    .read(taskFilterProvider.notifier)
                    .setFilterType(TaskFilterType.pending);
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              title: 'Completadas',
              count: stats.completed,
              color: Colors.green,
              icon: Icons.check_circle_rounded,
              isActive: activeFilter == TaskFilterType.completed,
              onTap: () {
                // Cambiamos el filtro a 'completed'
                ref
                    .read(taskFilterProvider.notifier)
                    .setFilterType(TaskFilterType.completed);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: isActive ? 6.0 : 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isActive
              ? BorderSide(color: color, width: 2)
              : BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    count.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Icon(icon, color: color, size: 20),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
