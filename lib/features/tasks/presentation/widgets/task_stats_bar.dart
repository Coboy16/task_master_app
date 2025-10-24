import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '/features/tasks/data/data.dart';
import '/features/tasks/domain/domain.dart';
import '/features/tasks/presentation/providers/providers.dart';

class TaskStatsBar extends ConsumerWidget {
  final TaskStats stats;

  const TaskStatsBar({super.key, required this.stats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilter = ref.watch(taskFilterProvider).filterType;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              title: 'Todas',
              count: stats.total,
              color: const Color(0xFF2800C8),
              icon: LucideIcons.inbox,
              isActive: activeFilter == TaskFilterType.all,
              onTap: () {
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
              color: const Color(0xFFf59e0b),
              icon: LucideIcons.clock,
              isActive: activeFilter == TaskFilterType.pending,
              onTap: () {
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
              color: const Color(0xFF10b981),
              icon: LucideIcons.circleCheck,
              isActive: activeFilter == TaskFilterType.completed,
              onTap: () {
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.1) : const Color(0xFFfafafa),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? color : const Color(0xFFe5e7eb),
            width: isActive ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF6b7280),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
