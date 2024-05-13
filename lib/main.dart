import 'package:bytestream/home.dart';
import 'package:bytestream/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'const_key.dart';
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
        '/login': (context) => LoginPage(),
      },
      title: 'Flutter Demo',
      home: const MyHomePage(),
    );
  }
}
