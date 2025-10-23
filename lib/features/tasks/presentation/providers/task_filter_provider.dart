import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_master/features/tasks/domain/entities/task_filter.dart'
    as domain;

import '/features/tasks/data/data.dart';
import 'task_filter_state.dart';

part 'task_filter_provider.g.dart';

@riverpod
class TaskFilter extends _$TaskFilter {
  @override
  TaskFilterState build() {
    return const TaskFilterState();
  }

  /// Cambiar tipo de filtro (all, pending, completed)
  void setFilterType(TaskFilterType type) {
    state = state.copyWith(filterType: type);
    // Ya no necesitamos llamar a loadTasks() aquí.
    // tasksProvider está observando (watch) y se recargará solo.
  }

  /// Cambiar filtro de prioridad
  void setPriority(TaskPriority? priority) {
    state = state.copyWith(priority: priority);
    // Ya no necesitamos llamar a loadTasks() aquí.
  }

  /// Actualizar búsqueda por texto
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    // Ya no necesitamos llamar a loadTasks() aquí.
    // NOTA: Para 'search' puedes usar un 'debounce'
    // para no recargar en cada letra, pero esta es la forma más simple.
  }

  /// Resetear todos los filtros
  void resetFilters() {
    state = const TaskFilterState();
    // Ya no necesitamos llamar a loadTasks() aquí.
  }

  /// Obtener el filtro actual como TaskFilter del dominio
  domain.TaskFilter getCurrentFilter() {
    return domain.TaskFilter(
      type: state.filterType,
      priority: state.priority,
      searchQuery: state.searchQuery.isEmpty ? null : state.searchQuery,
    );
  }
}
