import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roomie/classes/random_color.dart';
import 'package:roomie/classes/survey_data.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:roomie/firebase_options.dart';
import 'package:roomie/screens/authentication_screen.dart';

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
    const email = "rkdbg11752@jbnu.ac.kr";
    UserData myData = UserData(
      email: email,
      name: "강봉구",
      password: "kang1293",
      surveyData: SurveyData(),
      color: randomColor(),
    );
    return const MaterialApp(
      home: LoginSignupScreen(),
    );
  }
}
