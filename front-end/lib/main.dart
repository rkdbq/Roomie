import 'package:flutter/material.dart';
import 'package:roomie/classes/survey_data.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:roomie/screens/survey_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SurveyScreen(
        userData: UserData(
          surveyData: SurveyData(),
        ),
      ),
    );
  }
}
