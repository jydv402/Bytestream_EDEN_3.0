// import 'package:flutter/material.dart';

// class MyDr extends StatelessWidget {
//   const MyDr({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Assistance",
//           style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Text("DR"),
//     );
//   }
// }
import 'package:flutter/material.dart';

void main() {
  runApp(MyDr());
}

class Doctor {
  final String name;
  final int age;
  final String qualifications;
  final String image;

  Doctor({
    required this.name,
    required this.age,
    required this.qualifications,
    required this.image,
  });
}

class MyDr extends StatelessWidget {
  final List<Doctor> doctors = [
    Doctor(
      name: "Dr. Alice Smith",
      age: 40,
      qualifications: "MD, PhD",
      image: "doctor1.jpg",
    ),
    Doctor(
      name: "Dr. John Doe",
      age: 45,
      qualifications: "MBBS",
      image: "doctor2.jpg",
    ),
    Doctor(
      name: "Dr. Emily Johnson",
      age: 38,
      qualifications: "PsyD",
      image: "doctor3.jpg",
    ),
    Doctor(
      name: "Dr. Michael Brown",
      age: 50,
      qualifications: "MD",
      image: "doctor4.jpg",
    ),
    Doctor(
      name: "Dr. Sophia Lee",
      age: 42,
      qualifications: "PhD",
      image: "doctor5.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Doctor Directory'),
        ),
        body: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctors[index];
            return DoctorListItem(doctor: doctor);
          },
        ),
      ),
    );
  }
}

class DoctorListItem extends StatelessWidget {
  final Doctor doctor;

  DoctorListItem({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.asset(
                'assets/${doctor.image}',
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Age: ${doctor.age}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Qualifications: ${doctor.qualifications}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () {
                // Add your booking logic here
              },
              child: Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
