/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Task {
  String name;
  String description;
  bool completed;

  Task(this.name, this.description, {this.completed = false});
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Task> _tasks = [];
  late SharedPreferences _prefs;

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = (_prefs.getStringList('tasks') ?? []).map((taskString) {
        List<String> taskData = taskString.split('|');
        return Task(taskData[0], taskData[1], completed: taskData[2] == 'true');
      }).toList();
    });
  }

  void _saveTasks() {
    List<String> tasksData = _tasks.map((task) {
      return '${task.name}|${task.description}|${task.completed}';
    }).toList();
    _prefs.setStringList('tasks', tasksData);
  }

  void _addTask(String name, String description) {
    setState(() {
      _tasks.add(Task(name, description));
      _taskNameController.clear();
      _taskDescriptionController.clear();
      _saveTasks();
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
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                  _saveTasks();
                });
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _taskNameController,
                  decoration: const InputDecoration(
                    labelText: 'Task Name',
                  ),
                ),
                TextField(
                  controller: _taskDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Task Description',
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_taskNameController.text.isNotEmpty) {
                      _addTask(_taskNameController.text,
                          _taskDescriptionController.text);
                    }
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
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
    );
  }
}*/
import 'package:flutter/material.dart';

class Task {
  String name;
  String description;
  bool completed;

  Task(this.name, this.description, {this.completed = false});
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final List<Task> _tasks = [];

  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  void _addTask(String name, String description) {
    setState(() {
      _tasks.add(Task(name, description));
      _taskNameController.clear();
      _taskDescriptionController.clear();
    });
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index].completed = !_tasks[index].completed;
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
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _taskNameController,
                  decoration: const InputDecoration(
                    labelText: 'Task Name',
                  ),
                ),
                TextField(
                  controller: _taskDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Task Description',
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_taskNameController.text.isNotEmpty) {
                      _addTask(_taskNameController.text,
                          _taskDescriptionController.text);
                    }
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ),
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
    );
  }
}
