import 'package:flutter/material.dart';

Widget drawer() {
  return Drawer(
    child: ListView(children: [
      TextButton(
          onPressed: () {
            // Navigator.pushNamed(, '/todo');
          },
          child: const Text("Work Planner"))
    ]),
  );
}
