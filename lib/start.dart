import 'package:bytestream/assets/buttons.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
        ],
      )),
    );
  }
}
