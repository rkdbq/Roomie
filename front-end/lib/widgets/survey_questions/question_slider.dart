import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../classes/survey_data.dart';

class QuestionSlider extends StatefulWidget {
  late SurveyData surveyData;
  late String surveyKey;
  late PossibleAnswer surveyAnswer;
  late Color color;
  late Function(dynamic value) onChangeEnd;
  QuestionSlider({
    super.key,
    required this.surveyData,
    required this.surveyKey,
    required this.surveyAnswer,
    required this.onChangeEnd,
    required this.color,
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
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 128,
          ),
          Text(widget.surveyAnswer
              .answer(widget.surveyData.answers[widget.surveyKey])),
          const SizedBox(
            height: 24,
          ),
          SfSlider(
            activeColor: widget.color,
            inactiveColor: widget.color.withOpacity(0.2),
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
