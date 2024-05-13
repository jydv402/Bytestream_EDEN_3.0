import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/todo');
                  },
                  child: const Text("Work Planner")),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text("Chat")),
            ],
          ),
        ),
      ),
    );
  }
}
