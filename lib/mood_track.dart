import 'package:flutter/material.dart';

class MyMood extends StatelessWidget {
  const MyMood({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mood Tracker",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text("Mood Tracker")),
    );
  }
}
