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
    1: "smoking",
    2: "sleeping_habits",
    3: "relationship",
    4: "sleep_at",
    5: "room_cleaning",
    6: "restroom_cleaning",
    7: "inviting",
    8: "sharing",
    9: "calling",
    10: "earphone",
    11: "eating",
    12: "late_stand_using",
  };

  Map tagToNum = {
    "none": 0,
    "smoking": 1,
    "sleeping_habits": 2,
    "relationship": 3,
    "sleep_at": 4,
    "room_cleaning": 5,
    "restroom_cleaning": 6,
    "inviting": 7,
    "sharing": 8,
    "calling": 9,
    "earphone": 10,
    "eating": 11,
    "late_stand_using": 12,
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
      "room_cleaning": surveyData.answers["room_cleaning"],
      "restroom_cleaning": surveyData.answers["restroom_cleaning"],
      "sleeping_habits": surveyData.answers["sleeping_habits"],
      "smoking": surveyData.answers["smoking"],
      "earphone": surveyData.answers["earphone"],
      "eating": surveyData.answers["eating"],
      "calling": surveyData.answers["calling"],
      "inviting": surveyData.answers["inviting"],
      "sharing": surveyData.answers["sharing"],
      "relationship": surveyData.answers["relationship"],
      "late_stand_using": surveyData.answers["late_stand_using"],
      "etc": surveyData.answers["etc"],
      "search_tag": searchTag,
    };
  }
}
