import 'package:flutter/material.dart';

class MyChattingScreen extends StatelessWidget {
  const MyChattingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Text("This is My Chatting"),
          ),
        ],
      ),
    );
  }
}
