import 'dart:ui';

import 'package:roomie/classes/survey_data.dart';

class UserData {
  late String studentNumber, major, dormitoryInfo;
  late SurveyData surveyData;
  late Color color;

  UserData({
    this.studentNumber = "19",
    this.major = "컴퓨터공학부",
    this.dormitoryInfo = "새빛1관",
    required this.surveyData,
    required this.color,
  });
}
