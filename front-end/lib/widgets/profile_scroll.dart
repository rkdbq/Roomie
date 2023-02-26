import 'package:flutter/material.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:roomie/widgets/survey_questions/question_slider.dart';
import 'package:roomie/widgets/survey_questions/question_text_field.dart';

import '../classes/survey_data.dart';
import 'profile_card/profile_card.dart';
import 'survey_questions/question_buttons.dart';

class ProfileScroll extends StatefulWidget {
  late UserData userData;
  late Function()? isScrolled;
  late bool isMyProfile;

  ProfileScroll({
    super.key,
    required this.userData,
    required this.isMyProfile,
    this.isScrolled,
  });

  @override
  State<ProfileScroll> createState() => _ProfileScrollState();
}

class _ProfileScrollState extends State<ProfileScroll> {
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
                      visible: widget.isMyProfile,
                      child: Container(
                        color: const Color(0xffeff1f3),
                        height:
                            MediaQuery.of(context).size.height - 96 - 72 * 2,
                        child: Center(
                          child: ProfileCard(
                            userData: widget.userData,
                            isMyProfile: widget.isMyProfile,
                          ),
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
                    myProfileQuestionTextField("기타", Etc(widget.userData), 10),
                    Visibility(
                      visible: !widget.isMyProfile,
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
          isMyProfile: widget.isMyProfile,
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
          isMyProfile: widget.isMyProfile,
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
          isMyProfile: widget.isMyProfile,
          updateMyProfileCard: updateMyProfileCard,
        ),
      ),
    );
  }

  void updateMyProfileCard() {
    setState(() {});
  }
}
