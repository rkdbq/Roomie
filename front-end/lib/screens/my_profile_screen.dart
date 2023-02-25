import 'package:flutter/material.dart';

import '../classes/survey_data.dart';

class MyProfileScreen extends StatelessWidget {
  late SurveyData surveyData;
  MyProfileScreen({
    super.key,
    required this.surveyData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: const [],
            ),
          ),
        ],
      ),
    );
  }
}
