class Task {
  int id;
  String title;
  String description;
  DateTime deadline;
  DateTime? startTime;
  DateTime? endTime;
  bool isCompleted = false;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.deadline,
  });

  void startTask() {
    startTime = DateTime.now();
    isCompleted = false;
  }

  void completeTask() {
    endTime = DateTime.now();
    isCompleted = true;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'deadline': deadline.toIso8601String(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
    )
      ..startTime =
          json['startTime'] != null ? DateTime.parse(json['startTime']) : null
      ..endTime =
          json['endTime'] != null ? DateTime.parse(json['endTime']) : null
      ..isCompleted = json['isCompleted'];
  }
}
