import 'package:flutter/material.dart';

class Difference extends StatelessWidget {
  const Difference({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 250,
      decoration: BoxDecoration(
          color: const Color(0xfffa8128),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "이런 점이 달라요",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "차이점 1",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              "차이점 2",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              "차이점 3",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
