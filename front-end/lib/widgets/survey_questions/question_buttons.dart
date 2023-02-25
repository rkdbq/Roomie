import 'package:flutter/material.dart';

import '../../classes/random_color.dart';
import '../../classes/survey_data.dart';

class QuestionButtons extends StatefulWidget {
  late SurveyData surveyData;
  late String surveyKey;
  late PossibleAnswer surveyAnswer;
  late Function() onPressed;
  late double titleSizedBoxHeight;
  late double titleFontSize;
  late double buttonWidth;
  late double buttonHeight;
  QuestionButtons({
    super.key,
    required this.surveyData,
    required this.surveyKey,
    required this.surveyAnswer,
    required this.onPressed,
    this.titleSizedBoxHeight = 128,
    this.titleFontSize = 24,
    this.buttonWidth = 128,
    this.buttonHeight = 96,
  });

  @override
  State<QuestionButtons> createState() => _QuestionButtonsState();
}

class _QuestionButtonsState extends State<QuestionButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${widget.surveyKey} ${widget.surveyAnswer.icon()}",
          style: TextStyle(
            fontSize: widget.titleFontSize,
          ),
        ),
        SizedBox(
          height: widget.titleSizedBoxHeight,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            questionButtonItem(
              widget.surveyKey,
              widget.surveyAnswer.items
                  .indexOf(widget.surveyAnswer.items.first),
              widget.surveyAnswer.items.first,
              randomColor(),
            ),
            const SizedBox(
              width: 48,
            ),
            questionButtonItem(
                widget.surveyKey,
                widget.surveyAnswer.items
                    .indexOf(widget.surveyAnswer.items.last),
                widget.surveyAnswer.items.last,
                randomColor()),
          ],
        ),
      ],
    );
  }

  TextButton questionButtonItem(
      String key, int itemType, String answer, Color backgroundColor) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: Size(widget.buttonWidth, widget.buttonHeight),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
      ),
      onPressed: () {
        widget.onPressed();
        setState(() {
          widget.surveyData.answers[key] = itemType;
          print(widget.surveyData.answers);
        });
      },
      child: Text(
        answer,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
