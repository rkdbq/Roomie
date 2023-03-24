import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:roomie/themes/roomie_color.dart';
import 'package:roomie/widgets/survey_questions/question_slider.dart';
import 'package:roomie/widgets/survey_questions/question_text_field.dart';

import '../classes/survey_data.dart';
import 'profile_card/profile_card.dart';
import 'survey_questions/question_buttons.dart';

class DetailedProfile extends StatefulWidget {
  late UserData userData;
  late Function()? isScrolled;
  late bool isMine;

  DetailedProfile({
    super.key,
    required this.userData,
    required this.isMine,
    this.isScrolled,
  });

  @override
  State<DetailedProfile> createState() => _DetailedProfileState();
}

class _DetailedProfileState extends State<DetailedProfile> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    var flag = false;
    scrollController.addListener(
      () {
        if (flag || scrollController.offset > -150) return;
        if (widget.isScrolled != null) {
          widget.isScrolled!();
          flag = true;
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 44,
                    ),
                    Visibility(
                      visible: widget.isMine,
                      child: Container(
                        color: RoomieColor.background,
                        height:
                            MediaQuery.of(context).size.height - 96 - 72 * 2,
                        child: Center(
                          child: ProfileCard(
                            userData: widget.userData,
                            isMine: widget.isMine,
                          ),
                        ),
                      ),
                    ),
                    myProfileQuestionSlider("sleep_at", SleepAt(), 0),
                    myProfileQuestionSlider("awake_at", AwakeAt(), 1),
                    myProfileQuestionSlider(
                        "cleaning_period", CleaningPeriod(), 2),
                    myProfileQuestionSlider("relationship", Relationship(), 3),
                    myProfileQuestionSlider(
                        "sleeping_habits", SleepingHabits(), 4),
                    myProfileQuestionSlider("extroversion", Extroversion(), 5),
                    myProfileQuestionButtons("smoking", Smoking(), 6),
                    myProfileQuestionButtons("earphone", Earphone(), 7),
                    myProfileQuestionButtons(
                        "indoor_eating", IndoorEating(), 8),
                    myProfileQuestionButtons(
                        "indoor_calling", IndoorCalling(), 9),
                    myProfileQuestionTextField("etc", Etc(widget.userData), 10),
                    Visibility(
                      visible: !widget.isMine,
                      child: const SizedBox(
                        height: 72,
                      ),
                    ),
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
          color: widget.userData.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: QuestionSlider(
          userData: widget.userData,
          surveyKey: key,
          surveyAnswer: answer,
          backgroundColor: widget.userData.color,
          titleFontSize: 14,
          titleSizedBoxHeight: 14,
          answerSizedBoxHeight: 14,
          isMyProfile: widget.isMine,
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
          color: widget.userData.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: QuestionButtons(
          userData: widget.userData,
          surveyKey: key,
          surveyAnswer: answer,
          onPressed: () {},
          titleFontSize: 14,
          titleSizedBoxHeight: 24,
          buttonHeight: 64,
          buttonWidth: 96,
          isMyProfile: widget.isMine,
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
          color: widget.userData.color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: QuestionTextField(
          userData: widget.userData,
          surveyKey: key,
          answer: answer,
          titleFontSize: 14,
          titleSizedBoxHeight: 14,
          isDetailProfile: true,
          isMyProfile: widget.isMine,
          updateMyProfileCard: () {
            setState(() {
              final user = FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.userData.email);
              user.update({key: widget.userData.surveyData.answers[key]});
            });
          },
        ),
      ),
    );
  }
}
