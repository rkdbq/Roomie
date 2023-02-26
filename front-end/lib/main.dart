import 'package:flutter/material.dart';
import 'package:roomie/classes/random_color.dart';
import 'package:roomie/classes/survey_data.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:roomie/screens/navigation_screen.dart';
import 'package:roomie/screens/survey_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  bool isSurveyDone = false;
  UserData myData = UserData(surveyData: SurveyData(), color: randomColor());
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isSurveyDone
          ? NavigationScreen(userData: myData)
          : SurveyScreen(userData: myData),
    );
  }
}
