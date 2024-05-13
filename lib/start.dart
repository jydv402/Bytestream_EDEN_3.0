import 'package:bytestream/assets/buttons.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Name",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          MainButton(
            color: Colors.blue.shade200,
            pageName: "Work Planner",
            pageDesc: "Plan all your works",
            pageRoute: "/todo",
          ),
          MainButton(
            color: Colors.purple.shade200,
            pageName: "Chat with me",
            pageDesc: "Get personal support for your worries",
            pageRoute: "/home",
          ),
          MainButton(
            color: Colors.green.shade200,
            pageName: "Mood Tracker",
            pageDesc: "An insight on your mood over the time",
            pageRoute: "/mood",
          ),
          MainButton(
            color: Colors.green.shade200,
            pageName: "Login",
            pageDesc: "Login",
            pageRoute: "/mood",
          ),
        ],
      )),
    );
  }
}
