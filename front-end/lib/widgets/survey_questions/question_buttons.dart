import 'package:flutter/material.dart';

import '../../classes/survey_data.dart';
import '../../classes/user_data.dart';

class QuestionButtons extends StatefulWidget {
  late UserData userData;
  late String surveyKey;
  late PossibleAnswer surveyAnswer;
  late Function() onPressed;
  late double titleSizedBoxHeight;
  late double titleFontSize;
  late double buttonWidth;
  late double buttonHeight;
  late bool isMyProfile;
  QuestionButtons({
    super.key,
    required this.userData,
    required this.surveyKey,
    required this.surveyAnswer,
    required this.onPressed,
    this.titleSizedBoxHeight = 128,
    this.titleFontSize = 24,
    this.buttonWidth = 128,
    this.buttonHeight = 96,
    this.isMyProfile = true,
  });

  @override
  State<QuestionButtons> createState() => _QuestionButtonsState();
}

class _QuestionButtonsState extends State<QuestionButtons> {
  List<Color> colors = [Colors.grey, Colors.grey];

  @override
  void initState() {
    var chosen = widget.userData.surveyData.answers[widget.surveyKey];
    colors[chosen] = widget.userData.color;
    super.initState();
  }

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
              colors[0],
            ),
            Visibility(
              visible: widget.isMyProfile ? true : false,
              child: const SizedBox(
                width: 48,
              ),
            ),
            questionButtonItem(
                widget.surveyKey,
                widget.surveyAnswer.items
                    .indexOf(widget.surveyAnswer.items.last),
                widget.surveyAnswer.items.last,
                colors[1]),
          ],
        ),
      ],
    );
  }

  Visibility questionButtonItem(
      String key, int itemType, String answer, Color backgroundColor) {
    return Visibility(
      visible: visibilityCheck(key, itemType),
      child: TextButton(
        style: TextButton.styleFrom(
          fixedSize: Size(widget.buttonWidth, widget.buttonHeight),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 5,
        ),
        onPressed: () {
          if (!widget.isMyProfile) return;
          widget.onPressed();
          setState(() {
            widget.userData.surveyData.answers[key] = itemType;
            print(widget.userData.surveyData.answers);
            toggleColor(0, 1);
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
      ),
    );
  }

  bool visibilityCheck(String key, int itemType) {
    return (widget.isMyProfile ||
            (widget.userData.surveyData.answers[key] == itemType))
        ? true
        : false;
  }

  void toggleColor(int index1, int index2) {
    RangeError.checkValidIndex(index1, colors, 'index1');
    RangeError.checkValidIndex(index2, colors, 'index2');
    var tmp = colors[index1];
    colors[index1] = colors[index2];
    colors[index2] = tmp;
  }
}
