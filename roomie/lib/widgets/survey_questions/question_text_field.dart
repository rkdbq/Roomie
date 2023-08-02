import 'package:flutter/material.dart';
import 'package:roomie/classes/user_data.dart';

import '../../classes/survey_data.dart';

class QuestionTextField extends StatelessWidget {
  late UserData userData;
  late String surveyKey;
  late Comment answer;
  late bool isDetailProfile;
  late bool isMyProfile;
  bool isSurveyDone = false;

  late double titleSizedBoxHeight;
  late double titleFontSize;

  Function()? updateMyProfileCard;
  Function()? onSubmitted;
  Function()? onTapOutside;

  QuestionTextField({
    super.key,
    required this.userData,
    required this.surveyKey,
    required this.answer,
    this.onSubmitted,
    this.onTapOutside,
    this.isDetailProfile = false,
    this.isMyProfile = true,
    this.titleFontSize = 24,
    this.titleSizedBoxHeight = 96,
    this.updateMyProfileCard,
  });

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !isDetailProfile,
          child: const SizedBox(
            height: 64,
          ),
        ),
        Text(
          "${answer.title()} ${answer.icon()}",
          style: TextStyle(
            fontSize: titleFontSize,
          ),
        ),
        SizedBox(
          height: titleSizedBoxHeight,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            readOnly: !isMyProfile,
            controller: textEditingController,
            decoration: InputDecoration(
              helperText: answer.helperText(),
              hintText: answer.hintText(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSubmitted: (value) {
              if (textEditingController.text.isEmpty) return;
              if (textEditingController.text ==
                  userData.surveyData.answers[surveyKey]) return;
              userData.surveyData.answers[surveyKey] =
                  textEditingController.text;
              if (onSubmitted != null) {
                onSubmitted!();
              }
              if (updateMyProfileCard != null) {
                updateMyProfileCard!();
              }
            },
            onTapOutside: (event) {
              if (textEditingController.text.isEmpty) return;
              if (textEditingController.text ==
                  userData.surveyData.answers[surveyKey]) return;
              userData.surveyData.answers[surveyKey] =
                  textEditingController.text;
              if (onTapOutside != null) {
                onTapOutside!();
              }
              if (updateMyProfileCard != null) {
                updateMyProfileCard!();
              }
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
