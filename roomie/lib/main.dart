import 'package:flutter/material.dart';
import 'package:roomie/screen/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //비동기방식의 메서드
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roomie',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginSignupScreen(),
    );
  }
}
