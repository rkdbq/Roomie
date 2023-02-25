import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../classes/survey_data.dart';

class QuestionSlider extends StatefulWidget {
  late SurveyData surveyData;
  late String surveyKey;
  late PossibleAnswer surveyAnswer;
  late Color backgroundColor;
  late double titleSizedBoxHeight;
  late double titleFontSize;
  late double answerSizedBoxHeight;
  Function(dynamic value)? onChangeEnd;

  QuestionSlider({
    super.key,
    required this.surveyData,
    required this.surveyKey,
    required this.surveyAnswer,
    this.onChangeEnd,
    required this.backgroundColor,
    this.titleSizedBoxHeight = 128,
    this.titleFontSize = 24,
    this.answerSizedBoxHeight = 24,
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
              .answer(widget.surveyData.answers[widget.surveyKey])),
          SizedBox(
            height: widget.answerSizedBoxHeight,
          ),
          SfSlider(
            activeColor: widget.backgroundColor,
            inactiveColor: widget.backgroundColor.withOpacity(0.2),
            value: widget.surveyData.answers[widget.surveyKey],
            min: 0,
            max: 4,
            interval: 1,
            showTicks: true,
            onChangeEnd: widget.onChangeEnd,
            onChanged: (value) {
              var val = (value as double).round();
              setState(
                () {
                  widget.surveyData.answers[widget.surveyKey] = val;
                },
              );
            },
          )
        ],
      ),
    );
  }
}
