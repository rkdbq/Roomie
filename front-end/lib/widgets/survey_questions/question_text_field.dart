import 'package:flutter/material.dart';
import 'package:roomie/classes/user_data.dart';

import '../../classes/survey_data.dart';

class QuestionTextField extends StatefulWidget {
  late UserData userData;
  late String surveyKey;
  late Comment answer;
  late List<Color> colors;
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
    required this.colors,
    this.onSubmitted,
    this.onTapOutside,
    this.isDetailProfile = false,
    this.isMyProfile = true,
    this.titleFontSize = 24,
    this.titleSizedBoxHeight = 96,
    this.updateMyProfileCard,
  });

  @override
  State<QuestionTextField> createState() => _QuestionTextFieldState();
}

class _QuestionTextFieldState extends State<QuestionTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !widget.isDetailProfile,
          child: const SizedBox(
            height: 64,
          ),
        ),
        Text(
          "${widget.surveyKey} ${widget.answer.icon()}",
          style: TextStyle(
            fontSize: widget.titleFontSize,
          ),
        ),
        SizedBox(
          height: widget.titleSizedBoxHeight,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            readOnly: !widget.isMyProfile,
            controller: textEditingController,
            decoration: InputDecoration(
              helperText: widget.answer.helperText(),
              hintText: widget.answer.hintText(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSubmitted: (value) {
              if (textEditingController.text.isEmpty) return;
              if (textEditingController.text ==
                  widget.userData.surveyData.answers[widget.surveyKey]) return;
              widget.userData.surveyData.answers[widget.surveyKey] =
                  textEditingController.text;
              if (widget.onSubmitted != null) {
                widget.onSubmitted!();
              }
              if (widget.updateMyProfileCard != null) {
                widget.updateMyProfileCard!();
              }
              print(widget.userData.surveyData.answers);
            },
            onTapOutside: (event) {
              if (textEditingController.text.isEmpty) return;
              if (textEditingController.text ==
                  widget.userData.surveyData.answers[widget.surveyKey]) return;
              widget.userData.surveyData.answers[widget.surveyKey] =
                  textEditingController.text;
              if (widget.onTapOutside != null) {
                widget.onTapOutside!();
              }
              if (widget.updateMyProfileCard != null) {
                widget.updateMyProfileCard!();
              }
              print(widget.userData.surveyData.answers);
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
