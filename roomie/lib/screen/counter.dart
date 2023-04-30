import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  final int price = 2000;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Stream<int> addStreamValue() {
    return Stream<int>.periodic(
        const Duration(seconds: 1), (count) => price + count);
  }
}
