import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roomie/classes/random_color.dart';
import 'package:roomie/classes/survey_data.dart';
import 'package:roomie/screens/navigation_screen.dart';
import 'package:roomie/screens/survey_screen.dart';
import 'package:roomie/themes/roomie_color.dart';

import 'classes/user_data.dart';

class Authentication extends StatelessWidget {
  final email, name, studentNumber;
  const Authentication({
    super.key,
    required this.email,
    required this.name,
    required this.studentNumber,
  });

  @override
  Widget build(BuildContext context) {
    final users = FirebaseFirestore.instance.collection("users");
    UserData myData =
        UserData(email: email, surveyData: SurveyData(), color: randomColor());
    myData.name = name;
    myData.studentNumber = studentNumber;
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(email).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return MaterialApp(
            home: SurveyScreen(userData: myData),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingContainer();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: NavigationScreen(
              userData: UserData.fromFirestore(snapshot.data!),
            ),
          );
        }

        return loadingContainer();
      },
    );
  }

  Container loadingContainer() {
    return Container(
      decoration: BoxDecoration(
        color: RoomieColor.background,
      ),
      child: Center(
        child: LoadingAnimationWidget.flickr(
            leftDotColor: RoomieColor.mainText,
            rightDotColor: RoomieColor.subText,
            size: 50),
      ),
    );
  }
}
