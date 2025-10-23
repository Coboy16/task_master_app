/// Origen de la tarea
enum TaskSource {
  local,
  api,
  firebase;

  String toJson() => name;

  static TaskSource fromJson(String json) {
    return TaskSource.values.firstWhere(
      (e) => e.name == json,
      orElse: () => TaskSource.local,
    );
  }
}
