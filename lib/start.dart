import 'package:bytestream/assets/buttons.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Logout",
                  style: TextStyle(color: Colors.red, fontSize: 18)),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Name",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: ListView(
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
            pageName: "Chat with Lina",
            pageDesc: "Personal support for your worries",
            pageRoute: "/home",
          ),
          MainButton(
            color: Colors.green.shade200,
            pageName: "Mood Tracker",
            pageDesc: "An insight on your mood over the time",
            pageRoute: "/mood",
          ),
          MainButton(
            color: Colors.red.shade200,
            pageName: "Seek assistance",
            pageDesc: "Book an appointment with the experts",
            pageRoute: "/dr",
          ),
          const SizedBox(
            height: 50,
          )
        ],
      )),
    );
  }
}
