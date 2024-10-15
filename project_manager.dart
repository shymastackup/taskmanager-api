import 'api.dart';
import 'project.dart';
import 'task.dart';

class ProjectManager {
  Map<String, Project> projects = {};
  Future<void> loadProjectsFromApi() async {
    try {
      final List<dynamic> data = await Api.getProjects();

      if (data.isNotEmpty) {
        projects = {
          for (var json in data)
            Project.fromJson(json).id: Project.fromJson(json)
        };
        print('Projects loaded successfully');
      } else {}
    } catch (e) {
      print('Error: Unable to load projects. Reason: $e');
    }
  }

  Future<void> saveProjectsToApi() async {
    try {
      for (var project in projects.values) {
        await Api.createProject(project.toJson());
      }
      print('Projects saved successfully in shyma.');
    } catch (e) {
      print('Error: Unable to save projects. Reason: $e');
    }
  }

  Project findProjectByName(String projectName) {
    return projects.values.firstWhere(
      (project) => project.name == projectName,
      orElse: () => throw Exception("Project '$projectName' not found"),
    );
  }

  Task findTaskInProject(Project project, String taskTitle) {
    return project.tasks.firstWhere(
      (task) => task.title == taskTitle,
      orElse: () => throw Exception(
          "Task '$taskTitle' not found in project '${project.name}'"),
    );
  }

  void createProject(String name, String description, DateTime startDate) {
    final project = Project(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      description: description,
      startDate: startDate,
    );
    projects[project.id] = project;
    // saveProjectsToApi();
    print("Project '$name' created successfully.");
  }

  void addTaskToProject(String projectName, Task task) {
    final project = findProjectByName(projectName);
    project.tasks.add(task);
    saveProjectsToApi();
    print("Task '${task.title}' added to project '$projectName'.");
  }

  void viewTasksOfProject(String projectName) {
    final project = findProjectByName(projectName);
    if (project.tasks.isEmpty) {
      print("No tasks found in project '$projectName'.");
    } else {
      for (var task in project.tasks) {
        print(
            "Task: ${task.title}, Status: ${task.isCompleted ? 'Completed' : 'Pending'}, Deadline: ${task.deadline}");
        if (task.startTime != null) print("  Start Time: ${task.startTime}");
        if (task.endTime != null) print("  End Time: ${task.endTime}");
      }
    }
  }

  void startTask(String projectName, String taskTitle) {
    final project = findProjectByName(projectName);
    final task = findTaskInProject(project, taskTitle);
    task.startTask();
    saveProjectsToApi();
    print("Task '$taskTitle' started at ${task.startTime}.");
  }

  void completeTask(String projectName, String taskTitle) {
    final project = findProjectByName(projectName);
    final task = findTaskInProject(project, taskTitle);
    task.completeTask();
    saveProjectsToApi();
    print("Task '$taskTitle' completed at ${task.endTime}.");
  }

  void updateTask(String projectName, String taskTitle, String newTitle,
      String newDescription, DateTime newDeadline) {
    final project = findProjectByName(projectName);
    final task = findTaskInProject(project, taskTitle);
    task.title = newTitle;
    task.description = newDescription;
    task.deadline = newDeadline;
    saveProjectsToApi();
    print("Task '$taskTitle' updated successfully.");
  }

  void deleteTask(String projectName, String taskTitle) {
    final project = findProjectByName(projectName);
    project.tasks.removeWhere((task) => task.title == taskTitle);
    saveProjectsToApi();
    print("Task '$taskTitle' deleted from project '$projectName'.");
  }

  void deleteProject(String projectName) {
    try {
      final project = findProjectByName(projectName);
      projects.remove(project.id);
      saveProjectsToApi();
      print("Project '$projectName' deleted successfully.");
    } catch (e) {
      print("Error: Unable to delete project '$projectName'. Reason: $e");
    }
  }

  void viewAllProjects() {
    try {
      if (projects.isEmpty) {
        print("No projects available.");
      } else {
        for (var project in projects.values) {
          print(
              "Project: ${project.name}, Description: ${project.description}, Start Date: ${project.startDate.toIso8601String()}");
        }
      }
    } catch (e) {
      print("Error: Unable to display projects. Reason: $e");
    }
  }

  void searchProjectByName(String projectName) {
    try {
      final project = findProjectByName(projectName);
      print(
          "Project: ${project.name}, Description: ${project.description}, Start Date: ${project.startDate.toIso8601String()}");
    } catch (e) {
      print("Error: Project '$projectName' not found.");
    }
  }

  void viewCompletedTasks(String projectName) {
    try {
      final project = findProjectByName(projectName);
      final completedTasks =
          project.tasks.where((task) => task.isCompleted).toList();
      if (completedTasks.isEmpty) {
        print("No completed tasks in project '$projectName'.");
      } else {
        for (var task in completedTasks) {
          print("Completed Task: ${task.title}, Completed at: ${task.endTime}");
        }
      }
    } catch (e) {
      print("Error: Project '$projectName' not found or tasks unavailable.");
    }
  }

  void viewPendingTasks(String projectName) {
    try {
      final project = findProjectByName(projectName);
      final pendingTasks =
          project.tasks.where((task) => !task.isCompleted).toList();
      if (pendingTasks.isEmpty) {
        print("No pending tasks in project '$projectName'.");
      } else {
        for (var task in pendingTasks) {
          print(
              "Pending Task: ${task.title}, Deadline: ${task.deadline.toIso8601String()}");
        }
      }
    } catch (e) {
      print("Error: Project '$projectName' not found or tasks unavailable.");
    }
  }

  void extendTaskDeadline(
      String projectName, String taskTitle, DateTime newDeadline) {
    try {
      final project = findProjectByName(projectName);
      final task = findTaskInProject(project, taskTitle);
      task.deadline = newDeadline;
      saveProjectsToApi();
      print("Deadline extended for task: ${task.title}");
    } catch (e) {
      print("Error: Unable to extend deadline. Reason: $e");
    }
  }

  void viewProjectDetails(String projectName) {
    try {
      final project = findProjectByName(projectName);
      print(
          "Project: ${project.name}, Description: ${project.description}, Start Date: ${project.startDate.toIso8601String()}");
      viewTasksOfProject(projectName);
    } catch (e) {
      print("Error: Project '$projectName' not found.");
    }
  }
}
