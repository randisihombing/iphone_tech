import 'dart:convert';

import '../model/iphone_model.dart';
import 'package:http/http.dart' as http;


class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String tasksEndpoint = '$baseUrl/todos';

  Future<List<Task>> getTasks() async {
    try {
      final response = await http.get(Uri.parse(tasksEndpoint));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((task) => Task.fromJson(task)).toList();
      } else {
        throw Exception('Failed to load tasks');
      }
    }catch (error) {
      throw Exception('Failed to load tasks: $error');
    }
  }

  Future<Task> addTask(Task task) async {
    final response = await http.post(
      Uri.parse(tasksEndpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()), // Convert task to JSON
    );

    if (response.statusCode == 201) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add task');
    }
  }
}
