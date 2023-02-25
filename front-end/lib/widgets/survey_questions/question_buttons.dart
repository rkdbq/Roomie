import 'package:flutter/material.dart';

import '../../classes/random_color.dart';
import '../../classes/survey_data.dart';

class QuestionButtons extends StatefulWidget {
  late SurveyData surveyData;
  late String surveyKey;
  late PossibleAnswer surveyAnswer;
  late Function() onPressed;
  QuestionButtons({
    super.key,
    required this.surveyData,
    required this.surveyKey,
    required this.surveyAnswer,
    required this.onPressed,
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
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 128,
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
        fixedSize: const Size(128, 96),
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
