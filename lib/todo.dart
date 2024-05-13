import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Task {
  String name;
  String description;
  bool completed;
  DateTime? dueDateTime; // New field for due date and time

  Task(this.name, this.description, {this.completed = false, this.dueDateTime});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'completed': completed,
      'dueDateTime':
          dueDateTime?.toIso8601String(), // Convert DateTime to string
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['name'],
      json['description'],
      completed: json['completed'],
      dueDateTime: json['dueDateTime'] != null
          ? DateTime.parse(json['dueDateTime']) // Parse string to DateTime
          : null,
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

  void _addTask(String name, String description, {DateTime? dueDateTime}) {
    setState(() {
      _tasks.add(Task(name, description, dueDateTime: dueDateTime));
      _saveTasks();
      _taskNameController.clear();
      _taskDescriptionController.clear();
      _dueDateTime = null; // Clear due date and time after adding the task
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

  DateTime? _dueDateTime;
  void _showAddTaskDialog(BuildContext context, {Task? task}) {
    _taskNameController.text = task?.name ?? '';
    _taskDescriptionController.text = task?.description ?? '';
    _dueDateTime = task?.dueDateTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(task == null ? "Add Task" : "Edit Task"),
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
              SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _dueDateTime ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    final TimeOfDay? timePicked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          _dueDateTime ?? DateTime.now()),
                    );
                    if (timePicked != null) {
                      setState(() {
                        _dueDateTime = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                          timePicked.hour,
                          timePicked.minute,
                        );
                      });
                    }
                  }
                },
                child: Text(
                  _dueDateTime != null
                      ? 'Due: ${DateFormat.yMd().add_jm().format(_dueDateTime!)}'
                      : 'Set Due Date and Time',
                  style: TextStyle(
                    color: _dueDateTime != null ? Colors.blue : Colors.grey,
                  ),
                ),
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
                  if (task == null) {
                    _addTask(
                      _taskNameController.text,
                      _taskDescriptionController.text,
                      dueDateTime: _dueDateTime,
                    );
                  } else {
                    task.name = _taskNameController.text;
                    task.description = _taskDescriptionController.text;
                    task.dueDateTime = _dueDateTime;
                    _saveTasks();
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text(task == null ? 'Add' : 'Update',
                  style: TextStyle(color: color)),
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
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_tasks[index].description),
                      if (_tasks[index].dueDateTime != null)
                        Text(
                            'Due: ${DateFormat.yMd().add_jm().format(_tasks[index].dueDateTime!)}'),
                    ],
                  ),
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
