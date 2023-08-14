import 'package:flutter/material.dart';

import '../add_data/add_data.dart';
import '../model/iphone_model.dart';
import '../provider/iphone_provider.dart';


class DataListScreen extends StatefulWidget {
  const DataListScreen({Key? key}) : super(key: key);

  @override
  State<DataListScreen> createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  final ApiService apiService = ApiService();
  TextEditingController cariController = TextEditingController();
  List<Task> tasks = [];
  List<Task> filteredTasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
    filteredTasks = tasks;
  }

  void filterTasks(String query) {
    setState(() {
      filteredTasks = tasks.where((task) {
        final titleLower = task.title.toLowerCase();
        final categoryLower = task.category.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower) || categoryLower.contains(searchLower);
      }).toList();
    });
  }

  Future<void> fetchTasks() async {
    try {
      List<Task> fetchedTasks = await apiService.getTasks();
      setState(() {
        tasks = fetchedTasks;
      });
    } catch (error) {
      print('Error fetching tasks: $error');
    }
  }

  void addTask(Task task) async {
    try {
      Task newTask = await apiService.addTask(task);
      setState(() {
        tasks.add(newTask);
      });
    } catch (error) {
      print('Error adding task: $error');
    }
  }

  void toggleComplete(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('To-Do List')),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: cariController,
                onChanged: filterTasks,
                decoration: const InputDecoration(
                    labelText: 'Cari',
                    prefixIcon: Icon(Icons.search)
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Expanded(
                child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    Task task = filteredTasks[index];
                    return
                      Draggable<Task>(
                        data: task,
                        feedback: Material(
                          elevation: 4,
                          child: ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.category),
                          ),
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) => toggleComplete(index),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Text(task.category),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteTask(index),
                          ),
                        ),
                      );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? newTask = await showDialog<Task>(
            context: context,
            builder: (BuildContext context) {
              return const SubmitDataScreen();
            },
          );
          if (newTask != null) {
            addTask(newTask);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
