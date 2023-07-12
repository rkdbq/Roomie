import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:roomie/classes/survey_data.dart';

class UserData {
  String email;
  late String name, studentNumber, major, dormitoryInfo, searchTag;
  late SurveyData surveyData;
  late Color color;

  Map numToTag = {
    0: "none",
    1: "sleep_at",
    2: "awake_at",
    3: "cleaning_period",
    4: "sleeping_habits",
    5: "extroversion",
    6: "relationship",
    7: "smoking",
    8: "earphone",
    9: "indoor_eating",
    10: "indoor_calling",
  };

  Map tagToNum = {
    "none": 0,
    "sleep_at": 1,
    "awake_at": 2,
    "cleaning_period": 3,
    "sleeping_habits": 4,
    "extroversion": 5,
    "relationship": 6,
    "smoking": 7,
    "earphone": 8,
    "indoor_eating": 9,
    "indoor_calling": 10,
  };

  UserData({
    this.studentNumber = "19",
    this.major = "컴퓨터공학부",
    this.dormitoryInfo = "새빛1관",
    required this.email,
    this.name = "",
    required this.surveyData,
    required this.color,
    this.searchTag = "none",
  });

  factory UserData.fromFirestore(
    DocumentSnapshot snapshot,
  ) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    SurveyData surveyData = SurveyData();
    surveyData.answers.forEach(
      (key, value) {
        surveyData.answers[key] = data[key];
      },
    );
    return UserData(
      email: snapshot.id,
      name: data['name'],
      studentNumber: data['student_number'],
      major: data["major"],
      dormitoryInfo: data["dormitory_info"],
      color: Color(data["color"]),
      surveyData: surveyData,
      searchTag: data['search_tag'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "student_number": studentNumber,
      "major": major,
      "dormitory_info": dormitoryInfo,
      "color": color.value,
      "sleep_at": surveyData.answers["sleep_at"],
      "awake_at": surveyData.answers["awake_at"],
      "cleaning_period": surveyData.answers["cleaning_period"],
      "relationship": surveyData.answers["relationship"],
      "sleeping_habits": surveyData.answers["sleeping_habits"],
      "extroversion": surveyData.answers["extroversion"],
      "smoking": surveyData.answers["smoking"],
      "earphone": surveyData.answers["earphone"],
      "indoor_eating": surveyData.answers["indoor_eating"],
      "indoor_calling": surveyData.answers["indoor_calling"],
      "etc": surveyData.answers["etc"],
      "search_tag": searchTag,
    };
  }
}
