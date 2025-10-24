import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '/core/core.dart';
import 'screens.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PersistentTabConfig> _navBarsItems() {
    return [
      PersistentTabConfig(
        screen: const TasksListScreen(),
        item: ItemConfig(
          icon: const Icon(LucideIcons.listTodo),
          title: "Tareas",
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          activeForegroundColor: const Color(0xFF2800C8),
          inactiveForegroundColor: const Color(0xFF9ca3af),
        ),
      ),
      PersistentTabConfig(
        screen: const SizedBox.shrink(),
        item: ItemConfig(
          icon: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFF2800C8),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.plus, color: Colors.white, size: 28),
          ),
          title: "",
        ),
      ),
      PersistentTabConfig(
        screen: const ProfileScreen(),
        item: ItemConfig(
          icon: const Icon(LucideIcons.user),
          title: "Perfil",
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          activeForegroundColor: const Color(0xFF2800C8),
          inactiveForegroundColor: const Color(0xFF9ca3af),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      tabs: _navBarsItems(),
      navBarBuilder: (navBarConfig) => Style6BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: const NavBarDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0x1a000000),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      onTabChanged: (index) {
        // Cuando se toca el botón central (índice 1), navegar a crear tarea
        if (index == 1) {
          context.push('${RouteNames.home}/new');
          // Volver al tab anterior (Tareas)
          Future.microtask(() {
            if (mounted && _controller.index != 0) {
              _controller.jumpToTab(0);
            }
          });
        }
      },
    );
  }
}
