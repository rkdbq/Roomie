import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roomie/screens/authentication_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  final bool isSurveyDone = false;
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginSignupScreen(),
    );
  }
}
