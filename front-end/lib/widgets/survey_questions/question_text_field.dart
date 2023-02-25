import 'package:flutter/material.dart';

import '../../classes/survey_data.dart';
import '../../screens/navigation_screen.dart';

class QuestionTextField extends StatefulWidget {
  late SurveyData surveyData;
  late String surveyKey;
  late Comment answer;
  late List<Color> colors;
  late bool isMyProfile;
  bool isSurveyDone = false;

  late double titleSizedBoxHeight;
  late double titleFontSize;

  TextEditingController textEditingController = TextEditingController();
  Function? updateMyProfileCard;

  QuestionTextField({
    super.key,
    required this.surveyData,
    required this.surveyKey,
    required this.answer,
    required this.colors,
    this.isMyProfile = false,
    this.titleFontSize = 24,
    this.titleSizedBoxHeight = 96,
    this.updateMyProfileCard,
  });

  @override
  State<QuestionTextField> createState() => _QuestionTextFieldState();
}

class _QuestionTextFieldState extends State<QuestionTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: !widget.isMyProfile,
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
            controller: widget.textEditingController,
            decoration: InputDecoration(
              helperText: widget.answer.helperText(),
              hintText: widget.answer.hintText(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSubmitted: (value) {
              if (!saveField()) return;
              if (widget.updateMyProfileCard != null) {
                widget.updateMyProfileCard!();
              }
            },
            onTapOutside: (event) {
              if (!saveField()) return;
              if (widget.updateMyProfileCard != null) {
                widget.updateMyProfileCard!();
              }
            },
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        surveyDoneButton(),
      ],
    );
  }

  bool saveField() {
    var field = widget.textEditingController.text;
    if (field.isEmpty) return false;
    widget.surveyData.answers[widget.surveyKey] =
        widget.textEditingController.text;
    print(widget.surveyData.answers);
    setState(
      () {
        widget.isSurveyDone = true;
      },
    );
    return true;
  }

  AnimatedOpacity surveyDoneButton() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: (widget.isSurveyDone && !widget.isMyProfile) ? 1 : 0,
      child: Visibility(
        visible: !widget.isMyProfile,
        child: TextButton(
          onPressed: () {
            if (!widget.isSurveyDone) return;
            if (!saveField()) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationScreen(
                  surveyData: widget.surveyData,
                  colors: widget.colors,
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
}
