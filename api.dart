import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static final String apiUrl =
      'https://crudcrud.com/api/b64bd6cae421493da94eb505ae804f91';

  static Future<List<dynamic>> getProjects() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/projects'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error: Failed to load projects. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: Unable to load projects. Reason: $e');
      return [];
    }
  }

  static Future<void> createProject(Map<String, dynamic> projectData) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/projects'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(projectData),
      );

      if (response.statusCode == 201) {
        print("good");
      } else {
        print('Error: Failed to create project. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to create project. Reason: $e');
    }
  }

  static Future<void> updateProject(String projectId, Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/projects/$projectId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        print('Project updated successfully.');
      } else {
        print('Error: Failed to update project. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to update project. Reason: $e');
    }
  }

  static Future<void> deleteProject(String projectId) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/projects/$projectId'));

      if (response.statusCode == 200) {
        print('Project deleted successfully.');
      } else {
        print('Error: Failed to delete project. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to delete project. Reason: $e');
    }
  }

  static Future<List<dynamic>> getTasks() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/tasks'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error: Failed to load tasks. Status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: Unable to load tasks. Reason: $e');
      return [];
    }
  }

  static Future<void> createTask(Map<String, dynamic> taskData) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/tasks'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(taskData),
      );

      if (response.statusCode == 201) {
        print('Task created successfully.');
      } else {
        print('Error: Failed to create task. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to create task. Reason: $e');
    }
  }

  static Future<void> updateTask(String taskId, Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/tasks/$taskId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        print('Task updated successfully.');
      } else {
        print('Error: Failed to update task. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to update task. Reason: $e');
    }
  }

  static Future<void> deleteTask(String taskId) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/tasks/$taskId'));

      if (response.statusCode == 200) {
        print('Task deleted successfully.');
      } else {
        print('Error: Failed to delete task. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: Unable to delete task. Reason: $e');
    }
  }
}

