import 'package:flutter/material.dart';

class MyDr extends StatelessWidget {
  const MyDr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Assistance",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Text("DR"),
    );
  }
}
