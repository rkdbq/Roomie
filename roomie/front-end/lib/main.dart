import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roomie/classes/random_color.dart';
import 'package:roomie/classes/survey_data.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:roomie/firebase_options.dart';
import 'package:roomie/screens/home_screen.dart';
import 'package:roomie/screens/survey_screen.dart';

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
    UserData myData =
        UserData(surveyData: SurveyData(), color: randomColor()); //임시 랜덤 생성
    return MaterialApp(
      home: isSurveyDone
          ? HomeScreen(userData: myData)
          : SurveyScreen(userData: myData),
    );
  }
}
