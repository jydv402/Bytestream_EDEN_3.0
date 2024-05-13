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
  List<Task> _tasks = [];

  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();

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
          title: Text("Confirm"),
          content: Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _tasks.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text("Delete"),
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
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _taskNameController,
                  decoration: InputDecoration(
                    labelText: 'Task Name',
                  ),
                ),
                TextField(
                  controller: _taskDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Task Description',
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_taskNameController.text.isNotEmpty) {
                      _addTask(_taskNameController.text,
                          _taskDescriptionController.text);
                    }
                  },
                  child: Text('Add Task'),
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
                          ? Icon(Icons.check, color: Colors.white)
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
