import 'task.dart';

class Project {
  String id;
  String name;
  String description;
  DateTime startDate;
  List<Task> tasks = [];

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'tasks': tasks.map((task) => task.toJson()).toList(),
    };
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
    )..tasks = (json['tasks'] as List)
        .map((taskJson) => Task.fromJson(taskJson))
        .toList();
  }
}

