import 'package:flutter/material.dart';

import '../classes/random_color.dart';
import '../classes/survey_data.dart';
import '../widgets/survey_questions/question_buttons.dart';
import '../widgets/survey_questions/question_slider.dart';
import '../widgets/survey_questions/question_text_field.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late SurveyData surveyData;
  late List<bool> visibilities;
  late List<Color> colors;
  bool isSurveyDone = false;

  @override
  void initState() {
    surveyData = SurveyData();
    visibilities = List.filled(surveyData.answers.length, false);
    visibilities[0] = true;
    colors = [];
    for (var i = 0; i < surveyData.answers.length; i++) {
      colors.add(randomColor());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff1f3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          questionSlider("취침시간", SleepAt(), 0),
          questionSlider("기상시간", AwakeAt(), 1),
          questionSlider("청소주기", CleaningPeriod(), 2),
          questionSlider("관계", RelationshipWithRoomie(), 3),
          questionSlider("잠버릇", SleepingHabit(), 4),
          questionSlider("외향성", Extroversion(), 5),
          questionButtons("흡연", Smoking(), 6),
          questionButtons("이어폰", Earphone(), 7),
          questionButtons("실내취식", IndoorDining(), 8),
          questionButtons("실내통화", IndoorCalling(), 9),
          questionTextField("기타", Etc(), 10),
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
          surveyData: surveyData,
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
          surveyData: surveyData,
          surveyKey: key,
          surveyAnswer: answer,
          onChangeEnd: (value) {
            setState(
              () {
                visibilities[index] = false;
                if (visibilities.length > index + 1) {
                  visibilities[index + 1] = true;
                }
                print(surveyData.answers);
              },
            );
          },
          color: colors[index],
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
          surveyData: surveyData,
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
}
