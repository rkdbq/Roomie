import 'package:flutter/material.dart';
import 'package:roomie/classes/survey_data.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../classes/random_color.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({super.key});

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  late SurveyData surveyData;
  late List<bool> visibilities;
  late List<Color> colors;

  @override
  void initState() {
    surveyData = SurveyData();
    visibilities = List.filled(surveyData.answers.length, false);
    visibilities[0] = true;
    colors = List.filled(surveyData.answers.length, randomColor());
    print(visibilities);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff1f3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          questionSlider("취침시간", SleepAt(), 0),
          questionSlider("기상시간", AwakeAt(), 1),
          questionSlider("청소주기", CleaningPeriod(), 2),
          questionSlider("관계", RelationshipWithRoomie(), 3),
          questionSlider("잠버릇", SleepingHabit(), 4),
          questionSlider("외향성", Extroversion(), 5),
          questionButtons("흡연", ["🚬", "❌"], 6),
          questionButtons("이어폰", ["🎧", "❌"], 7),
          questionButtons("실내취식", ["🍜", "❌"], 8),
          questionButtons("실내통화", ["📞", "❌"], 9),
        ],
      ),
    );
  }

  AnimatedOpacity questionSlider(String key, Answer answer, int index) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: visibilities[index] ? 1 : 0,
      child: Visibility(
        visible: visibilities[index],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                key,
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 128,
              ),
              Text(answer.answer(surveyData.answers[key])),
              const SizedBox(
                height: 24,
              ),
              SfSlider(
                activeColor: colors[index],
                inactiveColor: colors[index].withOpacity(0.2),
                value: surveyData.answers[key],
                min: 0,
                max: 4,
                interval: 1,
                showTicks: true,
                onChangeEnd: (value) => setState(
                  () {
                    visibilities[index] = false;
                    if (visibilities.length > index + 1) {
                      visibilities[index + 1] = true;
                    }
                    print(surveyData.answers);
                  },
                ),
                onChanged: (dynamic value) {
                  var val = (value as double).round();
                  setState(
                    () {
                      surveyData.answers[key] = val;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedOpacity questionButtons(String key, List<String> answer, int index) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: visibilities[index] ? 1 : 0,
      child: Visibility(
        visible: visibilities[index],
        child: Column(
          children: [
            Text(
              key,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 128,
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                questionButtonItem(key, randomColor(), answer.first, 1, index),
                const SizedBox(
                  width: 48,
                ),
                questionButtonItem(key, randomColor(), answer.last, 0, index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextButton questionButtonItem(String key, Color backgroundColor,
      String answer, int itemType, int index) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: const Size(96, 96),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
      ),
      onPressed: () {
        setState(() {
          visibilities[index] = false;
          if (visibilities.length > index + 1) {
            visibilities[index + 1] = true;
          }
          surveyData.answers[key] = itemType;
          print(surveyData.answers);
        });
      },
      child: Text(
        answer,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
