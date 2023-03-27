import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:roomie/classes/survey_data.dart';

class UserData {
  String email, password;
  late String name, studentNumber, major, dormitoryInfo;
  late SurveyData surveyData;
  late Color color;

  UserData({
    this.studentNumber = "19",
    this.major = "컴퓨터공학부",
    this.dormitoryInfo = "새빛1관",
    required this.email,
    this.password = "",
    this.name = "",
    required this.surveyData,
    required this.color,
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
      password: "",
      name: data['name'],
      studentNumber: data['student_number'],
      major: data["major"],
      dormitoryInfo: data["dormitory_info"],
      color: Color(data["color"]),
      surveyData: surveyData,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "password": password,
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
    };
  }
}
