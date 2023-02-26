import 'package:flutter/cupertino.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../classes/survey_data.dart';

class QuestionSlider extends StatefulWidget {
  late UserData userData;
  late String surveyKey;
  late PossibleAnswer surveyAnswer;
  late Color backgroundColor;
  late double titleSizedBoxHeight;
  late double titleFontSize;
  late double answerSizedBoxHeight;
  late bool isMyProfile;
  Function(dynamic value)? onChangeEnd;

  QuestionSlider({
    super.key,
    required this.userData,
    required this.surveyKey,
    required this.surveyAnswer,
    this.onChangeEnd,
    required this.backgroundColor,
    this.titleSizedBoxHeight = 128,
    this.titleFontSize = 24,
    this.answerSizedBoxHeight = 24,
    this.isMyProfile = true,
  });

  @override
  State<QuestionSlider> createState() => _QuestionSliderState();
}

class _QuestionSliderState extends State<QuestionSlider> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Text(widget.surveyAnswer
              .answer(widget.userData.surveyData.answers[widget.surveyKey])),
          SizedBox(
            height: widget.answerSizedBoxHeight,
          ),
          SfSlider(
            activeColor: widget.backgroundColor
                .withOpacity(widget.isMyProfile ? 1 : 0.2),
            inactiveColor: widget.backgroundColor.withOpacity(0.2),
            value: widget.userData.surveyData.answers[widget.surveyKey],
            min: 0,
            max: 4,
            interval: 1,
            showTicks: true,
            onChangeEnd: widget.onChangeEnd,
            onChanged: (value) {
              if (!widget.isMyProfile) return;
              var val = (value as double).round();
              setState(
                () {
                  widget.userData.surveyData.answers[widget.surveyKey] = val;
                  print(widget.userData.surveyData.answers);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
