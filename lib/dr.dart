import 'package:flutter/material.dart';

import 'assets/experts.dart';

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
        body: Center(
          child: ListView(children: const [
            SizedBox(
              height: 50,
            ),
            MyExpert(
              asset: 'assets/img1.jpeg',
              name: 'Dr. Richard',
              age: '40',
            ),
            MyExpert(
              asset: 'assets/img2.jpeg',
              name: 'Dr. Paul',
              age: '45',
            ),
            MyExpert(
              asset: 'assets/img3.jpeg',
              name: 'Dr. Emily',
              age: '41',
            ),
            MyExpert(
              asset: 'assets/img4.jpeg',
              name: 'Dr. Rahul',
              age: '49',
            ),
            MyExpert(
              asset: 'assets/img5.jpeg',
              name: 'Dr. Vijayalekshmi',
              age: '47',
            ),
          ]),
        ));
  }
}
