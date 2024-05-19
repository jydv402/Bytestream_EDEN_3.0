import 'package:flutter/material.dart';

class MyExpert extends StatelessWidget {
  final String asset;
  final String name;
  final String age;

  const MyExpert(
      {super.key, required this.asset, required this.name, required this.age});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(26),
          ),
          height: 200,
          width: 500,
          child: Card(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            margin: const EdgeInsets.all(18.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  //How to reduce the size of the image
                  SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset(asset),
                    ),
                  ),
                  const SizedBox(width: 40.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10.0),
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Age: $age',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        const Text(
                          'Psychologist',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)),
                          onPressed: () {},
                          child: const Text('Book Appointment',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
