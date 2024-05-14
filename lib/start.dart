import 'package:bytestream/assets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
          "Nirvana",
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
            pageRoute: "/load",
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

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.black, size: 80),
              const Padding(
                padding: EdgeInsets.only(top: 60),
                child: Text(
                    "Hi, I'm Lina.\nI'm here to help you.\nDo feel free to talk to me about anything.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    minimumSize: const MaterialStatePropertyAll(
                      Size(300, 60),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: const Text("Go ahead",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)))
            ]),
      ),
    );
  }
}
