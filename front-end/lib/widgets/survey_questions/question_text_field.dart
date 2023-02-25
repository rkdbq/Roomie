import 'package:flutter/material.dart';

import '../../classes/survey_data.dart';
import '../../screens/navigation_screen.dart';

class QuestionTextField extends StatefulWidget {
  late SurveyData surveyData;
  late String surveyKey;
  late Comment answer;
  bool isSurveyDone = false;
  QuestionTextField({
    super.key,
    required this.surveyData,
    required this.surveyKey,
    required this.answer,
  });

  @override
  State<QuestionTextField> createState() => _QuestionTextFieldState();
}

class _QuestionTextFieldState extends State<QuestionTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 64,
        ),
        Text(
          "${widget.surveyKey} ${widget.answer.icon()}",
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 96,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(
              helperText: widget.answer.helperText(),
              hintText: widget.answer.hintText(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onSubmitted: (value) {
              widget.surveyData.answers[widget.surveyKey] = value;
              print(widget.surveyData.answers);
              setState(
                () {
                  widget.isSurveyDone = true;
                },
              );
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

  AnimatedOpacity surveyDoneButton() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: widget.isSurveyDone ? 1 : 0,
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationScreen(
                surveyData: widget.surveyData,
              ),
            ),
          );
        },
        child: const Text(
          "룸메이트 찾기",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
