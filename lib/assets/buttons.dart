import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String pageName;
  final String pageDesc;
  final String pageRoute;
  final Color color;

  const MainButton(
      {super.key,
      required this.pageName,
      required this.pageDesc,
      required this.pageRoute,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, pageRoute);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28), color: color),
          height: 150,
          width: 500,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                Text(pageName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(pageDesc,
                    textAlign: TextAlign.left,
                    style: const TextStyle(color: Colors.white, fontSize: 14)),
              ]),
        ),
      ),
    );
  }
}
