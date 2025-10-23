// Prioridad de la tarea
enum TaskPriority {
  low,
  medium,
  high;

  String toJson() => name;

  static TaskPriority fromJson(String json) {
    return TaskPriority.values.firstWhere(
      (e) => e.name == json,
      orElse: () => TaskPriority.medium,
    );
  }
}
