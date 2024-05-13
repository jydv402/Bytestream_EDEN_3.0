import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Task {
  String name;
  String description;
  bool completed;

  Task(this.name, this.description, {this.completed = false});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'completed': completed,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['name'],
      json['description'],
      completed: json['completed'],
    );
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  Color color = Colors.black;

  final List<Task> _tasks = [];
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final List<String>? tasksJson = await _prefsHelper.getTasks();
    if (tasksJson != null) {
      setState(() {
        _tasks.addAll(
            tasksJson.map((json) => Task.fromJson(jsonDecode(json))).toList());
      });
    }
  }

  Future<void> _saveTasks() async {
    final List<String> tasksJson =
        _tasks.map((task) => jsonEncode(task.toJson())).toList();
    await _prefsHelper.saveTasks(tasksJson);
  }

  void _addTask(String name, String description) {
    setState(() {
      _tasks.add(Task(name, description));
      _saveTasks();
      _taskNameController.clear();
      _taskDescriptionController.clear();
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].completed = !_tasks[index].completed;
      _saveTasks();
    });
  }

  void _deleteTask(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel", style: TextStyle(color: color)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                  _saveTasks();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                "Delete",
                style: TextStyle(color: color),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _taskNameController,
                decoration: InputDecoration(labelText: 'Task Name'),
              ),
              TextField(
                controller: _taskDescriptionController,
                decoration: InputDecoration(labelText: 'Task Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: color),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_taskNameController.text.isNotEmpty) {
                  _addTask(
                    _taskNameController.text,
                    _taskDescriptionController.text,
                  );
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add', style: TextStyle(color: color)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_tasks[index].name),
                  subtitle: Text(_tasks[index].description),
                  trailing: GestureDetector(
                    onTap: () {
                      _toggleTask(index);
                    },
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _tasks[index].completed
                            ? Colors.green
                            : Colors.transparent,
                        border: Border.all(color: Colors.black),
                      ),
                      child: _tasks[index].completed
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  ),
                  onLongPress: () {
                    _deleteTask(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class SharedPreferencesHelper {
  static const String _keyTasks = 'tasks';

  Future<List<String>?> getTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyTasks);
  }

  Future<void> saveTasks(List<String> tasks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyTasks, tasks);
  }
}

void main() {
  runApp(MaterialApp(
    home: ToDoListPage(),
  ));
}
