enum TaskFilterType {
  all,
  pending,
  completed;

  String get label {
    switch (this) {
      case TaskFilterType.all:
        return 'Todas';
      case TaskFilterType.pending:
        return 'Pendientes';
      case TaskFilterType.completed:
        return 'Completadas';
    }
  }
}
