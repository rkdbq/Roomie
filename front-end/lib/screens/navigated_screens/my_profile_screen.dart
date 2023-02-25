import 'package:flutter/material.dart';
import 'package:roomie/classes/random_color.dart';
import 'package:roomie/widgets/survey_questions/question_slider.dart';
import 'package:roomie/widgets/survey_questions/question_text_field.dart';

import '../../classes/survey_data.dart';
import '../../widgets/suggested_profile/suggested_profile.dart';
import '../../widgets/survey_questions/question_buttons.dart';

class MyProfileScreen extends StatefulWidget {
  late SurveyData surveyData;
  late List<Color> colors;
  MyProfileScreen({
    super.key,
    required this.surveyData,
    required this.colors,
  });

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 72,
                    ),
                    Container(
                      color: const Color(0xffeff1f3),
                      height: MediaQuery.of(context).size.height - 96 - 72 * 2,
                      child: Center(
                        child: SuggestedProfile(
                          color: const Color(0xffffffff),
                          major: "컴퓨터공학부",
                          studentNumber: "19",
                          dormitoryInfo: "새빛1관",
                          message: widget.surveyData.answers["기타"],
                          isMyProfile: true,
                        ),
                      ),
                    ),
                    myProfileQuestionSlider("취침시간", SleepAt(), 0),
                    myProfileQuestionSlider("기상시간", AwakeAt(), 1),
                    myProfileQuestionSlider("청소주기", CleaningPeriod(), 2),
                    myProfileQuestionSlider("관계", RelationshipWithRoomie(), 3),
                    myProfileQuestionSlider("잠버릇", SleepingHabit(), 4),
                    myProfileQuestionSlider("외향성", Extroversion(), 5),
                    myProfileQuestionButtons("흡연", Smoking(), 6),
                    myProfileQuestionButtons("이어폰", Earphone(), 7),
                    myProfileQuestionButtons("실내취식", IndoorDining(), 8),
                    myProfileQuestionButtons("실내통화", IndoorCalling(), 9),
                    myProfileQuestionTextField(
                        "기타", Etc(widget.surveyData), 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding myProfileQuestionSlider(
      String key, PossibleAnswer answer, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 128,
        decoration: BoxDecoration(
          color: widget.colors[index].withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: QuestionSlider(
          surveyData: widget.surveyData,
          surveyKey: key,
          surveyAnswer: answer,
          backgroundColor: widget.colors[index],
          titleFontSize: 14,
          titleSizedBoxHeight: 14,
          answerSizedBoxHeight: 14,
        ),
      ),
    );
  }

  Padding myProfileQuestionButtons(
      String key, PossibleAnswer answer, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 128,
        decoration: BoxDecoration(
          color: randomColor().withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: QuestionButtons(
          surveyData: widget.surveyData,
          surveyKey: key,
          surveyAnswer: answer,
          onPressed: () {},
          titleFontSize: 14,
          titleSizedBoxHeight: 24,
          buttonHeight: 64,
          buttonWidth: 96,
        ),
      ),
    );
  }

  Padding myProfileQuestionTextField(String key, Comment answer, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 196,
        decoration: BoxDecoration(
          color: widget.colors[index].withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: QuestionTextField(
          surveyData: widget.surveyData,
          surveyKey: key,
          answer: answer,
          colors: widget.colors,
          titleFontSize: 14,
          titleSizedBoxHeight: 14,
          isMyProfile: true,
          updateMyProfileCard: updateMyProfileCard,
        ),
      ),
    );
  }

  void updateMyProfileCard() {
    print("update");
    setState(() {});
  }
}
