class Task {
  String name;
  String description;
  DateTime endDate;
  int? priority;
  bool isDone;

  Task({
    required this.name,
    required this.description,
    required this.endDate,
    this.priority,
    this.isDone = false,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}
