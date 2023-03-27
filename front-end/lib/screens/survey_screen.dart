import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roomie/screens/navigation_screen.dart';

import '../classes/survey_data.dart';
import '../classes/user_data.dart';
import '../themes/roomie_color.dart';
import '../widgets/survey_questions/question_buttons.dart';
import '../widgets/survey_questions/question_slider.dart';
import '../widgets/survey_questions/question_text_field.dart';

class SurveyScreen extends StatefulWidget {
  late UserData userData;
  SurveyScreen({
    super.key,
    required this.userData,
  });

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late List<bool> visibilities =
      List.filled(widget.userData.surveyData.answers.length, false);
  bool isSurveyDone = false;

  @override
  void initState() {
    visibilities[0] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return Scaffold(
      backgroundColor: RoomieColor.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          questionSlider("sleep_at", SleepAt(), 0),
          questionSlider("awake_at", AwakeAt(), 1),
          questionSlider("cleaning_period", CleaningPeriod(), 2),
          questionSlider("relationship", Relationship(), 3),
          questionSlider("sleeping_habits", SleepingHabits(), 4),
          questionSlider("extroversion", Extroversion(), 5),
          questionButtons("smoking", Smoking(), 6),
          questionButtons("earphone", Earphone(), 7),
          questionButtons("indoor_eating", IndoorEating(), 8),
          questionButtons("indoor_calling", IndoorCalling(), 9),
          questionTextField("etc", Etc(widget.userData), 10),
          surveyDoneButton(users),
        ],
      ),
    );
  }

  AnimatedOpacity questionTextField(String key, Comment answer, int index) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: visibilities[index] ? 1 : 0,
      child: Visibility(
        visible: visibilities[index],
        child: QuestionTextField(
          onSubmitted: () {
            setState(() {
              isSurveyDone = true;
            });
          },
          onTapOutside: () {
            setState(() {
              isSurveyDone = true;
            });
          },
          userData: widget.userData,
          surveyKey: key,
          answer: answer,
        ),
      ),
    );
  }

  AnimatedOpacity questionSlider(String key, PossibleAnswer answer, int index) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: visibilities[index] ? 1 : 0,
      child: Visibility(
        visible: visibilities[index],
        child: QuestionSlider(
          userData: widget.userData,
          surveyKey: key,
          surveyAnswer: answer,
          onChangeEnd: (value) {
            setState(
              () {
                visibilities[index] = false;
                if (visibilities.length > index + 1) {
                  visibilities[index + 1] = true;
                }
                print(widget.userData.surveyData.answers);
              },
            );
          },
          backgroundColor: widget.userData.color,
        ),
      ),
    );
  }

  AnimatedOpacity questionButtons(
      String key, PossibleAnswer answer, int index) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: visibilities[index] ? 1 : 0,
      child: Visibility(
        visible: visibilities[index],
        child: QuestionButtons(
          userData: widget.userData,
          surveyKey: key,
          surveyAnswer: answer,
          onPressed: () {
            setState(
              () {
                visibilities[index] = false;
                if (visibilities.length > index + 1) {
                  visibilities[index + 1] = true;
                }
              },
            );
          },
        ),
      ),
    );
  }

  AnimatedOpacity surveyDoneButton(CollectionReference users) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isSurveyDone ? 1 : 0,
      child: Visibility(
        child: TextButton(
          onPressed: () {
            if (!isSurveyDone) return;
            registration(widget.userData, users);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationScreen(
                  userData: widget.userData,
                ),
              ),
            );
          },
          child: const Text(
            "룸메이트 찾기",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Future<void> registration(UserData data, CollectionReference users) {
    return users
        .doc(data.email)
        .set(
          data.toFirestore(),
        )
        .then((value) => print("user added"))
        .catchError((error) => print("fail to add user: $error"));
  }
}
