import 'package:bytestream/home.dart';
import 'package:bytestream/mood_track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'const_key.dart';
import 'login_page.dart';
import 'start.dart';
import 'todo.dart';

void main() {
  Gemini.init(apiKey: apiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/start': (context) => const MyHomePage(),
        '/home': (context) => const HomePage(),
        '/todo': (context) => ToDoListPage(),
        '/mood': (context) => const MyMood(),
        '/login': (context) => LoginPage(),
      },
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}
